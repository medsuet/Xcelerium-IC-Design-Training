module shift_A(input logic clk, input logic rst, input logic shift_en, en_A, input logic [15:0] in, 
output logic [15:0] shift_reg_out);
always_ff@(posedge clk, negedge rst) begin
    if (~rst) begin
        shift_reg_out <= 16'b0;
    end else if (en_A) begin
        if (shift_en) begin
            if (in[15]==1) begin
                shift_reg_out <= {1'b1,in[15:1]};
            end
            else begin
                shift_reg_out <= {1'b0,in[15:1]};
            end
        end
        else if (~shift_en) begin
            shift_reg_out <= in;
        end
    end
end
endmodule