module DataPath(
    input            clk,
    input            rst,
    input            MIO_ready,
    input [2:0]      ImmSel,
    input            ALUSrc_B,
    input [2:0]      MemtoReg,
    input            Jump,
    input            JumpSel,
    input            Branch,
    input            BranchSel,
    input            RegWrite,
    input [3:0]      MemRW,
    input [3:0]      ALU_Control,
    input            CPU_MIO,
    input [31:0]     Data_in,
    input [31:0]     inst_in,
    input [2:0]      Mem_dataSel,
    input            PC_RDSel,
    input            csr_w,
    input [1:0]      csr_opctrl,
    input            csr_immsel,
    input            ecall,
    input            ill_inst,
    input            expt_int,
    input            IO_break,
    input            mret,

    output [31:0]    ALU_out,
    output [31:0]    Data_out,
    output [3:0]     Save_base,
    output reg [31:0]    PC_out,

    output [31:0] Reg00, 
    output [31:0] Reg01, 
    output [31:0] Reg02, 
    output [31:0] Reg03, 
    output [31:0] Reg04, 
    output [31:0] Reg05, 
    output [31:0] Reg06, 
    output [31:0] Reg07, 
    output [31:0] Reg08, 
    output [31:0] Reg09, 
    output [31:0] Reg10, 
    output [31:0] Reg11, 
    output [31:0] Reg12, 
    output [31:0] Reg13, 
    output [31:0] Reg14, 
    output [31:0] Reg15, 
    output [31:0] Reg16, 
    output [31:0] Reg17, 
    output [31:0] Reg18, 
    output [31:0] Reg19, 
    output [31:0] Reg20, 
    output [31:0] Reg21, 
    output [31:0] Reg22, 
    output [31:0] Reg23, 
    output [31:0] Reg24, 
    output [31:0] Reg25, 
    output [31:0] Reg26, 
    output [31:0] Reg27, 
    output [31:0] Reg28, 
    output [31:0] Reg29, 
    output [31:0] Reg30, 
    output [31:0] Reg31,
    output [31:0] Data_in_field,

    output [31:0]Rs1_data,
    output [31:0] Rs2_data,
    output [31:0]Rd_data,
    output [4:0]Rs1_addr,
    output [4:0]Rs2_addr,
    output [4:0]Rd_addr,

    output [31:0]mepc_bypasss_out,
    output [31:0]mscause_bypass_out,
    output [31:0]mtval_bypass_out,
    output [31:0]mtvec_bypass_out,
    output [31:0]mstatus_bypass_out
);

    reg [31:0]PC_next;
    always @(posedge clk or posedge rst) begin
        if(rst)PC_out <= 0;
        else begin
            PC_out <= PC_next;
        end
    end

    wire [31:0]Imm_out;
    ImmGen  ImmGen_inst (
        .ImmSel(ImmSel),
        .inst_field(inst_in),
        .Imm_out(Imm_out)
    );

    wire [31:0]ALU_B;
    wire [31:0]PC_4,PC_BJ,PC_RD;//Branch or Jump Results for PC.
    wire [31:0]Rs1_data,Rs2_data;
    assign Rs1_addr = inst_in[19:15];
    assign Rs2_addr = inst_in[24:20];
    assign Rd_addr  = inst_in[11:7];

    Regs REG_U2(
        .clk(clk),
        .rst(rst),
        .Rs1_addr(inst_in[19:15]), 
        .Rs2_addr(inst_in[24:20]), 
        .Wt_addr(inst_in[11:7]),
        .Rs1_data(Rs1_data), 
        .Rs2_data(Rs2_data),
        .Wt_data(Rd_data), 
        .RegWrite(RegWrite),
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
        .Reg31(Reg31)
    );
    /*  
        PC_BJ = P1 + P2 
        P1 = R1_data or PC
        P2 = imm
    */
    wire [7:0]Data_bias = (ALU_out[1:0] << 3);
    wire [1:0]Byte_bias = ALU_out[1:0];
    Data_inGen Data_in_U3(
        .Data_in(Data_in),
        .Mem_dataSel(Mem_dataSel),
        .Data_in_field(Data_in_field),
        .Byte_bias(Byte_bias)
    );
    assign PC_4 = PC_out + 4;
    assign PC_BJ = (JumpSel == 1'b1)?Rs1_data + Imm_out:PC_out + Imm_out;
    assign PC_RD = (PC_RDSel)?PC_out + Imm_out:PC_4;

    //CSR Regs
    parameter trap_base = 31'h0000fffc;
    wire [11:0]     csr_raddr,csr_waddr;
    wire            csr_w;
    wire [31:0]     csr_rdata,csr_wdata,csr_imm,csr_opnum;
    
    assign csr_waddr = inst_in[31:20];
    assign csr_raddr = inst_in[31:20];
    assign csr_imm = {{27{1'b0}},inst_in[19:15]};
    assign csr_opnum = (csr_immsel)?csr_imm:Rs1_data;
    assign csr_wdata = (csr_opctrl == 2'b00)?csr_opnum:
    (csr_opctrl == 2'b01)?csr_opnum|csr_rdata:(~csr_opnum)&csr_rdata;
    
    reg [31:0]mepc_bypasss_in,mscause_bypass_in,mtval_bypass_in,mstatus_bypass_in;
    wire [31:0]mepc_bypasss_out,mscause_bypass_out,mtval_bypass_out,mtvec_bypass_out,mstatus_bypass_out;
    reg [1:0]csr_wsc_mode;
    CSRRegs CSR_U5(
        .clk(clk),
        .rst(rst),
        .raddr(csr_raddr),
        .waddr(csr_waddr),
        .csr_w(csr_w),
        .csr_wsc_mode(csr_wsc_mode),
        .rdata(csr_rdata),
        .wdata(csr_wdata),
        .expt_int(expt_int),
        .mepc_bypasss_in(mepc_bypasss_in),
        .mscause_bypass_in(mscause_bypass_in),
        .mtval_bypass_in(mtval_bypass_in),
        .mstatus_bypass_in(mstatus_bypass_in),
        
        .mepc_bypasss_out(mepc_bypasss_out),
        .mscause_bypass_out(mscause_bypass_out),
        .mtval_bypass_out(mtval_bypass_out),
        .mtvec_bypass_out(mtvec_bypass_out),
        .mstatus_bypass_out(mstatus_bypass_out)
        );
    always @(*) begin
        if(mstatus_bypass_out[3] && expt_int)begin
            csr_wsc_mode      = 2'b01;
            mstatus_bypass_in = {mstatus_bypass_out[31:4],1'b0,mscause_bypass_out[2:0]};    //set trap enable
            mscause_bypass_in = {ecall|IO_break,28'b0,IO_break,ecall,ill_inst};             //set cause for trap
            mepc_bypasss_in   = PC_out;
            mtval_bypass_in   = inst_in;
        end 
        else begin
            csr_wsc_mode      = 2'b00;
            mstatus_bypass_in = mstatus_bypass_out;    //set trap enable
            mscause_bypass_in = mscause_bypass_out;             //set cause for trap
            mepc_bypasss_in   = mepc_bypasss_out;
            mtval_bypass_in   = mtval_bypass_out;
        end
    end

    wire zero;  
    always @(*) begin
        if(csr_wsc_mode == 2'b01)PC_next = mtvec_bypass_out[31:2]<<1;
        else if(mret == 1'b1) PC_next = mepc_bypasss_out[31:0];
        else if(((zero ^ BranchSel) && Branch) || Jump )PC_next = PC_BJ;
        else PC_next = PC_4;
    end

    assign Rd_data = (MemtoReg == 3'b000)?(Data_in_field):
                     (MemtoReg == 3'b001)?(ALU_out):
                     (MemtoReg == 3'b010)?(Imm_out):
                     (MemtoReg == 3'b011)?PC_RD:(csr_rdata);
                     
    assign ALU_B = (ALUSrc_B == 1'b0)?Rs2_data:Imm_out;
    assign Data_out = Rs2_data << Data_bias;
    assign Save_base = 1'b1 << (ALU_out[1:0]);

    ALU  ALU_U3 (
        .A(Rs1_data),
        .B(ALU_B),
        .ALU_operation(ALU_Control),
        .res(ALU_out),
        .zero(zero)
    );
endmodule
