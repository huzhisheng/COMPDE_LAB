`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 20:06:46
// Design Name: 
// Module Name: idecode32
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


module idecode32(
    input clk,
    input rst,
    input[31:0] ins,
    input[31:0] ALU_out,
    input[31:0] NPC_PC4,
    input[31:0] DM_RD,
    input RFWr,
    input EXTOp,
    input[1:0] WRSel,
    input[1:0] WDSel,
    output[4:0] shamt,
    output[5:0] op,
    output[5:0] func,
    output[25:0] addr,
    output[31:0] rf_rd1,
    output[31:0] rf_rd2,
    output[31:0] ext,
    //为了debug而新加的输出
    output[4:0] debug_A3,
    output[31:0] debug_WD
    );
    
    wire[4:0] rs,rt,rd,wire_A3;
    wire[15:0] imm;
    wire[31:0] wire_WD;
    
    assign debug_A3=wire_A3;
    
    instruction u_instruction(.ins(ins),.op(op),.rs(rs),.rt(rt),.rd(rd),.shamt(shamt),.func(func),.imm(imm),.addr(addr));

    MUX5 A3MUX(.input1(rd),.input2(rt),.input3(5'b11111),.sel(WRSel),.out(wire_A3));
    
    MUX32 WDMUX(.input1(ALU_out),.input2(DM_RD),.input3(NPC_PC4),.sel(WDSel),.out(wire_WD));
    
    registerfile u_registerfile(.clk(clk),.rst(rst),.A1(rs),.A2(rt),.A3(wire_A3),.WD(wire_WD),.RFWr(RFWr),.RD1(rf_rd1),.RD2(rf_rd2),.debug_WD(debug_WD));

    extend u_extend(.Imm(imm),.EXTOp(EXTOp),.Ext(ext));

endmodule
