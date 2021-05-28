`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 09:07:49
// Design Name: 
// Module Name: ALU
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

module ALU(
    input[31:0] A,
    input[31:0] B,
    input[4:0] C,
    input[3:0] ALUOp,
    output reg [31:0] DO,
    output equal,   //PPT里面是zero,这里为了不与0扩展里的zero-extend冲突,起名为equal
    output less,
    output more
    );
assign equal= DO == 32'd0 ? 1'b1:1'b0;
assign less= DO[31]==1 ? 1'b1:1'b0;
assign more= DO[31]==0 ? 1'b1:1'b0;
always@(*)begin
    case(ALUOp)
    `ADD:begin
    DO=A+B;
    end
    `SUB:begin
    DO=A-B;
    end
    `AND:begin
    DO=A&B;
    end
    `OR:begin
    DO=A|B;
    end
    `XOR:begin
    DO=A^B;
    end
    `NOR:begin
    DO=~(A|B);
    end
    `SLT:begin
        if(A[31]==1 && B[31]==0)begin
            DO=32'd1;
        end else if(A[31]==0 && B[31]==1)begin
            DO=32'd0;
        end else if(A[30:0]<B[30:0])begin
            DO=32'd1;
        end else begin
            DO=32'd0;
        end
    end
    `SLTU:begin
    DO= A<B ? 32'd1:32'd0;
    end
    `SLL:begin
    DO=B<<C;
    end
    `SRL:begin
    DO=B>>C;
    end
    `SRA:begin
    DO=($signed(B))>>>C;
    end
    endcase
end
endmodule
