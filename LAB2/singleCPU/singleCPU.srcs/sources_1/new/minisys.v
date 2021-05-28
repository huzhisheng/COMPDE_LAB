`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 21:13:27
// Design Name: 
// Module Name: minisys
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


module minisys(
    input fpga_rst,         
    input fpga_clk
    );
    
    wire clock;
    wire [31:0] debug_wb_pc;
    wire        debug_wb_rf_wen;
    wire [4:0]  debug_wb_rf_wnum;
    wire [31:0] debug_wb_rf_wdata;
    
    
    wire br_true,RFWr,EXTOp,less,equal,more,DMWr;
    wire[25:0] addr;
    wire[31:0] ins,ALU_out,NPC_PC4,now_pc,DM_RD,rf_rd1,rf_rd2,ext;
    wire[1:0] NPCOp,WRSel,WDSel,BSel,CSel;
    wire[3:0] ALUOp;
    wire[4:0] shamt;
    wire[5:0] op,func;
    
    assign debug_wb_pc = now_pc;
    assign debug_wb_rf_wen = RFWr;

    cpuclk UCLK(
        .clk_in1(fpga_clk), 
        .clk_out1(clock)
    );
    ifetc32 u_ifetc32(.clk(clock),.reset(fpga_rst),.br_true(br_true),.addr(addr),.ra(rf_rd1),.npcop(NPCOp),.pc4(NPC_PC4),.ins(ins),.now_pc(now_pc));
    
    idecode32 u_idecode32(.clk(clock),.rst(fpga_rst),.ins(ins),.ALU_out(ALU_out),.NPC_PC4(NPC_PC4),.DM_RD(DM_RD),
        .RFWr(RFWr),.EXTOp(EXTOp),.WRSel(WRSel),.WDSel(WDSel),.shamt(shamt),.op(op),.func(func),.addr(addr),
        .rf_rd1(rf_rd1),.rf_rd2(rf_rd2),.ext(ext),.debug_A3(debug_wb_rf_wnum),.debug_WD(debug_wb_rf_wdata));
    
    executs32 u_executs32(.rf_rd1(rf_rd1),.rf_rd2(rf_rd2),.ext(ext),.shamt(shamt),.ALUOp(ALUOp),.BSel(BSel),.CSel(CSel),.ALU_out(ALU_out),.less(less),.equal(equal),.more(more));
    
    control32 u_control32(.op(op),.func(func),.less(less),.equal(equal),.more(more),.NPCOp(NPCOp),
        .RFWr(RFWr),.EXTOp(EXTOp),.ALUOp(ALUOp),.DMWr(DMWr),.WRSel(WRSel),.WDSel(WDSel),.BSel(BSel),.CSel(CSel),.br_true(br_true));

    dmemory32 u_dmemory32(.read_data(DM_RD),.address(ALU_out),.Memwrite(DMWr),.clock(clock),.write_data(rf_rd2));
endmodule
