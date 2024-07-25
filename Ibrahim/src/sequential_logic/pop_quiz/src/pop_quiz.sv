module d_flip_flop (
    input logic  clk,
    input logic  reset,
    input logic  d,
    output logic q
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            q <= #1 0;
        else
            q <= #1 d;
    end
endmodule

module pop_quiz (
    input logic  clk,
    input logic  reset,
    input logic  d_in,  // Input to the first flip-flop
    output logic a     // Output from the third flip-flop
);
    logic x, y, b;

    // Instantiate the first D flip-flop
    d_flip_flop ff1 (
        .clk(clk),
        .reset(reset),
        .d(d_in),
        .q(x)
    );

    // Compute Y as the NOT of X
    assign y = ~x;

    // Instantiate the second D flip-flop
    d_flip_flop ff2 (
        .clk(clk),
        .reset(reset),
        .d(y),
        .q(b)
    );

    // Instantiate the third D flip-flop
    d_flip_flop ff3 (
        .clk(clk),
        .reset(reset),
        .d(b),
        .q(a)
    );
endmodule
