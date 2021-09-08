`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/16 21:22:13
// Design Name: 
// Module Name: Divider
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


module Divider(
input DU,
input [31:0] dividend,
input [31:0] divisor,
output [31:0] q,
output [31:0] r
);

wire [31:0] q1;
wire [31:0] q2;
wire [31:0] r1;
wire [31:0] r2;
wire [31:0] d;


assign d=(divisor==32'b00000000000000000000000000000000)?32'b01000000000000000000000000000001:divisor;
DIV DIV1(dividend,d,q1,r1);
DIVU DIV2(dividend,d,q2,r2);

assign q=(DU)?q2:q1;
assign r=(DU)?r2:r1;

endmodule
