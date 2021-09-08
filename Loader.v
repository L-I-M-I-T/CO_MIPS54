`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/16 16:32:35
// Design Name: 
// Module Name: Loader
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


module Loader(
input [31:0] L,
input S1,
input S2,
input S3,
output [31:0] S_out
);

reg [31:0] S;
always@(L or S1 or S2 or S3) begin
  case ({S1,S2,S3})//2-4Â·Ñ¡ÔñÆ÷
    3'b000:S<=L;
    3'b001:S<={16'b0,L[15:0]};
    3'b010:S<={24'b0,L[7:0]};
    3'b011:S<={{16{L[15]}},L[15:0]};
    3'b100:S<={{24{L[7]}},L[7:0]};
  endcase
end
assign S_out=S;
endmodule
