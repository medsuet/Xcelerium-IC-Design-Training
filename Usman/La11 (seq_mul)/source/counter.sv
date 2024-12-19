module counter(input logic clk,reset,output logic [3:0]out);

logic clear;

always_ff@(posedge clk , negedge reset) begin

if(reset == 1'b0) out<=0;
else if(out == 4'hf) out<=0;
else out <= out+1;
end

endmodule



