`timescale 1ns / 1ps
module DMEM( 
    input           clk,     // ʱ���ź� 
    input           ena,     // ʹ���ź� 
    input           DMEM_W, // ���ݴ洢��дʹ���ź� 
    input           DMEM_R, // ���ݴ洢����ʹ���ź� 
    input      [1:0] DMEM_width, // ���ݴ洢����ȿ����ź� 
    input      [31:0]  DM_addr,  // ���ݴ洢����ַ 
    input      [31:0]  DM_wdata, // ��д�����ݴ洢�������� 
    output reg [31:0]  DM_rdata  // �����ݴ洢����ȡ������ 
    ); 
    reg [31:0] DM[0:1023];
    //reg [7:0] DM0 [0:511]; 
    //reg [7:0] DM1 [0:511]; 
    //reg [7:0] DM2 [0:511]; 
    //reg [7:0] DM3 [0:511]; 
     
    reg [31:0] buffer; 
     
    always@(posedge clk) begin 
        buffer<=DM_addr;
        if (ena && DMEM_W) begin 
            case(DMEM_width) 
                2'b10:  // 32bit
                 begin 
                    DM[DM_addr >> 2] <= DM_wdata; 
                end 
                2'b01:  // 16bit 
                begin 
                    case(DM_addr[1]) 
                        2'b0: 
                        begin 
                            DM[DM_addr >> 2][15:0] <= DM_wdata[15:0]; 
                        end          
                        2'b1: 
                        begin 
                            DM[DM_addr >> 2][31:16] <= DM_wdata[15:0]; 
                        end 
                    endcase       
                end 
                2'b00:  // 8bit 
                begin 
                    case(DM_addr[1:0]) 
                        2'b00:    DM[DM_addr >> 2][7:0] <= DM_wdata[7:0];       
                        2'b01:    DM[DM_addr >> 2][15:8] <= DM_wdata[7:0]; 
                        2'b10:    DM[DM_addr >> 2][23:16] <= DM_wdata[7:0]; 
                        2'b11:    DM[DM_addr >> 2][31:24] <= DM_wdata[7:0]; 
                    endcase   
                end 
            endcase 
        end  
    end 
     
    always @(*) 
    begin 
        if (ena && DMEM_R) 
        begin 
            case(DMEM_width) 
                2'b10:  // 32bit  
                    DM_rdata <=  DM[DM_addr >> 2];
                2'b01:  // 16bit 
                begin 
                    case(DM_addr[1]) 
                        2'b0:   DM_rdata <= { 16'b0, DM[DM_addr >> 2][15:0]};       
                        2'b1:   DM_rdata <= { 16'b0, DM[DM_addr >> 2][31:16] }; 
                    endcase
                end 
                2'b00:  // 8bit 
                begin 
                    case(DM_addr[1:0]) 
                        2'b00:    DM_rdata = { 24'b0, DM[DM_addr >> 2][7:0] };      
                        2'b01:    DM_rdata = { 24'b0, DM[DM_addr >> 2][15:8] };  
                        2'b10:    DM_rdata = { 24'b0, DM[DM_addr >> 2][23:16] };  
                        2'b11:    DM_rdata = { 24'b0, DM[DM_addr >> 2][31:24] };
                    endcase   
                end 
            endcase 
        end 
        else  
            DM_rdata = 32'bz; 
    end 
     

endmodule 