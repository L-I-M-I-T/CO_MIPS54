`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/16 17:59:49
// Design Name: 
// Module Name: Cause_list
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


module Cause_list(
input in1,
input in2,
output [31:0] cause
);

reg [31:0] c;
always @(in1 or in2) begin
  case({in1,in2})
    2'b00:c<=32'b0000000000000000000000000100000;
    2'b01:c<=32'b0000000000000000000000000100100;
    2'b10:c<=32'b0000000000000000000000000110100;
    2'b11:c<=32'b0000000000000000000000000000000;
    default:;
  endcase
end
assign cause=c;
endmodule
