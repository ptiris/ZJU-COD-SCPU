module Data_inGen(
    input      [31:0]  Data_in,
    input      [2:0]   Mem_dataSel,
    input      [1:0]   Byte_bias,
    output reg [31:0]  Data_in_field
);
    always @(*) begin
        case (Mem_dataSel)
            3'b000:begin
                case (Byte_bias)
                    2'b00: Data_in_field = {{24{Data_in[7]}},{Data_in[7:0]}};
                    2'b01: Data_in_field = {{24{Data_in[15]}},{Data_in[15:8]}};
                    2'b10: Data_in_field = {{24{Data_in[23]}},{Data_in[23:16]}};
                    2'b11: Data_in_field = {{24{Data_in[31]}},{Data_in[31:24]}};
                    default: Data_in_field = {{24{Data_in[7]}},{Data_in[7:0]}};
                endcase
            end
            3'b001:begin
                case (Byte_bias)
                    2'b00: Data_in_field = {{16{Data_in[15]}},{Data_in[15:0]}};
                    2'b01: Data_in_field = {{16{Data_in[23]}},{Data_in[23:8]}};
                    2'b10: Data_in_field = {{16{Data_in[31]}},{Data_in[31:16]}};
                    default: Data_in_field = {{16{Data_in[15]}},{Data_in[15:0]}};
                endcase
            end
            3'b010:Data_in_field = Data_in;
            3'b100:begin
                case (Byte_bias)
                    2'b00: Data_in_field = {{24{1'b0}},{Data_in[7:0]}};
                    2'b01: Data_in_field = {{24{1'b0}},{Data_in[15:8]}};
                    2'b10: Data_in_field = {{24{1'b0}},{Data_in[23:16]}};
                    2'b11: Data_in_field = {{24{1'b0}},{Data_in[31:24]}};
                    default: Data_in_field = {{24{1'b0}},{Data_in[7:0]}};
                endcase
            end
            3'b101:begin
                case (Byte_bias)
                    2'b00: Data_in_field = {{16{1'b0}},{Data_in[15:0]}};
                    2'b01: Data_in_field = {{16{1'b0}},{Data_in[23:8]}};
                    2'b10: Data_in_field = {{16{1'b0}},{Data_in[31:16]}};
                    default: Data_in_field = {{16{Data_in[15]}},{Data_in[15:0]}};
                endcase
            end
            default: Data_in_field = Data_in;   
        endcase
    end
endmodule
