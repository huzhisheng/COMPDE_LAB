`timescale 1ns / 1ps

module executs32_sim();
    /*
    reg clock = 1'b0;
    always #50 clock =~ clock;
    */
    
    reg [31:0] rf_rd1 = 32'd0;
    reg [31:0] rf_rd2 = 32'd0;
    reg [31:0] ext = 32'd0;
    reg [4:0] shamt = 5'd0;
    reg [3:0] ALUOp = 4'd0;
    reg [1:0] BSel = 2'd0;
    reg [1:0] CSel = 2'd0;
    wire [31:0] ALU_out;
    wire less,equal,more;
    executs32 u_executs32(.rf_rd1(rf_rd1),.rf_rd2(rf_rd2),.ext(ext),.shamt(shamt),.ALUOp(ALUOp),.BSel(BSel),.CSel(CSel),.ALU_out(ALU_out),.less(less),.equal(equal),.more(more));
    
    initial begin
        #10 begin BSel = 2'b00; CSel = 2'b00;end    //先初始化，让ALU的A是RD1, B是RD2, C是shamt, 后续只需要操控这三个寄存器即可, 不用去管ext
        #90 begin   //先进行加
                rf_rd1 = 32'h10;
                rf_rd2 = 32'h20;
                ALUOp = 4'b0000; 
            end
        #100 begin  //再进行或运算
                rf_rd1 = 32'h10;
                rf_rd2 = 32'h23;
                ALUOp = 4'b0011; 
            end
        #100 begin  //再进行异或运算
                rf_rd1 = 32'hf0;
                rf_rd2 = 32'h0f;
                ALUOp = 4'b0100; 
            end
        #100 begin  //再进行SLT运算
                rf_rd1 = 32'h1;
                rf_rd2 = 32'h2;
                ALUOp = 4'b0110; 
            end
        #100 begin  //再进行算术右移运算
                rf_rd2 = 32'hf0;
                shamt = 5'h4;
                ALUOp = 4'b1010; 
            end
    end

endmodule