`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/20 00:52:30
// Design Name: 
// Module Name: DMEM
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


module DMEM(
input clk,
input [10:0] addr,
input cs,r,w,SB,SH,
input [31:0] rdata,
output [31:0] wdata
);
reg [31:0] mem [0:2047];

always @(posedge clk) begin
    if (cs&w) begin
      if (SB)
		mem[addr][7:0]<=rdata[7:0];
      else 
      if (SH)
		mem[addr][15:0]<=rdata[15:0];
	  else
	    mem[addr]<=rdata;
	end
end

assign wdata = r?mem[addr]:32'hzzzzzzzz;

endmodule
