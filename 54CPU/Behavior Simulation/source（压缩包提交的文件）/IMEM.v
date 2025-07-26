`timescale 1ns / 1ps

/*IMEM 为指令存储器模块，通过调用 ROM 的 IP 核实现。*/

module IMEM( 
    input   [10:0]  addr,   // 指令地址 
    output  [31:0]  data    // 所取指令 
    ); 
     
    dist_mem_gen_0 IM( 
        .a(addr), 
        .spo(data) 
    ); 
     
endmodule
