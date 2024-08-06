/*
    Name: SignedMultiplier.sv
    Author: Muhammad Tayyab
    Date: 23-7-2024
    Description: Signed multiplier for two binary numbers <NUMBITS> wide.
                 Gives product in two <NUMBITS> wide numbers containing its upper and lower <NUMBITS> bits respectively.

    Inputs: Multiplicand and multiplier: NumA and NumB
    Outputs: Upper and lower bits of product: ProductUpper, ProductLower
    
    Parameter: (int) NUMBITS: number of bits (width) of the multiplicand and multiplier
    Dependencies: FullAdder.sv
*/

module SignedMultiplier #(parameter NUMBITS)
(
    input logic [NUMBITS-1:0] NumA, NumB,
    output logic [NUMBITS-1:0] ProductUpper, ProductLower
);

    logic [NUMBITS-1:0] Carry [0:NUMBITS-1];
    logic [NUMBITS-1:0] Sums [0:NUMBITS-1];
 
    genvar i, j;

    // First level
    generate
        for (j=0; j<=(NUMBITS-2); j++)
        begin
            assign Sums[0][j] = (NumA[j] & NumB[0]);
        end
    endgenerate
    assign Sums[0][NUMBITS-1] = ~(NumA[NUMBITS-1] & NumB[0]);

    // In-between levels
    assign Carry[0][NUMBITS-1] = 1;
    generate
        for (i=1; i<=(NUMBITS-2); i++)
        begin
            Bit_AndAdd_Unit baau0(.Ai(NumA[0]), .Bi(NumB[i]), .PrevLevelSum(Sums[i-1][1]), .Cin(1'b0), .Sum(Sums[i][0]), .Cout(Carry[i][0]));
            for (j=1; j<=(NUMBITS-2); j++)
            begin
                Bit_AndAdd_Unit baau(.Ai(NumA[j]), .Bi(NumB[i]), .PrevLevelSum(Sums[i-1][j+1]), .Cin(Carry[i][j-1]), .Sum(Sums[i][j]), .Cout(Carry[i][j]));
            end
            Bit_NandAdd_Unit bnau(.Ai(NumA[NUMBITS-1]), .Bi(NumB[i]), .PrevLevelSum(Carry[i-1][NUMBITS-1]), .Cin(Carry[i][NUMBITS-2]), .Sum(Sums[i][NUMBITS-1]), .Cout(Carry[i][NUMBITS-1]));
        end
    endgenerate

    // Last level
    Bit_NandAdd_Unit bnauLast(.Ai(NumA[0]), .Bi(NumB[NUMBITS-1]), .PrevLevelSum(Sums[NUMBITS-2][1]), .Cin(1'b0), .Sum(Sums[NUMBITS-1][0]), .Cout(Carry[NUMBITS-1][0]));
    generate
        for (j=1; j<=(NUMBITS-2); j++)
        begin
            Bit_NandAdd_Unit bnau(.Ai(NumA[j]), .Bi(NumB[NUMBITS-1]), .PrevLevelSum(Sums[NUMBITS-2][j+1]), .Cin(Carry[NUMBITS-1][j-1]), .Sum(Sums[NUMBITS-1][j]), .Cout(Carry[NUMBITS-1][j]));
        end
    endgenerate
    Bit_AndAdd_Unit baauLast(.Ai(NumA[NUMBITS-1]), .Bi(NumB[NUMBITS-1]), .PrevLevelSum(Carry[NUMBITS-2][NUMBITS-1]), .Cin(Carry[NUMBITS-1][NUMBITS-2]), .Sum(Sums[NUMBITS-1][NUMBITS-1]), .Cout(Carry[NUMBITS-1][NUMBITS-1]));
    assign ProductUpper[NUMBITS-1] = Carry[NUMBITS-1][NUMBITS-1] + 1;

    // Map output bits
    generate
        for (i=0; i<=(NUMBITS-1); i++)
            assign ProductLower[i] = Sums[i][0];
        for (i=0; i<=(NUMBITS-2); i++)
            assign ProductUpper[i] = Sums[NUMBITS-1][i+1];
    endgenerate

endmodule

module Bit_AndAdd_Unit (
    input logic Ai, Bi, PrevLevelSum, Cin,
    output logic Sum, Cout
);
/*
    Cout, Sum <- FULLADDER (Ai & Bi, PrevLevelSum, Cin)
*/
    logic Ai_AND_Bi;
    assign Ai_AND_Bi = Ai & Bi;

    FullAdder fa(.bit1(Ai_AND_Bi), .bit2(PrevLevelSum), .Cin(Cin), .sum(Sum), .Cout(Cout));

endmodule

module Bit_NandAdd_Unit (
    input logic Ai, Bi, PrevLevelSum, Cin,
    output logic Sum, Cout
);
/*
    Cout, Sum <- FULLADDER (~(Ai & Bi), PrevLevelSum, Cin)
*/
    logic Ai_NAND_Bi;
    assign Ai_NAND_Bi = ~(Ai & Bi);

    FullAdder fa(.bit1(Ai_NAND_Bi), .bit2(PrevLevelSum), .Cin(Cin), .sum(Sum), .Cout(Cout));

endmodule
