`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/16 21:32:03
// Design Name: 
// Module Name: Multifier
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


module Multifier(
input MU,
input [31:0] a,
input [31:0] b,
output [31:0] high,
output [31:0] low
);

wire [63:0] z1;
wire [63:0] z2;

MULT MUL1(a,b,z1);
MULTU MUL2(a,b,z2);

assign {high,low}=(MU)?z2:z1;

endmodule
