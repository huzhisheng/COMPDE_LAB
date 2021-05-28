`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 20:59:00
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
    input [5:0] op,
    input [5:0] func,
    input less,
    input equal,
    input more,
    output [1:0] NPCOp,
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
    CU u_CU(.op(op),.func(func),.NPCOp(NPCOp),.RFWr(RFWr),.EXTOp(EXTOp),.ALUOp(ALUOp),.DMWr(DMWr),.WRSel(WRSel),.WDSel(WDSel),.BSel(BSel),.CSel(CSel));
    
    judge u_judge(.op(op),.equal(equal),.less(less),.more(more),.br_true(br_true));

endmodule
