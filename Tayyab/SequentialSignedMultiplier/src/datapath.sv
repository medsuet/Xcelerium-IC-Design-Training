/*
    Name: datapath.sv
    Author: Muhammad Tayyab
    Date: 30-7-2024
    Description: Datapath for SequentialSignedMultiplier.sv
*/

module datapath #(parameter NUMBITS)
(
    input logic clk, reset,
    input logic [(NUMBITS-1):0] num_a, num_b,
    output logic [((2*NUMBITS)-1):0] product,
    
    input logic num_a_wr, num_b_wr, num_a_mux_sel, num_b_mux_sel, product_wr, product_clear,
    output logic num_a_lsb, finish
);

    logic [((2*NUMBITS)-1):0] num_a_reg, num_b_reg, num_b_sign_extended, num_a_sign_extended;

    // Sign extend num_a, num_b
    assign num_a_sign_extended = { {NUMBITS {num_a[NUMBITS-1]}}, num_a };
    assign num_b_sign_extended = { {NUMBITS {num_b[NUMBITS-1]}}, num_b };

    // Store and shift right num_a
    always_ff @(posedge clk, negedge reset) 
    begin
        if (!reset)
            num_a_reg <= 0;
        else if (num_a_wr)
            num_a_reg <= (num_a_mux_sel) ? (num_a_sign_extended) : (num_a_reg >> 1);
    end

    // Store and shift left num_b
    always_ff @(posedge clk, negedge reset) 
    begin
        if (!reset)
            num_b_reg <= 0;
        else if (num_b_wr)
            num_b_reg <= (num_b_mux_sel) ? (num_b_sign_extended) : (num_b_reg << 1);
    end
    
    // Store product
    always_ff @(posedge clk, negedge reset) 
    begin
        if (!reset)
            product <= 0;
        else if (product_wr)
            product <= (product_clear) ? (0) : (product + num_b_reg);
    end

    assign finish = ( num_a_reg === 0 );
    assign num_a_lsb = num_a_reg[0];
    
endmodule
