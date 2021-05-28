`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:28:05
// Design Name: 
// Module Name: programrom
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

module programrom(
    input clock,
    input[31:0] PC,
    output[31:0] Instruction
    );
    
    wire clk;
    assign clk=~clock;
    
//∑÷≈‰ 64KB ROM£¨
prgrom instmem(
    .clka(clk), // input wire clka
    .addra(PC[15:2]), // input wire [13 : 0] addra
    .douta(Instruction) // output wire [31 : 0] douta
);
endmodule
