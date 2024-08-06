module Register #(
    parameter WIDTH = 16
) (
    input logic               clk,
    input logic               rst_n,
    input logic               clear,
    input logic               enable,
    input logic [WIDTH-1:0]   in,
    output logic [WIDTH-1:0]  out
);

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out <= #1 {WIDTH{1'b0}};
    end else if (clear) begin
        out <= #1 {WIDTH{1'b0}};
    end else if(enable) begin
        out <= #1 in;
    end
end

endmodule
