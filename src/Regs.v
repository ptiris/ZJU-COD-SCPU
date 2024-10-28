module Regs(
    input clk,
    input rst,
    input [4:0] Rs1_addr, 
    input [4:0] Rs2_addr, 
    input [4:0] Wt_addr, 
    input [31:0]Wt_data, 
    input RegWrite, 
    output [31:0] Rs1_data, 
    output [31:0] Rs2_data,
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
    output [31:0] Reg31
);
// Your code here
    reg [31:0] res[31:0];
    integer i;
    always @(posedge clk or posedge rst) begin
        if(rst)begin
            for (i = 0;i < 32;i = i+1) 
                res[i]<=0;
        end
        else begin
            if(Wt_addr && RegWrite)
                res[Wt_addr]<=Wt_data;
            else res[Wt_addr]<=res[Wt_addr];
        end
    end

    assign Rs1_data = res[Rs1_addr];
    assign Rs2_data = res[Rs2_addr];
    assign Reg00 = res[00];
    assign Reg01 = res[01];
    assign Reg02 = res[02];
    assign Reg03 = res[03];
    assign Reg04 = res[04];
    assign Reg05 = res[05];
    assign Reg06 = res[06];
    assign Reg07 = res[07];
    assign Reg08 = res[08];
    assign Reg09 = res[09];

    assign Reg10 = res[10];
    assign Reg11 = res[11];
    assign Reg12 = res[12];
    assign Reg13 = res[13];
    assign Reg14 = res[14];
    assign Reg15 = res[15];
    assign Reg16 = res[16];
    assign Reg17 = res[17];
    assign Reg18 = res[18];
    assign Reg19 = res[19];

    assign Reg20 = res[20];
    assign Reg21 = res[21];
    assign Reg22 = res[22];
    assign Reg23 = res[23];
    assign Reg24 = res[24];
    assign Reg25 = res[25];
    assign Reg26 = res[26];
    assign Reg27 = res[27];
    assign Reg28 = res[28];
    assign Reg29 = res[29];

    assign Reg30 = res[30];
    assign Reg31 = res[31];
endmodule
