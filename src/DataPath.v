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
    input [3:0]      MemRW,
    input [3:0]      ALU_Control,
    input            CPU_MIO,
    input [31:0]     Data_in,
    input [31:0]     inst_in,
    input [2:0]      Mem_dataSel,
    input            PC_RDSel,

    output [31:0]    ALU_out,
    output [31:0]    Data_out,
    output [3:0]     Save_base,
    output reg [31:0]    PC_out
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

    wire [31:0]Rd_data,ALU_B,ALU_out;
    wire [31:0]PC_4,PC_BJ,PC_RD;//Branch or Jump Results for PC.
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
    wire [31:0]Data_in_field;
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


    wire zero;  
    always @(*) begin
        if(((zero ^ BranchSel) && Branch) || Jump )PC_next = PC_BJ;
        else PC_next = PC_4;
    end

    assign Rd_data = (MemtoReg == 2'b00)?(Data_in_field):
                     (MemtoReg == 2'b01)?(ALU_out):
                     (MemtoReg == 2'b10)?(Imm_out):PC_RD;
                     
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
