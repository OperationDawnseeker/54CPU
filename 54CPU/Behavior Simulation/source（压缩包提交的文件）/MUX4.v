`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/18 20:24:39
// Design Name: 
// Module Name: MUX4
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

module MUX4(
input [31:0] d0,
input [31:0] d1,
input [31:0] d2,
input [31:0] d3,
input [1:0] s,//—°‘Ò–≈∫≈
output [31:0] y
    );
    assign y=  s==2'b00 ? d0:( s==2'b01 ? d1:( s==2'b10 ? d2 : d3 ));
    
endmodule