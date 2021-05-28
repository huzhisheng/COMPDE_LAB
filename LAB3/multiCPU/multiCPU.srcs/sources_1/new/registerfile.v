`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:31:02
// Design Name: 
// Module Name: registerfile
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

module registerfile(
    input clk,
    input rst,
    input[4:0] A1,
    input[4:0] A2,
    input[4:0] A3,
    input[31:0] WD,
    input RFWr,
    output reg [31:0] RD1,
    output reg [31:0] RD2,
    output [31:0] debug_WD
    );
    
    reg[31:0] regfile[31:0];

    
    assign debug_WD=regfile[A3];
    
    

    always@(*)begin
        RD1=regfile[A1];
        RD2=regfile[A2];
    end

    
    
    integer i;
    always@(negedge clk)begin
        if(rst == 1'b1)begin
            for (i = 0; i < 32; i = i+ 1) regfile[i] <= 0;  
        end else if(RFWr == 1'b1 && A3)begin
            regfile[A3]<=WD;
        end
    end
endmodule
