`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/14 23:46:11
// Design Name: 
// Module Name: MULTU
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


module MULTU(
input [31:0] a,
input [31:0] b,
output [63:0] z
);

wire [63:0] a1;

assign a1={32'b00000000000000000000000000000000,a};
assign z=((b[0]?a1:64'b0)+((b[1]==1)?(a1<<1):64'b0)+((b[2]==1)?(a1<<2):64'b0)+((b[3]==1)?(a1<<3):64'b0)+((b[4]==1)?(a1<<4):64'b0)+((b[5]==1)?(a1<<5):64'b0)+((b[6]==1)?(a1<<6):64'b0)+((b[7]==1)?(a1<<7):64'b0)+((b[8]==1)?(a1<<8):64'b0)+((b[9]==1)?(a1<<9):64'b0)+((b[10]==1)?(a1<<10):64'b0)+((b[11]==1)?(a1<<11):64'b0)+((b[12]==1)?(a1<<12):64'b0)+((b[13]==1)?(a1<<13):64'b0)+((b[14]==1)?(a1<<14):64'b0)+((b[15]==1)?(a1<<15):64'b0)+((b[16]==1)?(a1<<16):64'b0)+((b[17]==1)?(a1<<17):64'b0)+((b[18]==1)?(a1<<18):64'b0)+((b[19]==1)?(a1<<19):64'b0)+((b[20]==1)?(a1<<20):64'b0)+((b[21]==1)?(a1<<21):64'b0)+((b[22]==1)?(a1<<22):64'b0)+((b[23]==1)?(a1<<23):64'b0)+((b[24]==1)?(a1<<24):64'b0)+((b[25]==1)?(a1<<25):64'b0)+((b[26]==1)?(a1<<26):64'b0)+((b[27]==1)?(a1<<27):64'b0)+((b[28]==1)?(a1<<28):64'b0)+((b[29]==1)?(a1<<29):64'b0)+((b[30]==1)?(a1<<30):64'b0)+((b[31]==1)?(a1<<31):64'b0));

endmodule