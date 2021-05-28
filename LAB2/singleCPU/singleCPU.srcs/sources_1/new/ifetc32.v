`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 18:10:41
// Design Name: 
// Module Name: ifetc32
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


module ifetc32(
    input clk,
    input reset,
    input br_true,
    input [25:0] addr,
    input [31:0] ra,
    input [1:0] npcop,
    output [31:0] pc4,
    output [31:0] ins,
    output [31:0] now_pc
    );
    
    wire[31:0] npc_out;
    
    PC u_PC(.clk(clk),.reset(reset),.di(npc_out),.do(now_pc));
    
    NPC u_NPC(.clk(clk),.pc(now_pc),.addr(addr),.ra(ra),.NPCOp(npcop),.br_true(br_true),.pc4(pc4),.npc(npc_out));
    
    programrom IM(.clock(clk),.PC(now_pc),.Instruction(ins));

endmodule
