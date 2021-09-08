`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/10 09:59:16
// Design Name: 
// Module Name: DIV
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

module DIV(
input [31:0]d1,
input [31:0]d2,
output [31:0] q,
output [31:0] r
);

wire [31:0] rt1;
wire [31:0] qt1;
wire [32:0] rt2;
wire [32:0] qt2;
wire [32:0] ext1;
wire [32:0] ext2;
wire [31:0] dividend;
wire [31:0] divisor;
wire td1,td2;

assign ext1=-{d1[31],d1};
assign ext2=-{d2[31],d2};
assign td1=d1[31];
assign td2=d2[31];
assign dividend=td1?ext1[31:0]:d1;
assign divisor=td2?ext2[31:0]:d2;
assign qt1=dividend/divisor;
assign rt1=dividend%divisor;
assign rt2=(td1)?(-{rt1[31],rt1}):{rt1[31],rt1};
assign qt2=(td1^td2)?(-{qt1[31],qt1}):{qt1[31],qt1};
assign r=rt2[31:0];
assign q=qt2[31:0];
endmodule
/*
module DIV(
input [31:0] dividend,
input [31:0] divisor,
input start,
input clock,
input reset,
output [31:0] q,
output [31:0] r,
output reg busy
);

reg [4:0] count;
reg [31:0] reg_q;
reg [31:0] reg_r;
reg [31:0] reg_b;
reg sign,busy_t;
wire [32:0] sub_add;
reg [32:0] ext1;
reg [32:0] ext2;
wire [31:0] rt1;
wire [31:0] qt1;
wire [32:0] rt2;
wire [32:0] qt2;
wire ready;
wire [31:0] qq;
reg td1,td2;
assign sub_add=sign?({reg_r,qq[31]}+{1'b0,reg_b}):({reg_r,qq[31]}-{1'b0,reg_b});
assign ready=~busy&busy_t;
assign rt1=sign?reg_r+reg_b:reg_r;
assign qt1=reg_q;
assign rt2=(td1)?(-{rt1[31],rt1}):{rt1[31],rt1};
assign qt2=(td1^td2)?(-{qt1[31],qt1}):{qt1[31],qt1};
assign r=rt2[31:0];
assign q=qt2[31:0];
assign qq=reg_q;

always @(posedge clock or posedge reset) begin
    if (reset==1) begin
        td1<=1'b0;
        td2<=1'b0;    
        count<=5'b0;
        busy<=0;
        busy_t<=0;
        reg_r<=32'b0;
        reg_q<=32'b0;
        reg_b<=32'b0;
    end
    else begin
        busy_t<=busy;
        if (start) begin
            td1<=dividend[31];
            td2<=divisor[31];
            reg_r<=32'b0;
            sign<=0;
            ext1=-{dividend[31],dividend};
            reg_q=(dividend[31]==1)?ext1[31:0]:dividend;
            ext2=-{divisor[31],divisor};
            reg_b=(divisor[31]==1)?ext2[31:0]:divisor;
            count<=5'b0;
            busy<=1'b1;
        end
        else 
        if (busy) begin
            reg_r<=sub_add[31:0];
            sign<=sub_add[32];
            reg_q<={reg_q[30:0],~sub_add[32]};
            count<=count+5'b1;
            if (count==5'd31) busy<=0;
        end
    end
end
         
endmodule
*/