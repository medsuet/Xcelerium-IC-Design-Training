module mux21_16bit(input logic [15:0]in0,input logic [15:0]in1,input logic sel,
                   output logic [15:0]out );

always_comb begin
 case(sel)
   0: out = in0;
   1: out = in1;
   default: out = 0;
endcase
end
endmodule
