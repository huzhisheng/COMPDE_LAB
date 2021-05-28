`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 13:55:28
// Design Name: 
// Module Name: RegisterFile
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
    //reg[31:0] reg_WD;
    
    assign debug_WD=WD;
    
    

    always@(*)begin
        RD1=regfile[A1];
        RD2=regfile[A2];
    end

    
    
    integer i;
    always@(posedge clk)begin
        if(rst == 1'b1)begin
            for (i = 0; i < 32; i = i+ 1) regfile[i] <= 0;  
        end else if(RFWr==1'b1 && A3)begin
            regfile[A3]<=WD;
        end
    end
endmodule
