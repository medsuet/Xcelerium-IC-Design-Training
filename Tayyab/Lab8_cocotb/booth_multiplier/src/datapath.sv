/*
    Name: datapath.sv
    Author: Muhammad Tayyab
    Date: 6-8-2024
    Description: Datapath for booth_multiplier.sv
*/

module datapath #(parameter NUMBITS = 32)
(
    input logic clk, reset,
    input logic [(NUMBITS-1):0] num_a, num_b,
    output logic [(NUMBITS-1):0] product_high, product_low,

    input logic input_data, ac_add_sel, ac_en, qr_en, qn1_en, counter_clear,
    output logic qn1, qn, finish
);

    logic [(NUMBITS-1):0] ac, ac_add_br, ac_shifted;
    logic [(NUMBITS-1):0] br;
    logic [(NUMBITS-1):0] qr, qr_shifted;
    logic [(NUMBITS-1):0] count;

    assign product_high = ac;
    assign product_low = qr;
    assign br = num_a;

    // ac signals
    always @(posedge clk, negedge reset)
    begin
        if (!reset)
            ac <= 0;
        else if (ac_en)
            ac <= (input_data) ? (0) : (ac_shifted);
    end

    always_comb begin
        if (qn==0 && qn1==1)
            ac_add_br = ac + br;
        else if (qn==1 && qn1==0)
            ac_add_br = ac - br;
        else
            ac_add_br = ac;
    end

    assign ac_shifted = {ac_add_br[NUMBITS-1], ac_add_br[(NUMBITS-1):1]};

    // qr signals
    always @(posedge clk, negedge reset)
    begin
        if (!reset)
            qr <= 0;
        else if (qr_en)
            qr <= (input_data) ? (num_b) : (qr_shifted);
    end

    assign qr_shifted = {ac_add_br[0], qr[(NUMBITS-1):1]};

    // qn and qn-1
    always @(posedge clk, negedge reset)
    begin
        if (!reset)
            qn1 <= 0;
        else if (qn1_en)
            qn1 <= (input_data) ? 0 : qr[0];
    end
    assign qn = qr[0];

    // Count number of bits
    counter #(NUMBITS) SC (clk, reset, ~finish, counter_clear, count);
    assign finish = (count === NUMBITS);

endmodule
