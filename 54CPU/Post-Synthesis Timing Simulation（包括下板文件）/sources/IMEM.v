`timescale 1ns / 1ps

/*IMEM Ϊָ��洢��ģ�飬ͨ������ ROM �� IP ��ʵ�֡�*/

module IMEM( 
    input   [10:0]  addr,   // ָ���ַ 
    output  [31:0]  data    // ��ȡָ�� 
    ); 
     
    dist_mem_gen_0 IM( 
        .a(addr), 
        .spo(data) 
    ); 
     
endmodule
