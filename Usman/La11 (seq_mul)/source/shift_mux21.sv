module shift_mux21(input logic [31:0] in0,in1,input logic sel,clk,output logic [31:0] out );

always_ff@(posedge clk) begin
 case(sel)
   0: out <= in0>>1;
   1: out <= in1;
endcase
end
endmodule
