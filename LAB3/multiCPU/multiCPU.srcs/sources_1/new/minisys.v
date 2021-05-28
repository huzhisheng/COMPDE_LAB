`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:42:06
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
    input fpga_clk,
    output [31:0] test_wb_pc,
    output test_wb_rf_wen,
    output [4:0] test_wb_rf_wnum,
    output [31:0] test_wb_rf_wdata
    );
    
    wire clock;
    wire [31:0] debug_wb_pc;
    wire        debug_wb_rf_wen;
    wire [4:0]  debug_wb_rf_wnum;
    wire [31:0] debug_wb_rf_wdata;
    assign test_wb_pc = debug_wb_pc;
    assign test_wb_rf_wen = debug_wb_rf_wen;
    assign test_wb_rf_wnum = debug_wb_rf_wnum;
    assign test_wb_rf_wdata = debug_wb_rf_wdata;
    
    wire br_true,RFWr,EXTOp,less,equal,more,DMWr,PCWr,IRWr;
    wire[25:0] addr;
    wire[31:0] ins,ALU_out,now_pc,DM_RD,rf_rd1,rf_rd2,ext;
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
    ifetc32 u_ifetc32(.clk(clock),.reset(fpga_rst),.br_true(br_true),.addr(addr),.ra(rf_rd1),.npcop(NPCOp),.PCWr(PCWr),.IRWr(IRWr),.IR(ins),.now_pc(now_pc));
    
    idecode32 u_idecode32(.clk(clock),.rst(fpga_rst),.ins(ins),.ALU_out(ALU_out),.PC_DO(now_pc),.DM_RD(DM_RD),
        .RFWr(RFWr),.EXTOp(EXTOp),.WRSel(WRSel),.WDSel(WDSel),.shamt(shamt),.op(op),.func(func),.addr(addr),
        .A(rf_rd1),.B(rf_rd2),.E(ext),.debug_A3(debug_wb_rf_wnum),.debug_WD(debug_wb_rf_wdata));
    
    executs32 u_executs32(.clk(clock),.rf_rd1(rf_rd1),.rf_rd2(rf_rd2),.ext(ext),.shamt(shamt),.ALUOp(ALUOp),.BSel(BSel),.CSel(CSel),.ALUOut(ALU_out),.less(less),.equal(equal),.more(more));
    
    control32 u_control32(.clk(clock),.rst(fpga_rst),.op(op),.func(func),.less(less),.equal(equal),.more(more),.NPCOp(NPCOp),.PCWr(PCWr),.IRWr(IRWr),
        .RFWr(RFWr),.EXTOp(EXTOp),.ALUOp(ALUOp),.DMWr(DMWr),.WRSel(WRSel),.WDSel(WDSel),.BSel(BSel),.CSel(CSel),.br_true(br_true));

    dmemory32 u_dmemory32(.DR(DM_RD),.address(ALU_out),.Memwrite(DMWr),.clock(clock),.write_data(rf_rd2));
endmodule
