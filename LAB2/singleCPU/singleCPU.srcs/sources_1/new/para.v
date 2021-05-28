`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 09:40:29
// Design Name: 
// Module Name: para
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
//ALUOp
`define ADD 4'b0000
`define SUB 4'b0001
`define AND 4'b0010
`define OR 4'b0011
`define XOR 4'b0100
`define NOR 4'b0101
`define SLT 4'b0110
`define SLTU 4'b0111
`define SLL 4'b1000
`define SRL 4'b1001
`define SRA 4'b1010
//EXTOp
`define SIGN 1'b0
`define ZERO 1'b1
//NPCOp
`define PC4 2'b00
`define JR 2'b01
`define BT 2'b10
`define J 2'b11
//WRSel
`define RD 2'b00
`define RT 2'b01
`define RA 2'b10
//WDSel
`define ALUDO 2'b00
`define DM 2'b01
`define NPC4 2'b10
//BSel
`define RD2 2'b00
`define EXT 2'b01
`define B0 2'b10
//CSel
`define SHAMT 2'b00
`define RD1 2'b01
`define SIXTEEN 2'b10
//ЦёБо
`define ADD_FUNC 6'b100000
`define ADDU_FUNC 6'b100001
`define SUB_FUNC 6'b100010
`define SUBU_FUNC 6'b100011
`define AND_FUNC 6'b100100
`define OR_FUNC 6'b100101
`define XOR_FUNC 6'b100110
`define NOR_FUNC 6'b100111
`define SLT_FUNC 6'b101010
`define SLTU_FUNC 6'b101011
`define SLL_FUNC 6'b000000
`define SRL_FUNC 6'b000010
`define SRA_FUNC 6'b000011
`define SLLV_FUNC 6'b000100
`define SRLV_FUNC 6'b000110
`define SRAV_FUNC 6'b000111
`define JR_FUNC 6'b001000

`define ADDI_OP 6'b001000
`define ADDIU_OP 6'b001001
`define ANDI_OP 6'b001100
`define ORI_OP 6'b001101
`define XORI_OP 6'b001110
`define SLTIU_OP 6'b001011
`define LUI_OP 6'b001111
`define LW_OP 6'b100011
`define SW_OP 6'b101011
`define BEQ_OP 6'b000100
`define BNE_OP 6'b000101
`define BGTZ_OP 6'b000111
`define J_OP 6'b000010
`define JAL_OP 6'b000011

