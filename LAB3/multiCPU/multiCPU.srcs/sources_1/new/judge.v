`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:40:28
// Design Name: 
// Module Name: judge
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

module judge(
    input[5:0] op,
    input equal,
    input less,
    input more,
    output reg br_true
    );
    always@(*)begin
        case(op)
            `BEQ_OP:begin
                br_true= equal==1'b1 ? 1'b1:1'b0;
            end
            `BNE_OP:begin
                br_true= equal==1'b1 ? 1'b0:1'b1;
            end
            `BGTZ_OP:begin
                br_true= more==1'b1 ? 1'b1:1'b0;
            end
        endcase
    end
endmodule
