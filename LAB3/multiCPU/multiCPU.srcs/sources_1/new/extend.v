`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:31:33
// Design Name: 
// Module Name: extend
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

`include "para.v"
module extend(
    input [15:0] Imm,
    input EXTOp,
    output [31:0] Ext
    );
    assign Ext[15:0] = Imm;
    assign Ext[31:16] = EXTOp==`SIGN ? (Imm[15]==1'b1 ? 16'hffff : 16'h0000) : 16'h0000;
endmodule
