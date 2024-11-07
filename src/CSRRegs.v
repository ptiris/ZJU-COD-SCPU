module CSRRegs(
    input clk, rst,
    input[11:0] raddr, waddr,       // 读、写 CSR 寄存器的地址
    input[31:0] wdata,              // 写入 CSR 寄存器的数据
    input csr_w,                    // 写使能
    input[1:0] csr_wsc_mode,        // 写入 CSR 寄存器的模式
    output[31:0] rdata,             // 读出 CSR 寄存器的数据
    input expt_int,
    input [31:0]mepc_bypasss_in,
    input [31:0]mscause_bypass_in,
    input [31:0]mtval_bypass_in,
    input [31:0]mtvec_bypass_in,
    input [31:0]mstatus_bypass_in,
    
    output [31:0]mepc_bypasss_out,
    output [31:0]mscause_bypass_out,
    output [31:0]mtval_bypass_out,
    output [31:0]mtvec_bypass_out,
    output [31:0]mstatus_bypass_out
);
    reg [31:0] res[4095:0];
    integer i;
    always @(posedge clk or posedge rst) begin
        if(rst)begin
            for (i = 0;i < 4096;i = i+1) 
                res[i]<=0;
        end
        else begin
            if(expt_int && (csr_wsc_mode == 2'b01))begin
                res[12'h341] <= mepc_bypasss_in;
                res[12'h342] <= mscause_bypass_in;
                res[12'h343] <= mtval_bypass_in;
                res[12'h305] <= mtvec_bypass_in;
                res[12'h300] <= mstatus_bypass_in;
            end
            else if(waddr && csr_w)
                res[waddr] <= wdata;
            else res[waddr] <= res[waddr];
        end


    end

    assign rdata = res[raddr];
    assign  mepc_bypasss_out   =  res[12'h341];
    assign  mscause_bypass_out =  res[12'h342];
    assign  mtval_bypass_out   =  res[12'h343];
    assign  mtvec_bypass_out   =  res[12'h305];
    assign  mstatus_bypass_out =  res[12'h300];
endmodule