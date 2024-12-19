module MSB(input logic clk,input logic [31:0]A,Q, output logic [31:0]QM);

always_ff@(posedge clk)
begin
QM = Q;
case(A[31])
   0:QM[0] = 1;
   1:QM[0] = 0;
endcase


end

endmodule
