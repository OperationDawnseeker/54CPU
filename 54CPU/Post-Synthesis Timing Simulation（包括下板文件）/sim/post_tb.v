`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/24 13:23:18
// Design Name: 
// Module Name: post_tb
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


module post_tb;
    // Inputs
	reg clk_in;
	reg reset;
    wire [7:0] o_seg;//输出内容
    wire [7:0] o_sel ;//片选信号
    
	// Outputs
	wire [31:0] inst;
	wire [31:0] pc;
	// Instantiate the Unit Under Test (UUT)
	sccomp_dataflow_2 uut (
		.clk_in(clk_in), 
		.reset(reset), 
		.o_seg(o_seg),
		.o_sel(o_sel)
	);
	
	initial begin
            clk_in = 0;
            reset = 1;
    
            // Wait 100 ns for global reset to finish
            #40;
            reset = 0;        
            // Add stimulus here
            
            //#100;
            //$fclose(file_output);
        end
       
        always begin        
        #50;    
        clk_in = ~clk_in;
        end
    endmodule
