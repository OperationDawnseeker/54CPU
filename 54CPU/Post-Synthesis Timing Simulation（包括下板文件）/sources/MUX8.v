`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/22 23:16:24
// Design Name: 
// Module Name: MUX8
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


module MUX8(
input [31:0] d0,
input [31:0] d1,
input [31:0] d2,
input [31:0] d3,
input [31:0] d4,
input [31:0] d5,
input [31:0] d6,
input [31:0] d7,
input [2:0]  s,//—°‘Ò–≈∫≈
output [31:0] y
    );
    reg [31:0]temp;
    always @(*) begin
    case(s)
        3'b000:temp=d0;
        3'b001:temp=d1;
        3'b010:temp=d2;
        3'b011:temp=d3;
        3'b100:temp=d4;
        3'b101:temp=d5;
        3'b110:temp=d6;
        3'b111:temp=d7;
        default:temp=32'b0;
    endcase
    end
    assign y =  temp;
endmodule
