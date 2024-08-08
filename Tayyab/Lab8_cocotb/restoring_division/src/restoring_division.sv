
/*
    Name: restoring_division.sv
    Date: 8-8-2024
    Author: Muhammad Tayyab
    Description: Divides using restoring division algorithem

    Parameters: NUMBITS     : number of bits (width) of dividend and divisor

    Inputs: clk             : clock signal
            reset           : reset signal (active low)
            dividend        : <NUMBITS> wide dividend
            dividend        : <NUMBITS> wide divisor
            valid_scr       : valid signal from source signaling availability of inputs (dividend, divisor)
            ready_dst       : ready signal from destination signaling that outputs (quotient, remainder) are available
    
    Outputs: quotient       : <NUMBITS> wide quotient of dividend/divisor
             remainder      : <NUMBITS> wide remainder of dividend/divisor
             valid_dst      : valid signal to destination signaling availability of output (quotient, remainder)
             ready_scr      : ready signal to source signaling that inputs (dividend, divisor) has been processed
    
    Supports valid/ready interface.
*/

module restoring_division #(parameter NUMBITS = 4)
(
    input logic clk, reset,
    input logic [(NUMBITS-1):0] dividend, divisor,
    output logic [(NUMBITS-1):0] quotient, remainder,

    input logic valid_src, ready_dst,
    output logic ready_src, valid_dst
);

    logic input_data, a_en, q_en, counter_clear, finish;

    datapath #(NUMBITS) dp (clk, reset, dividend, divisor, quotient, remainder,
                            input_data, a_en, q_en, counter_clear, finish);

    controller ctrl (clk, reset, valid_src, ready_dst, valid_dst, ready_src,
                     input_data, a_en, q_en, counter_clear, finish);

endmodule
