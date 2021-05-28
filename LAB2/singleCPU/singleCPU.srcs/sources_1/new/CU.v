`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 15:26:19
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
    input[5:0] op,
    input[5:0] func,
    output reg [1:0] NPCOp,
    output reg RFWr,
    output reg EXTOp,
    output reg [3:0] ALUOp,
    output reg DMWr,
    output reg [1:0] WRSel,
    output reg [1:0] WDSel,
    output reg [1:0] BSel,
    output reg [1:0] CSel
    );
    always@(*)begin
        if(op==6'b000000)begin
            case(func)
                `ADD_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`ADD;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `ADDU_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`ADD;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `SUB_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SUB;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `SUBU_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SUB;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `AND_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`AND;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `OR_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`OR;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `XOR_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`XOR;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `NOR_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`NOR;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `SLT_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SLT;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `SLTU_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SLTU;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `SLL_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SLL;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `SRL_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SRL;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `SRA_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SRA;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `SLLV_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SLL;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`RD1;      //X
                end
                `SRLV_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SRL;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`RD1;      //X
                end
                `SRAV_FUNC:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SRA;
                    DMWr=1'b0;
                    WRSel=`RD;
                    WDSel=`ALUDO;
                    BSel=`RD2;
                    CSel=`RD1;      //X
                end
                `JR_FUNC:begin
                    NPCOp=`JR;
                    RFWr=1'b0;
                    EXTOp=`ZERO;    //X
                    ALUOp=`SRL;     //X
                    DMWr=1'b0;
                    WRSel=`RD;      //X
                    WDSel=`ALUDO;   //X
                    BSel=`RD2;      //X
                    CSel=`RD1;      //X
                end
            endcase
        end else begin
            case(op)
                `ADDI_OP:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`SIGN;
                    ALUOp=`ADD;
                    DMWr=1'b0;
                    WRSel=`RT;
                    WDSel=`ALUDO;
                    BSel=`EXT;
                    CSel=`SHAMT;    //X
                end
                `ADDIU_OP:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`SIGN;
                    ALUOp=`ADD;
                    DMWr=1'b0;
                    WRSel=`RT;
                    WDSel=`ALUDO;
                    BSel=`EXT;
                    CSel=`SHAMT;    //X
                end
                `ANDI_OP:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;
                    ALUOp=`AND;
                    DMWr=1'b0;
                    WRSel=`RT;
                    WDSel=`ALUDO;
                    BSel=`EXT;
                    CSel=`SHAMT;    //X
                end
                `ORI_OP:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;
                    ALUOp=`OR;
                    DMWr=1'b0;
                    WRSel=`RT;
                    WDSel=`ALUDO;
                    BSel=`EXT;
                    CSel=`SHAMT;    //X
                end
                `XORI_OP:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;
                    ALUOp=`XOR;
                    DMWr=1'b0;
                    WRSel=`RT;
                    WDSel=`ALUDO;
                    BSel=`EXT;
                    CSel=`SHAMT;    //X
                end
                `SLTIU_OP:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`SIGN;
                    ALUOp=`SLTU;
                    DMWr=1'b0;
                    WRSel=`RT;
                    WDSel=`ALUDO;
                    BSel=`EXT;
                    CSel=`SHAMT;    //X
                end
                `LUI_OP:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`ZERO;
                    ALUOp=`SLL;
                    DMWr=1'b0;
                    WRSel=`RT;
                    WDSel=`ALUDO;
                    BSel=`EXT;
                    CSel=`SIXTEEN;
                end
                `LW_OP:begin
                    NPCOp=`PC4;
                    RFWr=1'b1;
                    EXTOp=`SIGN;
                    ALUOp=`ADD;
                    DMWr=1'b0;
                    WRSel=`RT;
                    WDSel=`DM;
                    BSel=`EXT;
                    CSel=`SHAMT;    //X
                end
                `SW_OP:begin
                    NPCOp=`PC4;
                    RFWr=1'b0;
                    EXTOp=`SIGN;
                    ALUOp=`ADD;
                    DMWr=1'b1;
                    WRSel=`RT;      //X
                    WDSel=`ALUDO;   //X
                    BSel=`EXT;
                    CSel=`SHAMT;    //X
                end
                `BEQ_OP:begin
                    NPCOp=`BT;
                    RFWr=1'b0;
                    EXTOp=`SIGN;    //X
                    ALUOp=`SUB;
                    DMWr=1'b0;
                    WRSel=`RT;      //X
                    WDSel=`ALUDO;   //X
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `BNE_OP:begin
                    NPCOp=`BT;
                    RFWr=1'b0;
                    EXTOp=`SIGN;    //X
                    ALUOp=`SUB;
                    DMWr=1'b0;
                    WRSel=`RT;      //X
                    WDSel=`ALUDO;   //X
                    BSel=`RD2;
                    CSel=`SHAMT;    //X
                end
                `BGTZ_OP:begin
                    NPCOp=`BT;
                    RFWr=1'b0;
                    EXTOp=`SIGN;    //X
                    ALUOp=`SUB;
                    DMWr=1'b0;
                    WRSel=`RT;      //X
                    WDSel=`ALUDO;   //X
                    BSel=`B0;
                    CSel=`SHAMT;    //X
                end
                `J_OP:begin
                    NPCOp=`J;
                    RFWr=1'b0;
                    EXTOp=`SIGN;    //X
                    ALUOp=`SUB;     //X
                    DMWr=1'b0;
                    WRSel=`RT;      //X
                    WDSel=`ALUDO;   //X
                    BSel=`RD2;      //X
                    CSel=`SHAMT;    //X
                end
                `JAL_OP:begin
                    NPCOp=`J;
                    RFWr=1'b1;
                    EXTOp=`SIGN;    //X
                    ALUOp=`SUB;     //X
                    DMWr=1'b0;
                    WRSel=`RA;
                    WDSel=`NPC4;
                    BSel=`RD2;      //X
                    CSel=`SHAMT;    //X
                end
            endcase
        end
    end
    
endmodule
