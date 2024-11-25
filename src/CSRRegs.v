module CSRRegs(
    input clk, rst,
    input[11:0] raddr, waddr,       // 读、写 CSR 寄存器的地址
    input[31:0] wdata,              // 写入 CSR 寄存器的数据
    input csr_w,                    // 写使能
    input[1:0] csr_wsc_mode,        // 写入 CSR 寄存器的模式
    input expt_int,
    input [31:0]mepc_bypasss_in,
    input [31:0]mscause_bypass_in,
    input [31:0]mtval_bypass_in,
    input [31:0]mstatus_bypass_in,
    
    output reg [31:0]rdata,             // 读出 CSR 寄存器的数据
    output [31:0]mepc_bypasss_out,
    output [31:0]mscause_bypass_out,
    output [31:0]mtval_bypass_out,
    output [31:0]mtvec_bypass_out,
    output [31:0]mstatus_bypass_out
);
    // reg [31:0] res[4095:0];
    // integer i;
    // always @(posedge clk or posedge rst) begin
    //     if(rst)begin
    //         for (i = 0;i < 4096;i = i+1) 
    //             res[i]<=0;
    //     end
    //     else begin
    //         if(expt_int && (csr_wsc_mode == 2'b01))begin
    //             res[12'h341] <= mepc_bypasss_in;
    //             res[12'h342] <= mscause_bypass_in;
    //             res[12'h343] <= mtval_bypass_in;
    //             res[12'h300] <= mstatus_bypass_in;
    //         end
    //         else if(waddr && csr_w)
    //             res[waddr] <= wdata;
    //         else res[waddr] <= res[waddr];
    //     end
    // end

    // assign  rdata = res[raddr];
    // assign  mepc_bypasss_out   =  res[833];
    // assign  mscause_bypass_out =  res[834];
    // assign  mtval_bypass_out   =  res[835];
    // assign  mtvec_bypass_out   =  res[773];
    // assign  mstatus_bypass_out =  res[768];

    localparam mepc_addr    = 12'h341;
    localparam mscause_addr = 12'h342;
    localparam mtval_addr   = 12'h343;
    localparam mtvec_addr   = 12'd773;
    localparam mstatus_addr = 12'h300;

    reg [31:0] res[4:0];
    integer i;
    always @(posedge clk or posedge rst) begin
        if(rst)begin
            for(i=0;i<5;i=i+1)
                res[i] <= 0;
        end
        else begin
            if(expt_int && (csr_wsc_mode == 2'b01))begin
                res[0] <= mepc_bypasss_in;
                res[1] <= mscause_bypass_in;
                res[2] <= mtval_bypass_in;
                res[3] <= mstatus_bypass_in;
            end
            else if(waddr && csr_w)
            begin
                case (waddr)
                    mepc_addr:     res[0] <= wdata;
                    mscause_addr:  res[1] <= wdata;
                    mtval_addr:    res[2] <= wdata;
                    mstatus_addr:  res[3] <= wdata;
                    mtvec_addr:    res[4] <= wdata;
                endcase
            end
            case (raddr)
                mepc_addr:     rdata <= res[0];
                mscause_addr:  rdata <= res[1];
                mtval_addr:    rdata <= res[2];
                mstatus_addr:  rdata <= res[3];
                mtvec_addr:    rdata <= res[4]; 
                default:       rdata <= 0;
            endcase
        end
    end

    assign  mepc_bypasss_out   =  res[0];
    assign  mscause_bypass_out =  res[1];
    assign  mtval_bypass_out   =  res[2];
    assign  mstatus_bypass_out =  res[3];
    assign  mtvec_bypass_out   =  res[4];
        
endmodule