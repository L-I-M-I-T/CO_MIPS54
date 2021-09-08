`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/19 21:02:26
// Design Name: 
// Module Name: MIPS_CPU
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


module cpu(
input clk,
input reset,
input [31:0]instruction,
input [31:0]rdata,
output [31:0]pc,
output [31:0]addr,
output [31:0]wdata,
output IM_R,
output DM_CS,
output DM_R,
output DM_W,
output SB,
output SH
);

wire PC_CLK,PC_ENA,M1,M2,M3,M5,M7,M8,M10,RF_W,RF_CLK,B1,B2,B3,MU,DU,eret,mtc0,mfc0,cin1,cin2,HL_R,S1,S2,S3;
wire [1:0] M4;
wire [1:0] M6;
wire [1:0] M9;
wire [1:0] M11;
wire [1:0] M12;
wire [1:0] M13;
wire [4:0] ALUC;
wire z,c,n,o,a;
wire [54:0] INS;
wire [31:0] D_ALU;
wire [31:0] D_PC;
wire [31:0] D_NPC;
wire [31:0] D_RF;
wire [31:0] D_Rs;
wire [31:0] D_Rt;
wire [31:0] D_IM;
wire [31:0] D_DM;
wire [31:0] D_Mux1;
wire [31:0] D_Mux2;
wire [31:0] D_Mux3;
wire [31:0] D_Mux4;
wire [31:0] D_Mux5;
wire [4:0] D_Mux6;
wire [31:0] D_Mux7;
wire [31:0] D_Mux8;
wire [31:0] D_Mux9;
wire [31:0] D_Mux10;
wire [31:0] D_Mux11;
wire [31:0] D_Mux12;
wire [31:0] D_Mux13;
wire [31:0] D_EXT5;
wire [31:0] D_EXT16;
wire [31:0] D_S_EXT16;
wire [31:0] D_EXT18;
wire [31:0] D_ADD;
wire [31:0] D_ADD8;
wire [31:0] D_ADD4;
wire [31:0] D_BING;
wire [31:0] q;
wire [31:0] r;
wire [31:0] cause;
wire [31:0] epc_out;
wire [31:0] S_out;
wire [31:0] Hi_out;
wire [31:0] Lo_out;
wire [31:0] HL_out;
wire [31:0] CP0_out;
wire [31:0] num0;
wire [31:0] high;
wire [31:0] low;
wire [4:0] D_Rsc;
wire [4:0] D_Rtc;
wire [4:0] D_Rdc;
wire [1:0] HL_W;
wire [4:0] ADDR;

assign PC_ENA=1;
//assign pc={16'b0000000000000000,D_PC[15:0]};
assign pc=D_PC;
assign addr=D_ALU;
assign wdata=D_Rt;
assign SB=INS[41];
assign SH=INS[42];

instruction_decoder cpu_ins(instruction,INS);
micro_operation_producer cpu_opcode(clk,z,instruction,INS,PC_CLK,IM_R,M1,M2,M3,M4,M6,M7,M8,M9,M10,M11,M12,M13,ALUC,RF_W,RF_CLK,DM_W,DM_R,DM_CS,D_Rsc,D_Rtc,D_Rdc,B1,B2,B3,MU,DU,eret,mtc0,mfc0,cin1,cin2,HL_W,HL_R,S1,S2,S3);
pcreg2 pc_out(PC_CLK,reset,PC_ENA,D_Mux13,D_PC);
alu cpu_alu(D_Mux3,D_Mux10,ALUC,D_ALU,z,c,n,o);
regfile cpu_ref(RF_CLK,reset,RF_W,D_Rtc,D_Rsc,D_Mux6,D_Mux11,D_Rt,D_Rs);
mux_1_2 cpu_mux1(D_Mux8,D_Mux5,M1,D_Mux1);
mux_1_2 cpu_mux2(rdata,D_ALU,M2,D_Mux2);
mux_1_2 cpu_mux3(D_EXT5,D_Rs,M3,D_Mux3);
mux_2_4 cpu_mux4(D_Rt,D_S_EXT16,D_EXT16,0,M4,D_Mux4);
selector sel(B1,B2,B3,cpu_alu.n,cpu_alu.z,M5);
mux_1_2 cpu_mux5(D_NPC,D_ADD,M5,D_Mux5);
mux_2_4 cpu_mux6(D_Rtc,D_Rdc,5'b11111,0,M6,D_Mux6);
mux_1_2 cpu_mux7(D_Mux2,D_ADD8,M7,D_Mux7);
mux_1_2 cpu_mux8(D_BING,D_Rs,M8,D_Mux8);
ext5 cpu_ext5(instruction[10:6],D_EXT5);
ext16 cpu_ext16(instruction[15:0],D_EXT16);
s_ext16 cpu_s_ext16(instruction[15:0],D_S_EXT16);
ext18 cpu_ext18(instruction[15:0],D_EXT18);
add cpu_add(D_EXT18,D_NPC,D_ADD,ao);
add8 cpu_add8(D_PC,D_ADD8);
add4 cpu_npc(D_PC,D_NPC);
bing cpu_bing(D_PC[31:28],instruction[25:0],D_BING);
//以下为54条指令CPU新增部分
Counter cpu_counter(D_Rs,num0);
Divider cpu_divider(DU,D_Rs,D_Rt,q,r);
Multifier cpu_multifier(MU,D_Rs,D_Rt,high,low);
Loader cpu_loader(D_Mux7,S1,S2,S3,S_out);
mux_2_4 cpu_mux9(high,D_Rs,r,0,M9,D_Mux9);
mux_2_4 cpu_mux12(low,D_Rs,q,0,M12,D_Mux12);
HiLo cpu_hilo(clk,reset,D_Mux9,D_Mux12,HL_W,HL_R,HL_out);
Cause_list cpu_cause(cin1,cin2,cause);
CP0 cpu_CP0(clk,reset,mfc0,mtc0,pc,D_Rdc,D_Rt,cause,eret,CP0_out,epc_out);
mux_1_2 cpu_mux10(D_Mux4,0,M10,D_Mux10);
mux_2_4 cpu_mux11(num0,HL_out,CP0_out,S_out,M11,D_Mux11);
mux_2_4 cpu_mux13(D_Mux1,epc_out,32'h4,0,M13,D_Mux13);
endmodule


module selector(
input b1,
input b2,
input b3,
input n,
input z,
output o
);

assign o=(b1&(~b2)&(~b3)&z)|((~b1)&b2&(~b3)&(~z))|((~b1)&(~b2)&b3&((~n)|z));

endmodule
