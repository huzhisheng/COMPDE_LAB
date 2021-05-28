`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:41:03
// Design Name: 
// Module Name: control32
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


module control32(
    input clk,
    input rst,
    input [5:0] op,
    input [5:0] func,
    input less,
    input equal,
    input more,
    output [1:0] NPCOp,
    output PCWr,
    output IRWr,
    output RFWr,
    output EXTOp,
    output [3:0] ALUOp,
    output DMWr,
    output [1:0] WRSel,
    output [1:0] WDSel,
    output [1:0] BSel,
    output [1:0] CSel,
    output br_true
    );
    CU u_CU(.clk(clk),.rst(rst),.br_true(br_true),.op(op),.func(func),.NPCOp(NPCOp),.PCWr(PCWr),.IRWr(IRWr),.RFWr(RFWr),.EXTOp(EXTOp),.ALUOp(ALUOp),.DMWr(DMWr),.WRSel(WRSel),.WDSel(WDSel),.BSel(BSel),.CSel(CSel));
    
    judge u_judge(.op(op),.equal(equal),.less(less),.more(more),.br_true(br_true));

endmodule
