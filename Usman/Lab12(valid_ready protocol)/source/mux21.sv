module mux21(input logic [31:0] in0,in1,input logic sel,output logic [31:0] out );

always_comb begin
 case(sel)
   0: out = in0;
   1: out = in1;
   default: out = 0;
endcase
end
endmodule
