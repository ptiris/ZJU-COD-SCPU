`include "micro.vh"
module SCPU (
    input clk,
    input rst,
    input MIO_ready,
    input [31:0]Data_in,
    input [31:0]inst_in,
    input IO_break,

    output [3:0]MemRW,
    output CPU_MIO,
    output [31:0]Addr_out,
    output [31:0]PC_out,
    output [31:0]Data_out
);
    

    wire MIO_ready,ALUSrc_B,Jump,Branch,RegWrite,JumpSel,BranchSel,PC_RDSel;
    wire ecall,ill_inst,expt_int,csr_w,csr_opctrl,csr_immsel;
    wire[3:0]    MemRw,Save_base;
    wire[2:0]    ImmSel;
    wire[1:0]    MemtoReg;
    wire[3:0]    ALU_Control;
    wire[2:0]    Mem_dataSel;
    SCPU_ctrl  SCPU_ctrl_U0 (
        .inst_in_ctrl(inst_in),
        .MIO_ready(MIO_ready),
        .ImmSel(ImmSel),
        .ALUSrc_B(ALUSrc_B),
        .MemtoReg(MemtoReg),
        .Jump(Jump),
        .Branch(Branch),
        .RegWrite(RegWrite),
        .MemRW(MemRW),
        .ALU_Control(ALU_Control),
        .JumpSel(JumpSel),
        .BranchSel(BranchSel),
        .CPU_MIO(CPU_MIO),
        .Mem_dataSel(Mem_dataSel),
        .PC_RDSel(PC_RDSel),
        .Save_base(Save_base),
        .IO_break(IO_break),
        .ill_inst(ill_inst),
        .expt_int(expt_int),
        .ecall(ecall),
        .Csr_w(csr_w),
        .Csr_opctrl(csr_opctrl),
        .Csr_immsel(csr_immsel)
    );

    DataPath DataPath_U1(
        .clk(clk),
        .rst(rst),
        .MIO_ready(MIO_ready),
        .inst_in(inst_in),
        .ImmSel(ImmSel),
        .ALUSrc_B(ALUSrc_B),
        .MemtoReg(MemtoReg),
        .Jump(Jump),
        .Branch(Branch),
        .RegWrite(RegWrite),
        .MemRW(MemRW),
        .ALU_Control(ALU_Control),
        .CPU_MIO(CPU_MIO),
        .Data_in(Data_in),
        .JumpSel(JumpSel),
        .BranchSel(BranchSel),
        .ALU_out(Addr_out),
        .Data_out(Data_out),
        .PC_out(PC_out),
        .Mem_dataSel(Mem_dataSel),
        .PC_RDSel(PC_RDSel),
        .Save_base(Save_base),
        .csr_w(csr_w),
        .IO_break(IO_break),
        .csr_opctrl(csr_opctrl),
        .csr_immsel(csr_immsel)
    );

endmodule