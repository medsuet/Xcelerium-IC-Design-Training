/*
    Name: datapath.sv
    Author: Muhammad Tayyab
    Date: 30-7-2024
    Description: Datapath for SequentialSignedMultiplier.sv
*/

module datapath #(parameter NUMBITS)
(
    input logic clk, reset,
    input logic [(NUMBITS-1):0] numA, numB,
    output logic [((2*NUMBITS)-1):0] product,
    
    input logic numA_wr, numB_wr, numA_mux_sel, numB_mux_sel, product_wr, product_clear,
    output logic numA_lsb, finish
);

    logic [((2*NUMBITS)-1):0] numA_reg, numB_reg, numB_sign_extended, numA_sign_extended;
    logic [(NUMBITS-1):0] bits_count;

    // Sign extend numA, numB
    assign numA_sign_extended = (numA[NUMBITS-1]) ? {16'hffff, numA} : {16'b0, numA};
    assign numB_sign_extended = (numB[NUMBITS-1]) ? {16'hffff, numB} : {16'b0, numB};

    // Store and shift right numA
    always_ff @(posedge clk, negedge reset) 
    begin
        if (!reset)
            numA_reg <= 0;
        else if (numA_wr)
            numA_reg <= (numA_mux_sel) ? (numA_sign_extended) : (numA_reg >> 1);
    end

    // Store aand shift left numB
    always_ff @(posedge clk, negedge reset) 
    begin
        if (!reset)
            numB_reg <= 0;
        else if (numB_wr)
            numB_reg <= (numB_mux_sel) ? (numB_sign_extended) : (numB_reg << 1);
    end
    
    // Store product
    always_ff @(posedge clk, negedge reset) 
    begin
        if (!reset)
            product <= 0;
        else if (product_wr)
            product <= (product_clear) ? (0) : (product + numB_reg);
    end

    assign finish = ( numA_reg === 16'b0 );
    assign numA_lsb = numA_reg[0];
    
endmodule
