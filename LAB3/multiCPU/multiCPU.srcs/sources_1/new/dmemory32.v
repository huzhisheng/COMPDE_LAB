`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:41:37
// Design Name: 
// Module Name: dmemory32
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


module dmemory32(address,write_data,Memwrite,clock,DR);
    input[31:0] address; //来自 memorio 模块，源头是来自执行单元算出的
    //alu_result
    input[31:0] write_data; //来自译码单元的 read_data2
    input Memwrite; //来自控制单元
    input clock;
    output reg [31:0] DR;
    
    wire [31:0] read_data; // 从存储器中获得的数据
    always@(posedge clock)begin
        DR<=read_data;
    end
    
    wire clk;
    assign clk=~clock;
    
    // 分配 64KB RAM
    ram ram (
        .clka(clk), // input wire clka
        .wea(Memwrite), // input wire [0 : 0] wea
        .addra(address[15:2]), // input wire [13 : 0] addra
        .dina(write_data), // input wire [31 : 0] dina
        .douta(read_data) // output wire [31 : 0] douta
    );
endmodule
