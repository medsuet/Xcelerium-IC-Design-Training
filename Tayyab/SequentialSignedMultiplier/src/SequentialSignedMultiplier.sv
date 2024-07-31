/*
    Name: SequentialSignedMultiplier.sv
    Author: Muhammad Tayyab
    Date: 30-7-2024
    Description: Multiplies two 16 bit signed numbers sequentially in max 32 clock cycles.
                 Sets ready signal when product is available.
    
    Paramater: NUMBITS  : width (number of bits) of multiplier and multiplicand.

    Inputs: clk             : clock signal
            reset           : reset signal (active low)
            num_a, num_b    : <NUMBITS> wide multiplier and multiplicand.
                              Must be stable for 1 clock cycle after start signal.
            valid_scr       : valid signal from source signaling availability of inputs (num_a, num_b)
            ready_dst       : ready signal from detination signaling that output (porduct) has been processed
    
    Outputs: ready           : set to 1 when result (product) is available
             product         : <2*NUMBITS> wide result of num_a * num_b
             valid_dst       : valid signal to destination signaling availability of output (product)
             ready_scr       : ready signal to source signaling that inputs (num_a, num_b) has been processed
    
    Supports valid/ready interface.
*/

module SequentialSignedMultiplier #(parameter NUMBITS)
(
    input logic clk, reset,
    input logic [(NUMBITS-1):0] num_a, num_b,
    output logic [((2*NUMBITS)-1):0] product,

    input logic valid_src, ready_dst,
    output logic valid_dst, ready_src
);

    logic num_a_wr, num_b_wr, num_a_mux_sel, num_b_mux_sel, product_wr, product_clear, num_a_lsb, finish;

    datapath #(NUMBITS) dp(clk, reset, num_a, num_b, product, num_a_wr, num_b_wr, num_a_mux_sel, num_b_mux_sel,
                           product_wr, product_clear, num_a_lsb, finish);

    controller #(NUMBITS) ctrl(clk, reset, valid_src, ready_dst, valid_dst, ready_src, num_a_wr, num_b_wr, num_a_mux_sel, num_b_mux_sel, 
                               product_wr, product_clear, num_a_lsb, finish);
    
endmodule
