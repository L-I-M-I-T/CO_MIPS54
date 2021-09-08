`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/09 20:33:46
// Design Name: 
// Module Name: DIVU
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

module DIVU(
input [31:0] dividend,
input [31:0] divisor,
output [31:0] q,
output [31:0] r
);

assign q=(divisor==32'b00000000000000000000000000000000)?(32'b00000000000000000000000000000000):(dividend/divisor);
assign r=(divisor==32'b00000000000000000000000000000000)?(32'b00000000000000000000000000000000):(dividend%divisor);
endmodule
/*
module DIVU(
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
wire ready;
assign sub_add=sign?({reg_r,q[31]}+{1'b0,reg_b}):({reg_r,q[31]}-{1'b0,reg_b});
assign ready=~busy&busy_t;
assign r=sign?reg_r+reg_b:reg_r;
assign q=reg_q;

always @(posedge clock or posedge reset) begin
    if (reset==1) begin
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
            reg_r<=32'b0;
            sign<=0;
            reg_q<=dividend;
            reg_b<=divisor;
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
         
endmodule*/
