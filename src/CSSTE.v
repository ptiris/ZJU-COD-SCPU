module CSSTE(
    input         clk_100mhz,
    input         RSTN,
    input  [3:0]  BTN_y,
    input  [15:0] SW,
    output [3:0]  Blue,
    output [3:0]  Green,
    output [3:0]  Red,
    output        HSYNC,
    output        VSYNC,
    output [15:0] LED_out,
    output [7:0] AN,
    output [7:0] segment
);

    wire [3:0]BTN_OK;
    wire [15:0]SW_OK;
    wire [31:0]clk_div;
    wire rst;
    wire clk_cpu;
    SAnti_jitter U9(
        .clk(clk_100mhz),
        .RSTN(RSTN),
        .Key_y(BTN_y),
        .SW(SW),

        .BTN_OK(BTN_OK),
        .SW_OK(SW_OK),
        .rst(rst)
    );

    clk_div U8(
        .clk(clk_100mhz),
        .rst(rst),
        .SW2(SW_OK[2]),
        .SW8(SW_OK[8]),
        .STEP(SW_OK[10]),

        .Clk_CPU(clk_cpu),
        .clkdiv(clk_div)
    );

    wire counter_we;
    wire [31:0]counter_val;
    wire [1:0]counter_ch;
    wire counter0_OUT,counter1_OUT,counter2_OUT;
    wire [31:0]counter_out;
    wire [31:0]Peripheral_in;
    
    Counter_x U10(
        .clk(~clk_cpu),
        .rst(rst),
        .clk0(clk_div[6]),
        .clk1(clk_div[9]),
        .clk2(clk_div[11]),
        .counter_we(counter_we),
        .counter_val(Peripheral_in),
        .counter_ch(counter_ch),

        .counter0_OUT(counter0_OUT),
        .counter1_OUT(counter1_OUT),
        .counter2_OUT(counter2_OUT),
        .counter_out(counter_out)
    );

    wire [3:0]mem_w;
    wire [31:0]Cpu_data2bus;
    wire [31:0]addr_bus;
    wire [31:0]ram_data_out;
    wire [15:0]led_out;
    wire [31:0]Cpu_data4bus;
    wire [31:0]ram_data_in;
    wire data_ram_we;
    wire [9:0]ram_addr;
    wire GPIOf0000000_we;
    wire GPIOe0000000_we;

    MIO_BUS U4(
        .clk(clk_100mhz),
        .rst(rst),
        .BTN(BTN_OK),
        .SW(SW_OK),
        .mem_w(|mem_w),
        .Cpu_data2bus(Cpu_data2bus),
        .addr_bus(addr_bus),
        .ram_data_out(ram_data_out),
        .led_out(LED_out),
        .counter_out(counter_out),
        .counter0_out(counter0_OUT),
        .counter1_out(counter1_OUT),
        .counter2_out(counter2_OUT),

        .Cpu_data4bus(Cpu_data4bus),
        .ram_data_in(ram_data_in),
        .ram_addr(ram_addr),
        .data_ram_we(data_ram_we),
        .GPIOf0000000_we(GPIOf0000000_we),
        .GPIOe0000000_we(GPIOe0000000_we),
        .counter_we(counter_we),
        .Peripheral_in(Peripheral_in)
    );

    wire [31:0]inst;
    wire [31:0]PC;
    wire [7:0]point_out;
    wire [7:0]LE_out;
    wire [31:0]Disp_num;
    Multi_8CH32 U5(
        .clk(~clk_cpu),
        .rst(rst),
        .EN(GPIOe0000000_we),
        .Test(SW[7:5]),
        .point_in({clk_div[31:0],clk_div[31:0]}),
        .LES(64'b0),
        .Data0(Peripheral_in),
        .data1({2'b0,PC[31:2]}),
        .data2(inst),
        .data3(counter_out),
        .data4(addr_bus),
        .data5(Cpu_data2bus),
        .data6(Cpu_data4bus),
        .data7(PC),

        .point_out(point_out),
        .LE_out(LE_out),
        .Disp_num(Disp_num)
    );

    Seg7_Dev_1 U6(
        .disp_num(Disp_num),
        .point(point_out),
        .les(LE_out),
        .scan({clk_div[18],clk_div[17],clk_div[16]}),

        .AN(AN),
        .segment(segment)
    );

    ROM_B U2(
        .a(PC[11:2]),
        .spo(inst)
    );

    RAM_B U3(
        .clka(~clk_100mhz),
        .wea(mem_w),
        .addra(ram_addr),
        .dina(ram_data_in),

        .douta(ram_data_out)
    );

    
    SPIO U7(
        .clk(~clk_cpu),
        .rst(rst),
        .Start(clk_div[20]),
        .EN(GPIOf0000000_we),
        .P_Data(Peripheral_in),
        
        .counter_set(counter_ch),
        .LED_out(LED_out)
        );


    wire ALUSrc_B,Jump,Branch,RegWrite,JumpSel,BranchSel,PC_RDSel;
    wire [31:0]Rs1_data,Rs2_data,Rd_data;
    wire [4:0]Rs1_addr,Rs2_addr,Rd_addr;
    wire [3:0]ALU_Control;
    wire [2:0]MemtoReg;
    wire [31:0] Reg00; 
    wire [31:0] Reg01; 
    wire [31:0] Reg02; 
    wire [31:0] Reg03; 
    wire [31:0] Reg04; 
    wire [31:0] Reg05; 
    wire [31:0] Reg06; 
    wire [31:0] Reg07; 
    wire [31:0] Reg08; 
    wire [31:0] Reg09; 
    wire [31:0] Reg10; 
    wire [31:0] Reg11; 
    wire [31:0] Reg12; 
    wire [31:0] Reg13; 
    wire [31:0] Reg14; 
    wire [31:0] Reg15; 
    wire [31:0] Reg16; 
    wire [31:0] Reg17; 
    wire [31:0] Reg18; 
    wire [31:0] Reg19; 
    wire [31:0] Reg20; 
    wire [31:0] Reg21; 
    wire [31:0] Reg22; 
    wire [31:0] Reg23; 
    wire [31:0] Reg24; 
    wire [31:0] Reg25; 
    wire [31:0] Reg26; 
    wire [31:0] Reg27; 
    wire [31:0] Reg28; 
    wire [31:0] Reg29; 
    wire [31:0] Reg30; 
    wire [31:0] Reg31;
    wire [31:0] Data_in_field;
    wire csr_w;
    wire csr_immsel;
    wire ecall;
    wire ill_inst;
    wire [1:0]csr_opctrl;
    wire [31:0]mepc_bypasss_out;
    wire [31:0]mscause_bypass_out;
    wire [31:0]mtval_bypass_out;
    wire [31:0]mtvec_bypass_out;
    wire [31:0]mstatus_bypass_out;

    SCPU U1(
        .clk(clk_cpu),
        .rst(rst),
        .inst_in(inst),
        .Data_in(Cpu_data4bus),
        
        .MemRW(mem_w),
        .Addr_out(addr_bus),
        .Data_out(Cpu_data2bus),
        .PC_out(PC),

        .Rs1_data(Rs1_data),
        .Rs2_data(Rs2_data),
        .Rs1_addr(Rs1_addr),
        .Rs2_addr(Rs2_addr),
        .Rd_addr(Rd_addr),
        .Rd_data(Rd_data),
        .ALUSrc_B(ALUSrc_B),
        .MemtoReg(MemtoReg),
        .Jump(Jump),
        .Branch(Branch),
        .RegWrite(RegWrite),
        .ALU_Control(ALU_Control),
        .JumpSel(JumpSel),


        .Reg00(Reg00), 
        .Reg01(Reg01), 
        .Reg02(Reg02), 
        .Reg03(Reg03), 
        .Reg04(Reg04), 
        .Reg05(Reg05), 
        .Reg06(Reg06), 
        .Reg07(Reg07), 
        .Reg08(Reg08), 
        .Reg09(Reg09), 
        .Reg10(Reg10), 
        .Reg11(Reg11), 
        .Reg12(Reg12), 
        .Reg13(Reg13), 
        .Reg14(Reg14), 
        .Reg15(Reg15), 
        .Reg16(Reg16), 
        .Reg17(Reg17), 
        .Reg18(Reg18), 
        .Reg19(Reg19), 
        .Reg20(Reg20), 
        .Reg21(Reg21), 
        .Reg22(Reg22), 
        .Reg23(Reg23), 
        .Reg24(Reg24), 
        .Reg25(Reg25), 
        .Reg26(Reg26), 
        .Reg27(Reg27), 
        .Reg28(Reg28), 
        .Reg29(Reg29), 
        .Reg30(Reg30), 
        .Reg31(Reg31),
        .Data_in_field(Data_in_field),
        .csr_w(csr_w),
        .csr_immsel(csr_immsel),
        .csr_opctrl(csr_opctrl),
        .ecall(ecall),
        .ill_inst(ill_inst),

        .mepc_bypasss_out(mepc_bypasss_out),
        .mscause_bypass_out(mscause_bypass_out),
        .mtval_bypass_out(mtval_bypass_out),
        .mtvec_bypass_out(mtvec_bypass_out),
        .mstatus_bypass_out(mstatus_bypass_out)
    );

    VGA U11(
    .clk_25m(clk_div[1]),
    .clk_100m(clk_100mhz),
    .rst(rst),
    .pc(PC),
    .inst(inst),
    .alu_res(addr_bus),
    .mem_wen(mem_w),
    .dmem_o_data(Data_in_field),
    .dmem_i_data(ram_data_in),
    .dmem_addr(addr_bus),

    .hs(HSYNC),
    .vs(VSYNC),
    .vga_r(Red),
    .vga_b(Blue),
    .vga_g(Green),

    .rs1           (Rs1_addr               ),
    .rs1_val       (Rs1_data               ),
    .rs2           (Rs2_addr               ),
    .rs2_val       (Rs2_data               ),
    .rd            (Rd_addr               ),
    .reg_i_data    (Rd_data               ),
    .reg_wen       (RegWrite               ),
    .is_imm        (0               ),
    .is_auipc      (0               ),
    .is_lui        (0               ),
    .imm           (0               ),
    .a_val         (0               ),
    .b_val         (0               ),
    .alu_ctrl      (ALU_Control     ),
    .cmp_ctrl      (0               ),
    .cmp_res       (0               ),
    .is_branch     (Branch               ),
    .is_jal        (Jump               ),
    .is_jalr       (JumpSel               ),
    .do_branch     (Branch               ),
    .pc_branch     (0               ),
    .mem_ren       (0               ),
    .csr_wen       (csr_w               ),
    .csr_ind       (0               ),
    .csr_ctrl      (csr_opctrl               ),
    .csr_r_data    (0               ),
    .x0 (Reg00), 
    .ra (Reg01), 
    .sp (Reg02), 
    .gp (Reg03), 
    .tp (Reg04), 
    .t0 (Reg05), 
    .t1 (Reg06), 
    .t2 (Reg07), 
    .s0 (Reg08), 
    .s1 (Reg09), 
    .a0 (Reg10), 
    .a1 (Reg11), 
    .a2 (Reg12), 
    .a3 (Reg13), 
    .a4 (Reg14), 
    .a5 (Reg15), 
    .a6 (Reg16), 
    .a7 (Reg17), 
    .s2 (Reg18), 
    .s3 (Reg19), 
    .s4 (Reg20), 
    .s5 (Reg21), 
    .s6 (Reg22), 
    .s7 (Reg23), 
    .s8 (Reg24), 
    .s9 (Reg25), 
    .s10(Reg26), 
    .s11(Reg27), 
    .t3 (Reg28), 
    .t4 (Reg29), 
    .t5 (Reg30), 
    .t6 (Reg31),
    .mstatus_o     (mstatus_bypass_out               ),
    .mcause_o      (mscause_bypass_out               ),
    .mepc_o        (mepc_bypasss_out               ),
    .mtval_o       (mtval_bypass_out              ),
    .mtvec_o       (mtvec_bypass_out               ),
    .mie_o         (0               ),
    .mip_o         (0               )
    );
endmodule