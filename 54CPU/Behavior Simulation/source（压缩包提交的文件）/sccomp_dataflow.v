`timescale 1ns / 1ps

module sccomp_dataflow( 
    input clk_in,  // 输入时钟信号 
    input reset,   // 复位信号 
    output [31:0] inst, // 指令输出 
    output [31:0] pc    // 程序计数器输出 
); 
     
    wire [31:0] imem_data; 
     
    wire dmem_w; 
    wire dmem_r; 
    wire [1:0] dmem_width; 
    wire [31:0] dm_addr; 
    wire [10:0] im_addr; 
    wire [31:0] dmem_addr_pc; 
    wire [31:0] dmem_wdata; 
    wire [31:0] dmem_rdata; 
     
    assign inst = imem_data; 
    assign im_addr = (pc - 32'h00400000) / 4; 
    assign dm_addr = dmem_addr_pc - 32'h10010000; 
     
    IMEM imem( 
        .addr(im_addr), 
        .data(imem_data) 
    ); 
     
    DMEM dmem( 
        .clk(clk_in), 
        .ena(1'b1), 
        .DMEM_W(dmem_w), 
        .DMEM_R(dmem_r), 
        .DMEM_width(dmem_width), 
        .DM_addr(dm_addr), 
        .DM_wdata(dmem_wdata), 
        .DM_rdata(dmem_rdata) 
    ); 
     
    cpu sccpu(     
        .clk_in(clk_in), 
        .ena(1'b1), 
        .rst(reset), 
        .PC(pc),         .imem(imem_data), 
        .dmem_out(dmem_rdata), 
        .dmem_in(dmem_wdata), 
        .dmem_width(dmem_width), 
        .dmem_addr(dmem_addr_pc), 
        .dmem_w(dmem_w), 
        .dmem_r(dmem_r) 
    ); 
     

endmodule 