module counter (
    input logic clk,            // Clock signal
    input logic reset,          // Active-high reset signal
    output logic [3:0] count    // 4-bit counter output
);

    logic [3:0] reg_val;        // 4-bit register value
    logic [3:0] adder_out;      // Output of the adder
    logic [3:0] mux_out;        // Output of the multiplexer
    logic cmp_out;              // Output of the comparator

    // Adder logic
    always_comb begin
        adder_out = reg_val + 1;
    end

    // Comparator logic (max value for 4-bit is 15)
    always_comb begin
        cmp_out = (reg_val == 4'b1111);
    end

    // MUX logic
    always_comb begin
        if (cmp_out)
            mux_out = 4'b0000;
        else
            mux_out = adder_out;
    end

    // Asynchronous logic for the counter
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_val <= 4'b0000;  // Reset the register value to 0
        end else begin
            reg_val <= mux_out;  // Update register value with MUX output
        end
    end

    // Output assignment
    always_comb begin
        count = reg_val;
    end

endmodule
