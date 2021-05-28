`timescale 1ns / 1ps
module idecode32_sim();
    reg [31:0] NPC_PC4 = 32'h0;
    reg [31:0] ins = 32'h0;
    reg [31:0] ALU_out = 32'h0;
    reg [31:0] DM_RD = 32'h0;
    reg RFWr = 1'b0;
    reg EXTOp = 1'b0;
    reg clock = 1'b0;
    reg [1:0] WRSel = 2'b00;
    reg [1:0] WDSel = 2'b00;
    
    wire [31:0] rf_rd1,rf_rd2,ext;
    wire [4:0] debug_A3;
    wire [31:0] debug_WD;
    always #50 clock = ~clock;
    
    idecode32 u_idecode32(.clk(clock),.ins(ins),.ALU_out(ALU_out),.NPC_PC4(NPC_PC4),.DM_RD(DM_RD),.RFWr(RFWr),.EXTOp(EXTOp),.WRSel(WRSel),.WDSel(WDSel),.rf_rd1(rf_rd1),.rf_rd2(rf_rd2),.ext(ext),.debug_A3(debug_A3),.debug_WD(debug_WD));
   
    initial begin
        #40 begin   ins = 32'h2408ffff; //addiu    $t0,$zero,-1
                    ALU_out = 32'hffffffff;
                    RFWr = 1'b1;
                    WRSel = 2'b01;
                    WDSel = 2'b00;   
            end
        #90 begin  RFWr = 1'b0;end
        #100 begin  ins = 32'h24090002; //addiu    $t1,$zero,2
                    ALU_out = 32'h00000002;
                    RFWr = 1'b1;
                    WRSel = 2'b01;
                    WDSel = 2'b00; 
             end      
        #100 begin  RFWr = 1'b0;end
        #100 begin  ins = {6'd0,5'd8,5'd9,16'd0}; //无意义语句，只把t0和t1分别读到rd1和rd2上
                    
             end
    end
endmodule