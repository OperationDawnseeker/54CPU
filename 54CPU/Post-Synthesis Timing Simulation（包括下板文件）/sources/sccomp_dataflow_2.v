`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/24 14:52:43
// Design Name: 
// Module Name: sccomp_dataflow_2
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


module sccomp_dataflow_2(
    input clk_in,   // 时钟信号 
    input reset,    // 复位信号 
    output [7:0] o_seg,//输出内容
    output [7:0] o_sel //片选信号

); 
     
    wire [31:0] imem_data; 
    wire [31:0] pc;
    wire [31:0] inst;
    
    wire dmem_w;
    wire dmem_r; 
    wire [10:0] dm_addr; 
    wire [10:0] im_addr; 
    wire [31:0] dmem_addr_pc; 
    wire [31:0] dmem_wdata; 
    wire [31:0] dmem_rdata; 
    
    assign inst = imem_data; 
    assign im_addr = (pc - 32'h00400000) / 4; 
    assign dm_addr = (dmem_addr_pc - 32'h10010000) / 4; 
     
    IMEM imem( 
        .addr(im_addr), 
        .data(imem_data) 
    ); 
     
     DMEM dmem( 
            .clk(clk_cpu), 
            .ena(1'b1), 
            .DMEM_W(dmem_w), 
            .DMEM_R(dmem_r), 
            .DMEM_width(dmem_width), 
            .DM_addr(dm_addr), 
            .DM_wdata(dmem_wdata), 
            .DM_rdata(dmem_rdata) 
        ); 
        
    cpu sccpu(     
                .clk_in(clk_cpu), 
                .ena(1'b1), 
                .rst(reset), 
                .PC(pc),
                .imem(imem_data), 
                .dmem_out(dmem_rdata), 
                .dmem_in(dmem_wdata), 
                .dmem_width(dmem_width), 
                .dmem_addr(dmem_addr_pc), 
                .dmem_w(dmem_w), 
                .dmem_r(dmem_r) 
            ); 
     
    seg7x16 seg7x16_inst(
        .clk(clk_in),
        .reset(reset),
        .cs(1'b1),
        .i_data(imem_data),
        .o_seg(o_seg),
        .o_sel(o_sel)
    );
    
    Divider Divider_inst(
       .clk(clk_in),                   //系统时钟
       .rst_n(~reset),                 //复位信号
       .clk_out(clk_cpu)               //输出适配CPU的时钟
        );

endmodule
