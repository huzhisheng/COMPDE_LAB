`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:39:51
// Design Name: 
// Module Name: CU
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

module CU(
    input clk,
    input rst,
    input br_true,
    input[5:0] op,
    input[5:0] func,
    output reg [1:0] NPCOp,
    output reg PCWr,
    output reg IRWr,
    output reg RFWr,
    output reg EXTOp,
    output reg [3:0] ALUOp,
    output reg DMWr,
    output reg [1:0] WRSel,
    output reg [1:0] WDSel,
    output reg [1:0] BSel,
    output reg [1:0] CSel
    );
    parameter [2:0] s1 = 3'b000,s2=3'b001,s3=3'b010,s4=3'b011,s5=3'b100,s0 = 3'b111; 
    wire T1,T2,T3,T4,T5;
    reg [2:0] state, nextState;
    
    assign T1=(state == s1);
    assign T2=(state == s2);
    assign T3=(state == s3);
    assign T4=(state == s4);
    assign T5=(state == s5);
    
    always@(posedge clk) begin
       if(rst) begin
           state <= s0;
       end else begin
           state <= nextState;
       end
   end

    always@(*)begin
        case(state)
            s0:begin
                nextState=s1;
            end
            s1:begin
                nextState=s2;
            end
            s2:begin
                if(op == `J_OP || op == `JAL_OP)begin
                    nextState=s1;
                end else begin
                    nextState=s3;
                end
            end
            s3:begin
                if((op == 6'b000000 && func == `JR_FUNC) || op == `BEQ_OP || op == `BNE_OP || op == `BGTZ_OP) begin
                    nextState=s1;
                end else begin
                    nextState=s4;
                end
            end
            s4:begin
                if(op == `LW_OP)begin
                    nextState=s5;
                end else begin
                    nextState=s1;
                end
            end
            s5:begin
                nextState=s1;
            end
        endcase
    end
    
    always@(*)begin
        if(op == 6'b000000)begin
            case(func)
                `ADD_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `ADD;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                    
                end
                `ADDU_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `ADD;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                end
                `SUB_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `SUB;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                end
                `SUBU_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `SUB;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                end
                `AND_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `AND;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                end
                `OR_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `OR;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                end
                `XOR_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `XOR;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                end
                `NOR_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `NOR;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                end
                `SLT_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `SLT;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                end
                `SLTU_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `SLTU;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                end
                `SLL_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `SLL;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                    CSel = `SHAMT;
                end
                `SRL_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `SRL;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                    CSel = `SHAMT;
                end
                `SRA_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `SRA;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                    CSel = `SHAMT;
                end
                `SLLV_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `SLL;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                    CSel = `RD1;
                end
                `SRLV_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `SRL;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                    CSel = `RD1;
                end
                `SRAV_FUNC:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    ALUOp = `SRA;
                    DMWr = 1'b0;
                    WRSel = `RD;
                    WDSel = `ALUDO;
                    BSel = `RD2;
                    CSel = `RD1;
                end
                `JR_FUNC:begin
                    NPCOp = T1 ? `PC4 : `JR;
                    PCWr = (T1 == 1'b1 || T3 == 1'b1) ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = 1'b0;
                    DMWr = 1'b0;
                end
            endcase
        end else begin
            case(op)
                `ADDI_OP:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    EXTOp = `SIGN;
                    ALUOp = `ADD;
                    DMWr = 1'b0;
                    WRSel = `RT;
                    WDSel = `ALUDO;
                    BSel = `EXT;
                end
                `ADDIU_OP:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    EXTOp = `SIGN;
                    ALUOp = `ADD;
                    DMWr = 1'b0;
                    WRSel = `RT;
                    WDSel = `ALUDO;
                    BSel = `EXT;
                end
                `ANDI_OP:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    EXTOp = `ZERO;
                    ALUOp = `AND;
                    DMWr = 1'b0;
                    WRSel = `RT;
                    WDSel = `ALUDO;
                    BSel = `EXT;
                end
                `ORI_OP:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    EXTOp = `ZERO;
                    ALUOp = `OR;
                    DMWr = 1'b0;
                    WRSel = `RT;
                    WDSel = `ALUDO;
                    BSel = `EXT;
                end
                `XORI_OP:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    EXTOp = `ZERO;
                    ALUOp = `XOR;
                    DMWr = 1'b0;
                    WRSel = `RT;
                    WDSel = `ALUDO;
                    BSel = `EXT;
                end
                `SLTIU_OP:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    EXTOp = `SIGN;
                    ALUOp = `SLTU;
                    DMWr = 1'b0;
                    WRSel = `RT;
                    WDSel = `ALUDO;
                    BSel = `EXT;
                end
                `LUI_OP:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T4 ? 1'b1 : 1'b0;
                    EXTOp = `ZERO;
                    ALUOp = `SLL;
                    DMWr = 1'b0;
                    WRSel = `RT;
                    WDSel = `ALUDO;
                    BSel = `EXT;
                    CSel = `SIXTEEN;
                end
                `LW_OP:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T5 ? 1'b1 : 1'b0;
                    EXTOp = `SIGN;
                    ALUOp = `ADD;
                    DMWr = 1'b0;
                    WRSel = `RT;
                    WDSel = `DM;
                    BSel = `EXT;
                end
                `SW_OP:begin
                    NPCOp = `PC4;
                    PCWr = T1 ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = 1'b0;
                    EXTOp = `SIGN;
                    ALUOp = `ADD;
                    DMWr = T4 ? 1'b1 : 1'b0;
                    BSel = `EXT;
                end
                `BEQ_OP:begin
                    NPCOp = T1 ? `PC4 : `BT;
                    PCWr = T1 ? 1'b1 : (T3 ? br_true : 1'b0);
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = 1'b0;
                    ALUOp = `SUB;
                    DMWr = 1'b0;
                    BSel = `RD2;
                end
                `BNE_OP:begin
                    NPCOp = T1 ? `PC4 : `BT;
                    PCWr = T1 ? 1'b1 : (T3 ? br_true : 1'b0);
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = 1'b0;
                    ALUOp = `SUB;
                    DMWr = 1'b0;
                    BSel = `RD2;
                end
                `BGTZ_OP:begin
                    NPCOp = T1 ? `PC4 : `BT;
                    PCWr = T1 ? 1'b1 : (T3 ? br_true : 1'b0);
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = 1'b0;
                    ALUOp = `SUB;
                    DMWr = 1'b0;
                    BSel = `B0;
                end
                `J_OP:begin
                    NPCOp = T1 ? `PC4 : `J;
                    PCWr = (T1 || T2) ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = 1'b0;
                    DMWr = 1'b0;
                end
                `JAL_OP:begin
                    NPCOp = T1 ? `PC4 : `J;
                    PCWr = (T1 || T2) ? 1'b1 : 1'b0;
                    IRWr = T1 ? 1'b1 : 1'b0;
                    RFWr = T2 ? 1'b1 : 1'b0;
                    DMWr = 1'b0;
                    WRSel = `RA;
                    WDSel = `PCDO;
                end
                default:begin
                    IRWr = 1'b1;    //初始时必须把IRWr打开好装入第一条指令
                end
                
            endcase
        end
    end
    
    
endmodule
