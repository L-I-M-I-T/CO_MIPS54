`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/19 10:11:25
// Design Name: 
// Module Name: instrcution_decoder
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


module instruction_decoder( input [31:0] instruction_code,output reg[54:0] instruction_type);
//指令译码器，输入为接收到的指令，输出为对应的指令类型
wire [12:0] temp;
assign temp = {instruction_code[31:26],instruction_code[5:0],instruction_code[23]};
//32~26为op，5~0为func，通过这两者判断指令类型，使用54位寄存器，表示是置1的位对应的指令类型

always @ (temp) begin
casez(temp)
   13'b000000100000?:instruction_type<=1<<0;//ADD
   13'b000000100001?:instruction_type<=1<<1;//ADDU
   13'b000000100010?:instruction_type<=1<<2;//SUB
   13'b000000100011?:instruction_type<=1<<3;//SUBU
   13'b000000100100?:instruction_type<=1<<4;//AND
   13'b000000100101?:instruction_type<=1<<5;//OR
   13'b000000100110?:instruction_type<=1<<6;//XOR
   13'b000000100111?:instruction_type<=1<<7;//NOR
   13'b000000101010?:instruction_type<=1<<8;//SLT
   13'b000000101011?:instruction_type<=1<<9;//SLTU
   13'b000000000000?:instruction_type<=1<<10;//SLL
   13'b000000000010?:instruction_type<=1<<11;//SRL
   13'b000000000011?:instruction_type<=1<<12;//SRA
   13'b000000000100?:instruction_type<=1<<13;//SLLV
   13'b000000000110?:instruction_type<=1<<14;//SRLV
   13'b000000000111?:instruction_type<=1<<15;//SRAV
   13'b000000001000?:instruction_type<=1<<16;//JR
   13'b001000???????:instruction_type<=1<<17;//ADDI
   13'b001001???????:instruction_type<=1<<18;//ADDIU
   13'b001100???????:instruction_type<=1<<19;//ANDI
   13'b001101???????:instruction_type<=1<<20;//ORI
   13'b001110???????:instruction_type<=1<<21;//XORI
   13'b001111???????:instruction_type<=1<<22;//LUI
   13'b100011???????:instruction_type<=1<<23;//LW
   13'b101011???????:instruction_type<=1<<24;//SW
   13'b000100???????:instruction_type<=1<<25;//BEQ
   13'b000101???????:instruction_type<=1<<26;//BNE
   13'b001010???????:instruction_type<=1<<27;//SLTI
   13'b001011???????:instruction_type<=1<<28;//SLTIU
   13'b000010???????:instruction_type<=1<<29;//JL
   13'b000011???????:instruction_type<=1<<30;//JAL
   13'b000000011010?:instruction_type<=1<<31;//DIV
   13'b000000011011?:instruction_type<=1<<32;//DIVU
   13'b000000011000?:instruction_type<=1<<33;//MULT
   13'b000000011001?:instruction_type<=1<<34;//MULTU
   13'b000001???????:instruction_type<=1<<35;//BGEZ
   13'b000000001001?:instruction_type<=1<<36;//JALR
   13'b100100???????:instruction_type<=1<<37;//LBU
   13'b100101???????:instruction_type<=1<<38;//LHU
   13'b100000???????:instruction_type<=1<<39;//LB
   13'b100001???????:instruction_type<=1<<40;//LH
   13'b101000???????:instruction_type<=1<<41;//SB
   13'b101001???????:instruction_type<=1<<42;//SH
   13'b000000001101?:instruction_type<=1<<43;//BREAK
   13'b000000001100?:instruction_type<=1<<44;//SYSCALL
   13'b010000011000?:instruction_type<=1<<45;//ERET
   13'b000000010000?:instruction_type<=1<<46;//MFHI
   13'b000000010010?:instruction_type<=1<<47;//MFLO
   13'b000000010001?:instruction_type<=1<<48;//MTHI
   13'b000000010011?:instruction_type<=1<<49;//MTLO
   13'b0100000000000:instruction_type<=1<<50;//MFC0
   13'b0100000000001:instruction_type<=1<<51;//MTC0
   13'b011100100000?:instruction_type<=1<<52;//CLZ
   13'b000000110100?:instruction_type<=1<<53;//TEQ
   13'b011100000010?:instruction_type<=1<<54;//MUL
   default:;
   endcase
end

endmodule
