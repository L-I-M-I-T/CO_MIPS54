`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/19 18:16:39
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module alu(
input [31:0]a,        
input [31:0]b,       
input [4:0]al,  
output [31:0]r,
output z,
output c,
output n,
output o
);
 
reg [32:0] r1;
//行为级ALU,r1暂存运算结果，r2辅助运算便于判断是否溢出，ta和tb将a、b转化为有符号数便于进行有符号数运算
 
wire signed [31:0] ta;
wire signed [31:0] tb;
wire [63:0] z1;
wire [63:0] z2;
wire [3:0] aluc;
wire mul;
assign ta=a;
assign tb=b;
assign z1=ta*tb;

always@ (al or a or b) 
begin
  casez(al)
    5'b00000:begin r1<=a+b;end//ADDU，运算过程中使用双符号位便于判断溢出
    5'b00010:begin r1<={a[31],a}+{b[31],b};end//ADD
    5'b00001:begin r1<=a-b;end//SUBU，运算过程中使用双符号位便于判断溢出
    5'b00011:begin r1<={a[31],a}-{b[31],b};end//SUB
    5'b00100:begin r1<=a&b;end//AND
    5'b00101:begin r1<=a|b;end//OR
    5'b00110:begin r1<=a^b;end//XOR
    5'b00111:begin r1<=~(a|b);end//NOR
    5'b0100?:begin r1<={b[15:0],16'b0};end//LUI
    5'b01011:begin r1<=(ta<tb)?1:0;end//SLT
    5'b01010:begin r1<=(a<b)?1:0;end//SLTU
    5'b01100:begin if(a==0) {r1[31:0],r1[32]}<={b,1'b0};else {r1[31:0],r1[32]}<=tb>>>(ta-1);end//SRA，运算过程中附加一位实现记录最后移出去的一位
    5'b0111?:begin r1<=b<<a;end//SLL/SLR
    5'b01101:begin if(a==0) {r1[31:0],r1[32]}<={b,1'b0};else {r1[31:0],r1[32]}<=b>>(a-1);end//SRL，运算过程中附加一位实现记录最后移出去的一位
    default:;
  endcase
end

assign aluc=al[3:0];
assign z2=r1[31:0];
assign mul=al[4];
assign r=(mul)?{z1[31:0]}:{z2[31:0]};
assign c=(aluc==4'b0000|aluc==4'b0001|aluc==4'b1010|aluc==4'b1100|aluc==4'b1101|aluc==4'b1111|aluc==4'b1110)?r1[32]:1'b0;//无符号数加法运算发生上溢或无符号数减法发生下溢或无符号数比较运算a-b<0时该标志位为1。移位运算该标志位为最后一次被移出的位的数值。
assign z=(r1==32'b0)?1:0;//z=1表示运算结果为0,z=0表示运算结果不为0，所有运算均影响此标志位。
assign n=r[31];//有符号数运算，操作数和结果均用二进制补码的形式表示，n=1表示结果为负数，n=0表示结果为正数或零。其他运算最终结果r[31]为1则n为1。
assign o=(aluc==4'b0010|aluc==4'b0011)?(r1[32]^r1[31]):1'b0;//对于有符号加减法运算，操作数和运算结果均用二进制补码的形式表示，有溢出时该标志位o=1。

endmodule

