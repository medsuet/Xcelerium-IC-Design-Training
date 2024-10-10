module shift_q(input logic clk, input logic rst, input logic shift_en, en_q, input logic [16:0] in, input logic [15:0] A_in, 
output logic [16:0] shift_reg_out);
always_ff@(posedge clk, negedge rst) begin
    if (~rst) begin
        shift_reg_out <= 17'b0;
    end 
    else if (en_q) begin
        if (shift_en) begin
            shift_reg_out <= {A_in[0],in[16:1]};
        end
        else if (~shift_en) begin
            shift_reg_out <= in;
        end
    end
end
endmodule