`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/19 10:37:35
// Design Name: 
// Module Name: micro_operation_producer
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


module micro_operation_producer(
input clk,
input z,
input [31:0] instruction_code,
input [54:0] instruction_type,
output PC_CLK,    
output IM_R,     
output M1,       
output M2,        
output M3,        
output [1:0]M4,            
output [1:0]M6,  
output M7,
output M8,
output [1:0]M9,
output M10,
output [1:0]M11,
output [1:0]M12,
output [1:0]M13,
output [4:0]ALUC,
output RF_W,     
output RF_CLK,   
output DM_W,   
output DM_R,     
output DM_CS,
output [4:0]Rsc,
output [4:0]Rtc,
output [4:0]Rdc,
output B1,
output B2,
output B3,
output MU,
output DU,
output eret,
output mtc0,
output mfc0,
output cin1,
output cin2,
output [1:0]HL_W,
output HL_R,
output S1,
output S2,
output S3
);
//微操作序列产生部件，根据指令类型，通过组合逻辑电路生成控制信号

assign PC_CLK=clk;
assign IM_R=1;//IM_R=1
assign M1=~(instruction_type[16]|instruction_type[29]|instruction_type[30]|instruction_type[36]);//M1=~(jr+j+jal+jalr)
assign M2=~(instruction_type[23]|instruction_type[37]|instruction_type[38]|instruction_type[39]|instruction_type[40]);//M2=~(lw+lbu+lhu+lb+lh)
assign M3=~(instruction_type[10]|instruction_type[11]|instruction_type[12]);//M3=~(sll+srl+sra)
assign M4[0]=instruction_type[17]|instruction_type[18]|instruction_type[27]|instruction_type[28]|instruction_type[23]|instruction_type[24]|instruction_type[37]|instruction_type[38]|instruction_type[39]|instruction_type[40]|instruction_type[41]|instruction_type[42];//M4_1=addiu+addi+slti+sltiu+lw+sw+lbu+lhu+lb+lh+sb+sh
assign M4[1]=instruction_type[19]|instruction_type[20]|instruction_type[21]|instruction_type[22];//M4_2=ori+xori+andi+lui
assign M6[0]=~(instruction_type[17]|instruction_type[18]|instruction_type[19]|instruction_type[20]|instruction_type[21]|instruction_type[22]|instruction_type[23]|instruction_type[27]|instruction_type[28]|instruction_type[30]|instruction_type[37]|instruction_type[38]|instruction_type[39]|instruction_type[40]|instruction_type[50]);//M6_1=~(addi+addiu+andi+ori+xori+lw+slti+sltiu+lui+lbu+lhu+lb+lh+mfc0)
assign M6[1]=instruction_type[30];//M6_2=jal
assign M7=instruction_type[30]|instruction_type[36];//M7=jal+jalr
assign M8=instruction_type[16]|instruction_type[36];//M8=jr+jalr
assign RF_W=~(instruction_type[16]|instruction_type[24]|instruction_type[25]|instruction_type[26]|instruction_type[29]|instruction_type[31]|instruction_type[32]|instruction_type[33]|instruction_type[34]|instruction_type[35]||instruction_type[41]|instruction_type[42]|instruction_type[43]|instruction_type[44]|instruction_type[45]|instruction_type[48]|instruction_type[49]|instruction_type[51]|instruction_type[53]);//RF_W=~(jr+sw+beq+bne+bgez+j+mtc0+mthi+mtlo+mul+multu+div+divu+syscall+eret+break+teq+sh+sb)
assign RF_CLK=clk;
assign ALUC[0]=instruction_type[2]|instruction_type[3]|instruction_type[5]|instruction_type[7]|instruction_type[8]|instruction_type[11]|instruction_type[14]|instruction_type[20]|instruction_type[25]|instruction_type[26]|instruction_type[27]|instruction_type[35]|instruction_type[53];//A0=sub+subu+or+nor+slt+srl+srlv+ori+beq+bne+slti+bgez+teq
assign ALUC[1]=instruction_type[0]|instruction_type[2]|instruction_type[6]|instruction_type[7]|instruction_type[8]|instruction_type[9]|instruction_type[10]|instruction_type[13]|instruction_type[17]|instruction_type[21]|instruction_type[27]|instruction_type[28];//A1=add+sub+xor+nor+slt+sltu+sll+sllv+addi+slti+sltiu+xori+sll
assign ALUC[2]=instruction_type[4]|instruction_type[5]|instruction_type[6]|instruction_type[7]|instruction_type[10]|instruction_type[11]|instruction_type[12]|instruction_type[13]|instruction_type[14]|instruction_type[15]|instruction_type[19]|instruction_type[20]|instruction_type[21];//A2=and+or+xor+nor+sll+srl+sra+sllv+srlv+srav+andi+ori+xori
assign ALUC[3]=instruction_type[8]|instruction_type[9]|instruction_type[10]|instruction_type[11]|instruction_type[12]|instruction_type[13]|instruction_type[14]|instruction_type[15]|instruction_type[22]|instruction_type[27]|instruction_type[28];//A3=slt+sltu+sll+srl+sra+sllv+srlv+srav+slti+sltiu+lui
assign ALUC[4]=instruction_type[54];//A4=mul
assign DM_W=instruction_type[24]|instruction_type[41]|instruction_type[42];//DM_w=sw+sb+sh
assign DM_R=instruction_type[23]|instruction_type[37]|instruction_type[38]|instruction_type[39]|instruction_type[40];//DM_r=lw+lbu+lhu+lb+lh
assign DM_CS=instruction_type[23]|instruction_type[24]|instruction_type[37]|instruction_type[38]|instruction_type[39]|instruction_type[40]|instruction_type[41]|instruction_type[42];//DM_cs=lw+lbu+lhu+lb+lh+sw+sb+sh
assign Rsc=instruction_code[25:21];
assign Rtc=instruction_code[20:16];
assign Rdc=(instruction_type[17]|instruction_type[18]|instruction_type[19]|instruction_type[20]|instruction_type[21]|instruction_type[22]|instruction_type[27]|instruction_type[28])?instruction_code[20:16]:instruction_code[15:11];
assign B1=instruction_type[25];//B1=beq
assign B2=instruction_type[26];//B2=bne
assign B3=instruction_type[35];//B3=bgez
//以下为54条指令CPU新增
assign DU=instruction_type[32];//DU=divu
assign MU=instruction_type[34];//MU=multu
assign eret=instruction_type[45];//eret=eret
assign mtc0=instruction_type[51];//mtc0=mtc0
assign mfc0=1;
assign cin1=~(instruction_type[43]|instruction_type[44]);//cin1=~(syscall+break)
assign cin2=~(instruction_type[44]|instruction_type[53]);//cin2=~(syscall+teq)
assign HL_W[1]=instruction_type[48]|instruction_type[31]|instruction_type[32]|instruction_type[33]|instruction_type[34];//HL_W[1]=mthi+multu+mult+divu+div
assign HL_W[0]=instruction_type[49]|instruction_type[31]|instruction_type[32]|instruction_type[33]|instruction_type[34];//HL_W[0]=mtlo+multu+mult+divu+div
assign HL_R=instruction_type[46];//HL_R=mfhi
assign S1=instruction_type[39];//S1=sb
assign S2=instruction_type[37]|instruction_type[40];//S2=lbu+lh
assign S3=instruction_type[38]|instruction_type[40];//S3=lhu+lh
assign M9[1]=~(instruction_type[33]|instruction_type[34]|instruction_type[48]);//M9_1=~(multu+mult+mthi)
assign M9[0]=~(instruction_type[31]|instruction_type[32]|instruction_type[33]|instruction_type[34]);//M9_0=~(multu+mult+divu+div)
assign M12[1]=~(instruction_type[33]|instruction_type[34]|instruction_type[49]);//M12_1=~(multu+mult+mtlo)
assign M12[0]=~(instruction_type[31]|instruction_type[32]|instruction_type[33]|instruction_type[34]);//M12_0=~(multu+mult+divu+div)
assign M13[1]=instruction_type[43]|instruction_type[44]|instruction_type[53];//M13_1=syscall+break+teq
assign M13[0]=instruction_type[45];//M13_0=eret
assign M11[1]=~(instruction_type[52]|instruction_type[46]|instruction_type[47]);//M11_1=~(clz+mfhi+mflo)
assign M11[0]=~(instruction_type[52]|instruction_type[50]);//M11_0=~(clz+mfc0)
assign M10=instruction_type[35];//M10=bgez

endmodule
