
/*
    Name: booth_multipler.sv
    Date: 7-8-2024
    Author: Muhammad Tayyab
    Description: Multiplies using Booth's multipler algorithem

    Parameters: NUMBITS:    number of bits (width) of multiplier and multiplicand

    Inputs: clk             : clock signal
            reset           : reset signal (active low)
            num_a, num_b    : <NUMBITS> wide multiplier and multiplicand.
                              Must be stable for 1 clock cycle after start signal.
            valid_scr       : valid signal from source signaling availability of inputs (num_a, num_b)
            ready_dst       : ready signal from detination signaling that output (porduct) has been processed
    
    Outputs: ready           : set to 1 when result (product) is available
             product_low     : lower half <NUMBITS> of the result
             product_high    : upper half <NUMBITS> of the result
             valid_dst       : valid signal to destination signaling availability of output (product)
             ready_scr       : ready signal to source signaling that inputs (num_a, num_b) has been processed
    
    Supports valid/ready interface.
*/

module booth_multiplier #(parameter NUMBITS = 32)
(
    input logic clk, reset,
    input logic [(NUMBITS-1):0] num_a, num_b,
    output logic [(NUMBITS-1):0] product_high, product_low,

    input logic valid_src, ready_dst,
    output logic ready_src, valid_dst
);

    logic input_data, ac_add_sel, ac_en, qr_en, qn1_en, counter_clear, qn1, qn, finish;

    datapath #(NUMBITS) dp (clk, reset, num_a, num_b, product_high, product_low,
                            input_data, ac_add_sel, ac_en, qr_en, qn1_en, counter_clear, qn1, qn, finish);

    controller ctrl (clk, reset, valid_src, ready_dst, valid_dst, ready_src,
                     input_data, ac_add_sel, ac_en, qr_en, qn1_en, counter_clear, qn1, qn, finish);

endmodule
