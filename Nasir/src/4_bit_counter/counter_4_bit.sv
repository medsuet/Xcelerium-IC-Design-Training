module top_module (
    input logic clk,      // Clock signal
    input logic reset,    // Active low reset
    output logic [3:0] q, // 4-bit register value
    output logic [3:0] y  // MUX output
);

    logic clear;
    logic [3:0] d;

    // Instantiate register
    register_4bit register_inst (
        .clk(clk),
        .reset(reset),
        .d(d),
        .q(q),
        .clear(clear)
    );

    // Calculate 1 + q
    assign d = q + 1;

    // Instantiate MUX
    mux_2to1 mux_inst (
        .sel(clear),
        .a(4'b0000),  // Input 0 (0 output when clear is high)
        .b(d),        // Input 1 (1 + q)
        .y(y)         // Output
    );

endmodule


module register_4bit (
    input logic clk,       // Clock signal
    input logic reset,     // Active low reset
    input logic [3:0] d,   // Data input
    output logic [3:0] q,  // 4-bit register value
    output logic clear     // Clear signal
);

    // Register logic
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            q <= 4'd0;     // Reset register to 0
            clear <= 1'b0; // Clear signal is 0
        end else if (q == 4'd13) begin
            q <= 4'd0;     // Reset register to 0 when it reaches 13
            clear <= 1'b1; // Set clear signal
        end else begin
            q <= d;        // Update register with new data
            clear <= 1'b0; // Clear signal is 0
        end
    end

endmodule

module mux_2to1 (
    input logic sel,      // Selection pin (clear signal)
    input logic [3:0] a,  // Input 0 (output when sel is high)
    input logic [3:0] b,  // Input 1 (output when sel is low)
    output logic [3:0] y  // Output
);

    // MUX logic
    always_comb begin
        if (sel)
            y = a;         // If sel (clear) is 1, output a
        else
            y = b;         // If sel (clear) is 0, output b
    end

endmodule

