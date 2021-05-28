`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 22:07:21
// Design Name: 
// Module Name: sim_minisys
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


module sim_minisys();
    // INPUT
    reg pclk = 0;
    reg rst=0;
    //output
    wire clock;
    wire[31:0] debug_rd1,debug_rd2,debug_ALU_out;
    cpuclk UCLK(
        .clk_in1(pclk), 
        .clk_out1(clock)
    );
    always #5 pclk = ~pclk;
    
    initial begin
    #3000 rst=1;
    end
    
    minisys u_minisys(.rst(rst),.clk(clock),.debug_rd1(debug_rd1),.debug_rd2(debug_rd2),.debug_ALU_out(debug_ALU_out));

endmodule
