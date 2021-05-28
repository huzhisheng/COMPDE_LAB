`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:27:12
// Design Name: 
// Module Name: NPC
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
module NPC(
    input [31:0] pc,
    input [25:0] addr,
    input [31:0] ra,
    input [1:0] NPCOp,
    input br_true,  //外界传入的标志代表beq,bne,bgtz三类指令跳转条件成立与否,成立则为1
    output reg [31:0] npc
    );
    wire[31:0] offset;
    wire[31:0] b_imm;
    wire[31:0] j_imm;
    assign offset[31:18] = addr[15]==1'b1 ? 14'h3FFF : 14'h0;
    assign offset[17:0] = {addr[15:0],2'b00};
    assign b_imm = pc+offset;
    assign j_imm = {4'b0000,addr,2'b00}; 
    //assign pc4=pc+4;
    
    always@(*)begin
        case(NPCOp)
            `PC4:begin
                npc=pc+4;
            end
            
            `JR:begin
                npc=ra;
            end
            
            `BT:begin
                npc=br_true==1'b1 ? b_imm : pc+4;
            end
            
            `J:begin
                npc=j_imm;
            end
        endcase
    end
endmodule
