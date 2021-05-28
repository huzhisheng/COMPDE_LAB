`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 14:43:09
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input reset,
    input [31:0] di,
    output reg [31:0] do
    );
    reg has_started;
    always@(negedge clk)begin
        if(reset==1'b1)begin
            has_started <= 1'b0;
            do <= 32'd0;
        end else begin
            if(has_started == 1'b0)begin
                has_started <= 1'b1;
            end else begin
                do <= di;
            end
        end
    end
endmodule
