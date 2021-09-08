`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/16 17:29:09
// Design Name: 
// Module Name: HiLo
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


module HiLo(
input clk,
input rst,
input [31:0] Hi_in,
input [31:0] Lo_in,
input [1:0] HL_W,
input HL_R,
output [31:0] HL_out
);

reg [31:0] Hi;
reg [31:0] Lo;

always @(negedge clk or posedge rst) begin
  Hi<=(rst)?0:((HL_W[1])?Hi_in:Hi);
  Lo<=(rst)?0:((HL_W[0])?Lo_in:Lo);
end

assign HL_out=(HL_R)?Hi:Lo;

endmodule
