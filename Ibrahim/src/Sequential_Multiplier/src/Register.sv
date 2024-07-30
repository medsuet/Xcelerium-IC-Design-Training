module Register(
    input logic         clk,
    input logic         rst_n,
    input logic         clear,
    input logic         enable,
    input logic [15:0]  in,
    output logic [15:0] out
);

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out <= 16'b0;
    end else if (clear) begin
        out <= 16'b0;
    end else if(enable) begin
        out <= in;
    end
end

endmodule
