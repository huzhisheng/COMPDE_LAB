`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 17:59:44
// Design Name: 
// Module Name: MUX32
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


module MUX32(
    input [31:0] input1,
    input [31:0] input2,
    input [31:0] input3,
    input [1:0] sel,
    output reg [31:0] out
    );
    always@(*)begin
        case(sel)
        2'b00:out=input1;
        2'b01:out=input2;
        default:out=input3;
        endcase
    end
endmodule
