/*
    Name: SequentialSignedMultiplier.sv
    Author: Muhammad Tayyab
    Date: 30-7-2024
    Description: Multiplies two 16 bit signed numbers sequentially in max 32 clock cycles.
                 Sets ready signal when product is available.
    
    Paramater: NUMBITS  : width (number of bits) of multiplier and multiplicand.

    Inputs: clk         : clock signal
            reset       : reset signal (active low)
            start       : start computing product.
            numA, numB  : <NUMBITS> wide multiplier and multiplicand.
                          Must be stable for 1 clock cycle after start signal.
    
    Outputs: ready      : set to 1 when result (product) is available
             product    : <2*NUMBITS> wide result of numA * numB.

*/

module SequentialSignedMultiplier #(parameter NUMBITS)
(
    input logic clk, reset, start,
    input logic [(NUMBITS-1):0] numA, numB,
    output logic ready,
    output logic [((2*NUMBITS)-1):0] product
);

    logic numA_wr, numB_wr, numA_mux_sel, numB_mux_sel, product_wr, product_clear, numA_lsb, finish;

    datapath #(NUMBITS) dp(clk, reset, numA, numB, product, numA_wr, numB_wr, numA_mux_sel, numB_mux_sel,
                           product_wr, product_clear, numA_lsb, finish);

    controller #(NUMBITS) ctrl(clk, reset, start, ready, numA_wr, numB_wr, numA_mux_sel, numB_mux_sel, 
                               product_wr, product_clear, numA_lsb, finish);
    
endmodule
