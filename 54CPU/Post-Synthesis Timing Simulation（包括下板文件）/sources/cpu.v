`timescale 1ns / 1ps

module cpu( 
    input           clk_in,        // 输入时钟信号 
    input           ena,           // 使能信号 
    input           rst,           // 复位信号 
    input [31:0]    imem,          // 指令存储器输出数据 
    input [31:0]    dmem_out,      // 数据存储器输出数据 
    output [31:0]   dmem_in,       // 数据存储器输入数据     
    output [31:0]   dmem_addr,     // 数据存储器访问地址 
    output [1:0]    dmem_width,    // 数据存储器访问宽度 
    output          dmem_w,        // 数据存储器写使能 
    output          dmem_r,        // 数据存储器读使能 
    output [31:0]   PC             // 程序计数器 
    ); 
     
    // R-type 
    wire Add    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b100000) ? 1'b1 : 1'b0; 
    wire Addu   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b100001) ? 1'b1 : 1'b0; 
    wire Sub    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b100010) ? 1'b1 : 1'b0; 
    wire Subu   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b100011) ? 1'b1 : 1'b0; 
    wire And    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b100100) ? 1'b1 : 1'b0; 
    wire Or     = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b100101) ? 1'b1 : 1'b0; 
    wire Xor    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b100110) ? 1'b1 : 1'b0; 
    wire Nor    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b100111) ? 1'b1 : 1'b0; 
    wire Slt    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b101010) ? 1'b1 : 1'b0; 
    wire Sltu   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b101011) ? 1'b1 : 1'b0; 
    wire Sll    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b000000) ? 1'b1 : 1'b0; 
    wire Srl    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b000010) ? 1'b1 : 1'b0; 
    wire Sra    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b000011) ? 1'b1 : 1'b0; 
    wire Sllv   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b000100) ? 1'b1 : 1'b0; 
    wire Srlv   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b000110) ? 1'b1 : 1'b0; 
    wire Srav   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b000111) ? 1'b1 : 1'b0; 
    wire Jr     = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b001000) ? 1'b1 : 1'b0; 
    wire Jalr   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b001001) ? 1'b1 : 1'b0; 
    wire Clz    = (imem[31:26] == 6'b011100 && imem[5:0] == 6'b100000) ? 1'b1 : 1'b0; 
    wire Rtype  = Add || Addu || Sub || Subu || And || Or  || Xor || Nor || Slt || Sltu || 
                    Sll || Srl || Sra || Sllv || Srlv || Srav || Jr || Jalr || Clz ;
    
    // I-type 
    wire Addi   = (imem[31:26] == 6'b001000) ? 1'b1 : 1'b0; 
    wire Addiu  = (imem[31:26] == 6'b001001) ? 1'b1 : 1'b0; 
    wire Andi   = (imem[31:26] == 6'b001100) ? 1'b1 : 1'b0; 
    wire Ori    = (imem[31:26] == 6'b001101) ? 1'b1 : 1'b0; 
    wire Xori   = (imem[31:26] == 6'b001110) ? 1'b1 : 1'b0; 
    wire Lw     = (imem[31:26] == 6'b100011) ? 1'b1 : 1'b0; 
    wire Sw     = (imem[31:26] == 6'b101011) ? 1'b1 : 1'b0; 
    wire Beq    = (imem[31:26] == 6'b000100) ? 1'b1 : 1'b0; 
    wire Bne    = (imem[31:26] == 6'b000101) ? 1'b1 : 1'b0; 
    wire Slti   = (imem[31:26] == 6'b001010) ? 1'b1 : 1'b0; 
    wire Sltiu  = (imem[31:26] == 6'b001011) ? 1'b1 : 1'b0; 
    wire Lui    = (imem[31:26] == 6'b001111) ? 1'b1 : 1'b0; 
    wire Bgez   = (imem[31:26] == 6'b000001) ? 1'b1 : 1'b0;
    wire Lb     = (imem[31:26] == 6'b100000) ? 1'b1 : 1'b0; 
    wire Lbu    = (imem[31:26] == 6'b100100) ? 1'b1 : 1'b0; 
    wire Lh     = (imem[31:26] == 6'b100001) ? 1'b1 : 1'b0; 
    wire Lhu    = (imem[31:26] == 6'b100101) ? 1'b1 : 1'b0; 
    wire Sb     = (imem[31:26] == 6'b101000) ? 1'b1 : 1'b0; 
    wire Sh     = (imem[31:26] == 6'b101001) ? 1'b1 : 1'b0; 
    wire Itype  = Addi || Addiu || Andi || Ori || Xori || Lw || Sw || Beq || Bne || Slti || 
                    Sltiu || Lui || Bgez || Lb || Lbu || Lh || Lhu || Sb || Sh; 
     
    // J-type 
    wire J      = (imem[31:26] == 6'b000010) ? 1'b1 : 1'b0; 
    wire Jal    = (imem[31:26] == 6'b000011) ? 1'b1 : 1'b0; 
    wire Jtype  = J || Jal;          
    
    // Mul & Div 
    wire Divu   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b011011) ? 1'b1 : 1'b0; 
    wire Div    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b011010) ? 1'b1 : 1'b0; 
    wire Multu  = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b011001) ? 1'b1 : 1'b0; 
    wire Mult   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b011000) ? 1'b1 : 1'b0; 
    
    // Exception related 
    wire Syscall= (imem[31:26] == 6'b000000 && imem[5:0] == 6'b001100) ? 1'b1 : 1'b0; 
    wire Teq    = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b110100) ? 1'b1 : 1'b0; 
    wire Break  = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b001101) ? 1'b1 : 1'b0; 
    wire Eret   = (imem[31:26] == 6'b010000 && imem[5:0] == 6'b011000) ? 1'b1 : 1'b0; 
    wire Exception; 

    // CP0 & HI & LO 
    wire Mfc0   = (imem[31:21] == 11'b010000_00000 && imem[5:0] == 6'b000000) ? 1'b1 : 1'b0; 
    wire Mfhi   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b010000) ? 1'b1 : 1'b0; 
    wire Mflo   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b010010) ? 1'b1 : 1'b0; 
    wire Mtc0   = (imem[31:21] == 11'b010000_00100 && imem[5:0] == 6'b000000) ? 1'b1 : 1'b0; 
    wire Mthi   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b010001) ? 1'b1 : 1'b0; 
    wire Mtlo   = (imem[31:26] == 6'b000000 && imem[5:0] == 6'b010011) ? 1'b1 : 1'b0; 
    
    // PC 
    wire [31:0] PC_in; 
    //wire PC_ena;
    wire [31:0] NPC = PC + 32'd4; 
       
    // ALU 
    wire [3:0] ALUC; 
    wire zero, carry, negative, overflow; 
    wire [31:0] A; 
    wire [31:0] B; 
    wire [31:0] Y; 
    
    // Regfile 
    wire reg_wena; 
    wire [4:0] rsc; 
    wire [4:0] rtc; 
    wire [4:0] rdc; 
    wire [31:0] rs; 
    wire [31:0] rt; 
    wire [31:0] rd; 
    
    // HI & LO 
    wire HI_w;//写使能信号
    wire LO_w;  //写使能信号
    wire [31:0] HI_in; 
    wire [31:0] HI_out; 
    wire [31:0] LO_in; 
    wire [31:0] LO_out; 
    
    // MUX 
    wire [1:0] mux_a; 
    wire [1:0] mux_b; 
    wire [2:0] mux_pc; //change
    wire [1:0] mux_hi; //new
    wire [1:0] mux_lo;//new
    wire [2:0] mux_rd; //new
    
    // CP0 
    wire [4:0]  cp0_cause; 
    wire [4:0]  cp0_rdc; 
    wire [31:0] cp0_outdata; 
    wire [31:0] cp0_exc_addr;
    
    // Ext 
    wire [31:0] ext5; 
    wire        extb; 
    wire [31:0] ext16; 
    wire [31:0] ext18; 
    wire [31:0] add; //ext18 + npc
    wire [31:0] concat; // ||
    wire [31:0] ext16_d;//Data扩展
    wire [31:0] ext8_d;//Data扩展
    
    // Mul & Div 
    wire mult_sign = Mult;
    wire div_sign  = Div;
    wire [31:0] div_q; 
    wire [31:0] div_r; 
    wire [31:0] mult_hi; 
    wire [31:0] mult_lo; 
    wire div_busy;
    wire mult_busy;

    //CLZ
    wire [31:0] clz_out;
 
    
    //ALU
    assign ALUC[3] = Slt || Sltu || Sll || Srl || Sra || Sllv || Srlv || Srav || Slti || Sltiu || Lui; 
    assign ALUC[2] = And || Or || Xor || Nor || Sra || Srav || Andi || Ori || Xori || Lui; 
    assign ALUC[1] = Sub || Subu || Xor || Nor || Sll || Srl || Sllv || Srlv || Xori || Beq || Bne; 
    assign ALUC[0] = Addu || Subu || Or || Nor || Sltu || Srl || Srlv || Addiu || Ori || Beq || Bne || Sltiu || Lui;    
                                
    // MUX 
    assign mux_pc[2] = Break || Syscall || Eret ||(Teq && (rs == rt));
    assign mux_pc[1] = Jr || J || Jal || Jalr; //jr jalr 10; j jal 11
    assign mux_pc[0] = (Beq && zero) || (Bne && ~zero)|| J || Jal || (Bgez && ~rs[31]); //beq bne 01 ; j jal 11
    assign mux_a[1]  = Jal; //jal 10 
    assign mux_a[0]  = Sll || Srl || Sra || Sllv || Srlv || Srav;  // 01
    assign mux_b[1]  = Jal || Jalr; // jal 10 jalr 11
    assign mux_b[0]  = Addi || Addiu || Andi || Ori || Xori || Lw || Sw || Slti || Sltiu || Lui || Lbu || Lb || Lhu|| Lh|| Sb|| Sh || Jalr ; // 01
    assign mux_hi[1] = Mthi;
    assign mux_hi[0] = Mult||Multu;
    assign mux_lo[1] = Mtlo;
    assign mux_lo[0] = Mult || Multu;
    assign mux_rd[2] = Clz || Mfc0 || Mflo|| Mfhi;
    assign mux_rd[1] = Clz || Mfc0 || Lh || Lb || Lhu || Lbu;
    assign mux_rd[0] = Clz || Mflo || Lh || Lhu || Lw;
               
    // DMEM 
    assign dmem_w = Sw || Sb || Sh; 
    assign dmem_r = Lw || Lb || Lh || Lbu || Lhu; 
    assign dmem_width[1] = Sw || Lw; //32bit=10
    assign dmem_width[0] = Sh || Lh || Lhu; //16bit=01 8bit=00
    assign dmem_addr = (dmem_w || dmem_r) ? Y : 32'bz; 
    assign dmem_in = rt; 
    
    //regfile
    assign rsc = imem[25:21]; 
    assign rtc = imem[20:16]; 
    assign rdc = (Rtype || Mfhi || Mflo) ? imem[15:11] : (Itype || Mfc0) ? imem[20:16] : 5'd31; //mfc0可能要改
    assign reg_wena = !(Jr || Sw || Beq || Bne || J || Div || Divu || Mult || Multu || Bgez || Sb ||
                        Sh|| Break || Syscall || Eret || Mthi || Mtlo || Mtc0 || Teq); //寄存器堆的使能端
                        
    // HI & LO 
    assign HI_w = ena && (Divu || Div || Multu || Mult || Mthi); 
    assign LO_w = ena && (Divu || Div || Multu || Mult || Mtlo); 
    
    // CP0 
    assign Exception = Syscall || Break || (Teq && (rs == rt)); 
    assign cp0_cause = Syscall ? 5'b01000 : Break ? 5'b01001 : Teq ? 5'b01101 : 5'bz; 
    assign cp0_rdc = imem[15:11]; 

    //CLZ
    assign clz_out =rs[31]==1? 32'h00000000:rs[30]==1? 32'h00000001:rs[29]==1? 32'h00000002:rs[28]==1? 32'h00000003:rs[27]==1? 32'h00000004:
             rs[26]==1? 32'h00000005:rs[25]==1? 32'h00000006:rs[24]==1? 32'h00000007:rs[23]==1? 32'h00000008:rs[22]==1? 32'h00000009:
             rs[21]==1? 32'h0000000a:rs[20]==1? 32'h0000000b:rs[19]==1? 32'h0000000c:rs[18]==1? 32'h0000000d:rs[17]==1? 32'h0000000e:
             rs[16]==1? 32'h0000000f:rs[15]==1? 32'h00000010:rs[14]==1? 32'h00000011:rs[13]==1? 32'h00000012:rs[12]==1? 32'h00000013:
             rs[11]==1? 32'h00000014:rs[10]==1? 32'h00000015:rs[9]==1? 32'h00000016:rs[8]==1? 32'h00000017:rs[7]==1? 32'h00000018:
             rs[6]==1? 32'h00000019:rs[5]==1? 32'h0000001a:rs[4]==1? 32'h0000001b:rs[3]==1? 32'h0000001c:rs[2]==1? 32'h0000001d:
             rs[1]==1? 32'h0000001e:rs[0]==1? 32'h0000001f:32'h00000020;


    // Ext 和其他模块 
    assign ext5  = Sllv || Srlv || Srav ? {27'b0, rs[4:0] }: {  27'b0, imem[10:6] }; //rs或sa
    assign extb  = ( Andi || Ori || Xori || Lui) ? 1'b0 : imem[15]; //符号扩展or零扩展
    assign ext16 = { {16 { extb }}, imem[15:0] }; 
    assign ext18 = { {14{ imem[15] }}, imem[15:0], 2'b0 }; 
    assign add = ext18 + NPC; 
    assign concat   = { PC[31:28], imem[25:0], 2'b0 }; //j jal
    assign ext8_d = Lbu ? { {24'b0}, dmem_out[7:0]}:{{24{ dmem_out[7] }}, dmem_out[7:0]};//check
    //assign ext8_d = {{24{ dmem_out[7] }}, dmem_out[7:0]};
    assign ext16_d= Lhu ? { {16'b0}, dmem_out[15:0]}:{{16{ dmem_out[15] }}, dmem_out[15:0]};//check
     
    //MUX
    MUX8 MUX_PC( 
        .d0(NPC), 
        .d1(add), 
        .d2(rs), 
        .d3(concat), 
        .d4(cp0_exc_addr),
        .d5(32'b0),
        .d6(32'b0),
        .d7(32'b0),
        .s(mux_pc), 
        .y(PC_in) 
        );   
        
    MUX8 MUX_RD( 
        .d0(Y), 
        .d1(dmem_out), 
        .d2(ext8_d), 
        .d3(ext16_d), 
        .d4(HI_out),
        .d5(LO_out),
        .d6(cp0_outdata),
        .d7(clz_out),
        .s(mux_rd), 
        .y(rd) 
        ); 
        
    MUX4 MUX_A( 
        .d0(rs),
        .d1(ext5), 
        .d2(PC), 
        .d3(32'b0), 
        .s(mux_a), 
        .y(A) 
        ); 
         
    MUX4 MUX_B( 
        .d0(rt), 
        .d1(ext16), 
        .d2(32'd4), 
        .d3(32'b0), 
        .s(mux_b), 
        .y(B) 
        ); 
       
    MUX4 MUX_HI( 
        .d0(div_r), 
        .d1(mult_hi), 
        .d2(rs), 
        .d3(32'b0), 
        .s(mux_hi), 
        .y(HI_in) 
        ); 
        
    MUX4 MUX_LO( 
        .d0(div_q), 
        .d1(mult_lo), 
        .d2(rs), 
        .d3(32'b0), 
        .s(mux_lo), 
        .y(LO_in) 
        );  
        
/*=================================*/
    PC pc( 
        .clk(clk_in), 
        .ena(1'b1), 
        .rst(rst), 
        .PC_in(PC_in), 
        .PC_out(PC) 
        );      
         
     HI_LO  hi_lo(
        .HI_LO_clk(clk_in),
        .HI_LO_ena(1'b1),
        .HI_LO_rst(rst),
        .HI_in(HI_in),
        .LO_in(LO_in),
        .HI_w(HI_w),
        .LO_w(LO_w),
        .HI_out(HI_out),
        .LO_out(LO_out)
        );       
            
    MULT mult(
        .sign_flag(mult_sign),    //是否是有符号乘法
        .A(rs),     //输入的乘数A
        .B(rt),     //输入的乘数B
        .HI(mult_hi),   //高32位结果
        .LO(mult_lo)    //低32位结果
        );
        
    DIV div(
        .sign_flag(div_sign),    //是否是有符号除法
        .A(rs),     //输入的被除数
        .B(rt),     //输入的除数
        .R(div_r),    //余数
        .Q(div_q)     //商
        );
     
    ALU alu( 
       .A(A), 
       .B(B), 
       .Y(Y), 
       .ALUC(ALUC), 
       .zero(zero), 
       .carry(carry), 
       .negative(negative), 
       .overflow(overflow) 
       ); 
       
    regfile cpu_ref( 
        .ena(ena), 
        .rst(rst), 
        .clk(clk_in), 
        .w_ena(reg_wena), 
        .Rdc(rdc), 
        .Rsc(rsc), 
        .Rtc(rtc),
        .Rd(rd), 
        .Rs(rs), 
        .Rt(rt) 
        );
        
    // 实例化CP0
    CP0 cp0(
        .cp0_clk(clk_in),
        .cp0_rst(rst),
        .cp0_ena(1'b1),
        .MFC0(Mfc0),
        .MTC0(Mtc0),
        .ERET(Eret),
        .PC(NPC),
        .addr(imem[15:11]),
        .cause(cp0_cause),
        .data_in(rt),
        .CP0_out(cp0_outdata),
        .EPC_out(cp0_exc_addr)
        );
endmodule

