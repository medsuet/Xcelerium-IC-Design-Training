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
