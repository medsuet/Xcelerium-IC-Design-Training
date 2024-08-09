/*
    Name: datapath.sv
    Author: Muhammad Tayyab
    Date: 8-8-2024
    Description: Datapath for restoring_division.sv
*/

module datapath #(parameter NUMBITS = 32)
(
    input logic clk, reset,
    input logic [(NUMBITS-1):0] dividend, divisor,
    output logic [(NUMBITS-1):0] quotient, remainder,

    input logic input_data, a_en, q_en, counter_clear,
    output logic finish
);

    logic [(NUMBITS-1):0] a, a_shifted, a_sub_m, a_restore;
    logic [(NUMBITS-1):0] m;
    logic [(NUMBITS-1):0] q, q_shifted, q_new;
    logic [(NUMBITS-1):0] count;

    assign quotient = (divisor===0) ? 0 : q;
    assign remainder = (divisor===0) ? 0 : a;

    // m signals
    always_ff @(posedge clk, negedge reset)
    begin
        if (!reset)
            m <= 0;
        else if (input_data)
            m <= divisor;
    end

    // a signals
    always_ff @(posedge clk, negedge reset)
    begin
        if (!reset)
            a <= 0;
        else if (a_en)
            a <= (input_data) ? (0) : (a_restore);
    end
        
    assign a_shifted = {a[(NUMBITS-2):0], q[NUMBITS-1]};
    assign a_sub_m = a_shifted - m;
    assign a_restore = (a_sub_m[NUMBITS-1]) ? a_shifted : a_sub_m;

    // q signals
    always_ff @(posedge clk, negedge reset)
    begin
        if (!reset)
            q <= 0;
        else if (q_en)
            q <= (input_data) ? (dividend) : (q_new);
    end

    assign q_shifted = q << 1;
    assign q_new = (a_sub_m[NUMBITS-1]) ? {q_shifted[(NUMBITS-1):1],1'b0} : {q_shifted[(NUMBITS-1):1],1'b1};

    // Count number of bits
    counter #(NUMBITS) SC (clk, reset, ~finish, counter_clear, count);
    assign finish = (count === NUMBITS);

endmodule
