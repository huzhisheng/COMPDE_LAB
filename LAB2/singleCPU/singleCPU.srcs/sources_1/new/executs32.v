`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 20:43:17
// Design Name: 
// Module Name: executs32
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


module executs32(
    input[31:0] rf_rd1,
    input[31:0] rf_rd2,
    input[31:0] ext,
    input[4:0] shamt,
    input[3:0] ALUOp,
    input[1:0] BSel,
    input[1:0] CSel,
    output[31:0] ALU_out,
    output less,
    output equal,
    output more
    );
    wire[31:0] wire_ALUB;
    wire[31:0] wire_ALUC;
    
    
    MUX32 BMUX(.input1(rf_rd2),.input2(ext),.input3(32'd0),.out(wire_ALUB),.sel(BSel));
    MUX5 CMUX(.input1(shamt),.input2(rf_rd1[4:0]),.input3(5'b10000),.out(wire_ALUC),.sel(CSel));
    ALU u_ALU(.A(rf_rd1),.B(wire_ALUB),.C(wire_ALUC),.ALUOp(ALUOp),.DO(ALU_out),.equal(equal),.less(less),.more(more));
endmodule
