`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/18 20:26:21
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


module ALU( 
    input   [31:0]  A,          // 操作数 
    input   [31:0]  B,          // 操作数 
    output  [31:0]  Y,          // 结果 
    input   [3:0]   ALUC,       // 选择信号 
    output          zero,       // 以下为标志位 
    output          carry,     
    output          negative,    
    output          overflow     
    ); 
     
    wire signed [31:0] signedA, signedB; 
    reg [32:0] ans; 
     
    assign signedA = A; 
    assign signedB = B; 
     
    parameter ADD   =   4'b0000; 
    parameter ADDU  =   4'b0001; 
    parameter SUB   =   4'b0010; 
    parameter SUBU  =   4'b0011; 
    parameter AND   =   4'b0100; 
    parameter OR    =   4'b0101;
    parameter XOR   =   4'b0110; 
    parameter NOR   =   4'b0111; 
    parameter SLT   =   4'b1000; 
    parameter SLTU  =   4'b1001; 
    parameter SLL   =   4'b1010; 
    parameter SRL   =   4'b1011; 
    parameter SRA   =   4'b1100; 
    parameter LUI   =   4'b1101; 
     
    always@ (*) 
    begin 
        case(ALUC) 
            ADD: 
            begin 
                ans = signedA + signedB; 
            end 
            ADDU: 
            begin 
                ans = A + B; 
            end 
            SUB: 
            begin 
                ans = signedA - signedB; 
            end 
            SUBU:  
            begin 
                ans = A - B; 
            end 
            AND: 
            begin 
                ans = A & B; 
            end 
            OR: 
            begin 
                ans = A | B; 
            end 
            XOR: 
            begin 
                ans = A ^ B; 
            end 
            NOR: 
            begin 
                ans = ~(A | B);
            end 
            SLT:  
            begin 
                ans = (signedA < signedB); 
            end 
            SLTU: 
            begin 
                ans = (A < B); 
            end 
            SLL: 
            begin 
                ans = (B << A); 
            end 
            SRL: 
            begin 
                if(A == 0)  
                    { ans[31:0], ans[32] } = { B, 1'b0 }; 
                else 
                    { ans[31:0], ans[32] } = B >> (A - 1); 
            end 
            SRA: 
            begin 
                if(A == 0)  
                    { ans[31:0], ans[32] } = { signedB, 1'b0 }; 
                else 
                    { ans[31:0], ans[32] } = signedB >>> (A - 1); 
            end 
            LUI: 
            begin 
                ans = { B[15:0], 16'b0 }; 
            end 
        endcase 
    end 
     
    assign Y        = ans[31:0]; 
    assign zero     = (ans == 32'b0) ? 1'b1 : 1'b0; 
    assign carry    = ans[32]; 
    assign overflow = ans[32] ^ ans[31]; 
    assign negative = ans[31]; 
     

endmodule 
