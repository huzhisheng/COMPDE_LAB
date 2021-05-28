`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 22:29:34
// Design Name: 
// Module Name: rom_sim
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


module rom_sim();
    reg clock=0;
    always #50 clock = ~clock; 
    reg[13:0] addra=0;
    wire[31:0] ins;
    
    initial begin
    #250 addra=1;
    #250 addra=2;
    end
    prgrom u_prgrom(.clka(clock),.addra(addra),.douta(ins));
    
    

endmodule
