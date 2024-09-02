module Register #(
    parameter WIDTH = 16  // Width of the register
) (
    input logic               clk,        // Clock signal
    input logic               rst_n,      // Active-low reset signal
    input logic               clear,      // Clear signal
    input logic               enable,     // Enable signal
    input logic [WIDTH-1:0]   in,         // Data input
    output logic [WIDTH-1:0]  out         // Data output
);

// Sequential logic for the register
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Asynchronous reset: clear the register on reset
        out <= #1 {WIDTH{1'b0}};
    end else if (clear) begin
        // Synchronous clear: set the register to zero
        out <= #1 {WIDTH{1'b0}};
    end else if (enable) begin
        // Load new data into the register when enabled
        out <= #1 in;
    end
end

endmodule
