module shift_A(input logic clk, input logic rst, input logic en, input logic [31:0] in, input logic [31:0] dd_in,
output logic [31:0] shift_reg_out);
always_ff@(posedge clk, negedge rst) begin
    if (~rst) begin
        shift_reg_out <= 32'b0;
    end else if (en) begin
        shift_reg_out <= {in[30:0],dd_in[31]};
    end
end
endmodule