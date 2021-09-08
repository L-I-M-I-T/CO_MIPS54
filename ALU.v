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
//��Ϊ��ALU,r1�ݴ���������r2������������ж��Ƿ������ta��tb��a��bת��Ϊ�з��������ڽ����з���������
 
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
    5'b00000:begin r1<=a+b;end//ADDU�����������ʹ��˫����λ�����ж����
    5'b00010:begin r1<={a[31],a}+{b[31],b};end//ADD
    5'b00001:begin r1<=a-b;end//SUBU�����������ʹ��˫����λ�����ж����
    5'b00011:begin r1<={a[31],a}-{b[31],b};end//SUB
    5'b00100:begin r1<=a&b;end//AND
    5'b00101:begin r1<=a|b;end//OR
    5'b00110:begin r1<=a^b;end//XOR
    5'b00111:begin r1<=~(a|b);end//NOR
    5'b0100?:begin r1<={b[15:0],16'b0};end//LUI
    5'b01011:begin r1<=(ta<tb)?1:0;end//SLT
    5'b01010:begin r1<=(a<b)?1:0;end//SLTU
    5'b01100:begin if(a==0) {r1[31:0],r1[32]}<={b,1'b0};else {r1[31:0],r1[32]}<=tb>>>(ta-1);end//SRA����������и���һλʵ�ּ�¼����Ƴ�ȥ��һλ
    5'b0111?:begin r1<=b<<a;end//SLL/SLR
    5'b01101:begin if(a==0) {r1[31:0],r1[32]}<={b,1'b0};else {r1[31:0],r1[32]}<=b>>(a-1);end//SRL����������и���һλʵ�ּ�¼����Ƴ�ȥ��һλ
    default:;
  endcase
end

assign aluc=al[3:0];
assign z2=r1[31:0];
assign mul=al[4];
assign r=(mul)?{z1[31:0]}:{z2[31:0]};
assign c=(aluc==4'b0000|aluc==4'b0001|aluc==4'b1010|aluc==4'b1100|aluc==4'b1101|aluc==4'b1111|aluc==4'b1110)?r1[32]:1'b0;//�޷������ӷ����㷢��������޷�������������������޷������Ƚ�����a-b<0ʱ�ñ�־λΪ1����λ����ñ�־λΪ���һ�α��Ƴ���λ����ֵ��
assign z=(r1==32'b0)?1:0;//z=1��ʾ������Ϊ0,z=0��ʾ��������Ϊ0�����������Ӱ��˱�־λ��
assign n=r[31];//�з��������㣬�������ͽ�����ö����Ʋ������ʽ��ʾ��n=1��ʾ���Ϊ������n=0��ʾ���Ϊ�������㡣�����������ս��r[31]Ϊ1��nΪ1��
assign o=(aluc==4'b0010|aluc==4'b0011)?(r1[32]^r1[31]):1'b0;//�����з��żӼ������㣬�����������������ö����Ʋ������ʽ��ʾ�������ʱ�ñ�־λo=1��

endmodule

