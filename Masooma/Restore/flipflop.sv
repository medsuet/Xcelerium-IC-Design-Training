module flipflop(input logic clk, input logic rst, input logic [31:0] d, input logic en, output logic [31:0] q);
always_ff@(posedge clk,negedge rst) begin
        if (~rst) begin
            q <= 0;
        end else if (en) begin
            q <= d;
        end
    end
endmodule