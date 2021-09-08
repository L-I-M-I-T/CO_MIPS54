`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/12 17:16:56
// Design Name: 
// Module Name: CP0
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

module CP0(
input clk,
input rst,
input mfc0,
input mtc0,
input [31:0] pc,
input [4:0] addr,
input [31:0] data,
input [31:0] cause,
input eret,
output [31:0] CP0_out,
output [31:0] epc_out
);              

reg [31:0] cp0 [0:31];
wire [31:0] status;
wire exception;

integer i;    
assign status=cp0[12];
assign exception=status[0]&&((status[1]&&cause[6:2]==5'b01000)||(status[2]&&cause[6:2]==5'b01001)||(status[3]&&cause[6:2]==5'b01101));

always@(negedge clk or posedge rst) begin
  if (rst) begin
    for (i=0;i<32;i=i+1)
      cp0[i]<=0;
  end
  else begin
    if (mtc0) begin
      cp0[addr]<=data;
    end 
    else if (exception) begin
      cp0[12]<=status<<5;
      cp0[13]<=cause;
      cp0[14]<=pc;
    end
    else if (eret) begin
      cp0[12]<=status>>5;
    end
  end 
end
assign epc_out=eret?cp0[14]:32'h4;
assign CP0_out=cp0[addr];

endmodule
