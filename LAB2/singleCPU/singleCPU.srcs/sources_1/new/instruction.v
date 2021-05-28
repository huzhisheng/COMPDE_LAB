`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 16:45:34
// Design Name: 
// Module Name: instruction
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


module instruction(
    input [31:0] ins,
    output [5:0] op,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] shamt,
    output [5:0] func,
    output [15:0] imm,
    output [25:0] addr
    );
    assign op=ins[31:26];
    assign rs=ins[25:21];
    assign rt=ins[20:16];
    assign rd=ins[15:11];
    assign shamt=ins[10:6];
    assign func=ins[5:0];
    
    assign imm=ins[15:0];
    assign addr=ins[25:0];
endmodule
