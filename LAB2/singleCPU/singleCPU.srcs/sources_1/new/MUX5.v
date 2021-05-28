`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 17:55:10
// Design Name: 
// Module Name: MUX5
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


module MUX5(
    input [4:0] input1,
    input [4:0] input2,
    input [4:0] input3,
    input [1:0] sel,
    output reg [4:0] out
    );
    always@(*)begin
        case(sel)
        2'b00:out=input1;
        2'b01:out=input2;
        default:out=input3;
        endcase
    end
endmodule
