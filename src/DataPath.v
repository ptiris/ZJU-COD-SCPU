module DataPath(
    input            clk,
    input            rst,
    input            MIO_ready,
    input [2:0]      ImmSel,
    input            ALUSrc_B,
    input [1:0]      MemtoReg,
    input            Jump,
    input            JumpSel,
    input            Branch,
    input            BranchSel,
    input            RegWrite,
    input            MemRW,
    input [3:0]      ALU_Control,
    input            CPU_MIO,
    input [31:0]     Data_in,
    input [31:0]     PC,

    output [31:0]    ALU_out,
    output [31:0]    Data_out,
    output reg [31:0]    PC_out
);

    wire [31:0]Imm_out;
    ImmGen  ImmGen_inst (
        .ImmSel(ImmSel),
        .inst_field(inst_in),
        .Imm_out(Imm_out)
    );

    wire [31:0]Rd_data,ALU_B,ALU_out;
    wire [31:0]PC_4,PC_BJ;//Branch or Jump Results for PC.
    wire [31:0]Rs1_data,Rs2_data;

    Regs REG_U2(
        .clk(clk),
        .rst(rst),
        .Rs1_addr(inst_in[19:15]), 
        .Rs2_addr(inst_in[24:20]), 
        .Wt_addr(inst_in[11:7]),
        .Rs1_data(Rs1_data), 
        .Rs2_data(Rs2_data),
        .Wt_data(Rd_data), 
        .RegWrite(RegWrite)
    );
    /*  
        PC_BJ = P1 + P2 
        P1 = R1_data or PC
        P2 = imm
    */
    assign PC_4 = PC + 4;
    assign PC_BJ = (JumpSel == 1'b1)?Rs1_data:PC + Imm_out;
    assign PC_out = (((zero ^ BranchSel) && Branch) || Jump )?PC_BJ:PC_4;

    assign Rd_data = (MemtoReg == 2'b00)?(Data_in):
                     (MemtoReg == 2'b01)?(ALU_out):
                     (MemtoReg == 2'b10)?(Imm_out):PC_4;
    assign ALU_B = (ALUSrc_B == 1'b0)?Rs2_data:Imm_out;
    assign Data_out = Rs2_data;

    wire zero;  
    ALU  ALU_U3 (
        .A(Rs1_data),
        .B(ALU_B),
        .ALU_operation(ALU_Control),
        .res(ALU_out),
        .zero(zero)
    );
endmodule
