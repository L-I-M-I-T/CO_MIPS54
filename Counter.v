`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/16 16:43:15
// Design Name: 
// Module Name: Counter
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


module Counter(
input [31:0] in,
output [31:0] num0
);

reg [31:0] num;
always @(in) begin
  casex(in)
    32'b1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx:num<=32'd0;
    32'b01xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx:num<=32'd1;
    32'b001xxxxxxxxxxxxxxxxxxxxxxxxxxxxx:num<=32'd2;
    32'b0001xxxxxxxxxxxxxxxxxxxxxxxxxxxx:num<=32'd3;
    32'b00001xxxxxxxxxxxxxxxxxxxxxxxxxxx:num<=32'd4;
    32'b000001xxxxxxxxxxxxxxxxxxxxxxxxxx:num<=32'd5;
    32'b0000001xxxxxxxxxxxxxxxxxxxxxxxxx:num<=32'd6;
    32'b00000001xxxxxxxxxxxxxxxxxxxxxxxx:num<=32'd7;
    32'b000000001xxxxxxxxxxxxxxxxxxxxxxx:num<=32'd8;
    32'b0000000001xxxxxxxxxxxxxxxxxxxxxx:num<=32'd9;
    32'b00000000001xxxxxxxxxxxxxxxxxxxxx:num<=32'd10;
    32'b000000000001xxxxxxxxxxxxxxxxxxxx:num<=32'd11;
    32'b0000000000001xxxxxxxxxxxxxxxxxxx:num<=32'd12;
    32'b00000000000001xxxxxxxxxxxxxxxxxx:num<=32'd13;
    32'b000000000000001xxxxxxxxxxxxxxxxx:num<=32'd14;
    32'b0000000000000001xxxxxxxxxxxxxxxx:num<=32'd15;
    32'b00000000000000001xxxxxxxxxxxxxxx:num<=32'd16;
    32'b000000000000000001xxxxxxxxxxxxxx:num<=32'd17;
    32'b0000000000000000001xxxxxxxxxxxxx:num<=32'd18;
    32'b00000000000000000001xxxxxxxxxxxx:num<=32'd19;
    32'b000000000000000000001xxxxxxxxxxx:num<=32'd20;
    32'b0000000000000000000001xxxxxxxxxx:num<=32'd21;
    32'b00000000000000000000001xxxxxxxxx:num<=32'd22;
    32'b000000000000000000000001xxxxxxxx:num<=32'd23;
    32'b0000000000000000000000001xxxxxxx:num<=32'd24;
    32'b00000000000000000000000001xxxxxx:num<=32'd25;
    32'b000000000000000000000000001xxxxx:num<=32'd26;
    32'b0000000000000000000000000001xxxx:num<=32'd27;
    32'b00000000000000000000000000001xxx:num<=32'd28;
    32'b000000000000000000000000000001xx:num<=32'd29;
    32'b0000000000000000000000000000001x:num<=32'd30;
    32'b00000000000000000000000000000001:num<=32'd31;
    32'b00000000000000000000000000000000:num<=32'd32;
  endcase
end

assign num0=num;

endmodule
