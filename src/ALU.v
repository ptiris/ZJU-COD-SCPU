module ALU (
  input [31:0]  A,
  input [31:0]  B,
  input [3:0]   ALU_operation,
  output[31:0]  res,
  output        zero
);
// Your code

reg [31:0]res;
always @(*) begin
  case (ALU_operation)
    4'd0: res = A + B;
    4'd1: res = A - B;
    4'd2: res = A << B[4:0];
    4'd3: begin
      if($signed(A) < $signed(B))
        res = 1'b1;
      else res = 1'b0;
    end
    4'd4: begin
      if($unsigned(A) < $unsigned(B))
        res = 1'b1;
      else res = 1'b0;
    end
    4'd5: res = A ^ B;
    4'd6: res = A >> B[4:0];
    4'd7: res = $signed(A) >>> $signed(B[4:0]);
    4'd8: res = A | B;
    4'd9: res = A & B; 
    default: res = 32'hxxxxxxxx; 
  endcase
end

assign zero = (res === 32'h00000000);
endmodule
