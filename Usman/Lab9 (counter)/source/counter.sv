module counter(input logic clk,reset,output logic [3:0]out);

logic clear;

always_comb begin
if(out==4'd13) clear<=1;
else clear<=0;
end

always_ff@(posedge clk , posedge reset) begin

if(reset == 1'b1) out<=0;
else if(clear == 1) out<=0;
else out <= out+1;
end

endmodule



