module bitsel(input logic [31:0] in, output logic out);
 
always@(*) begin 
  out = in[0];
end
endmodule