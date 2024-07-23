module Signed_Multiplier_TB;

// Testbench signals
reg signed [15:0] A, B;
wire signed [31:0] P;

// Instantiate the Signed_Multiplier module
Signed_Multiplier UUT (
    .A(A),
    .B(B),
    .P(P)
);

// Test procedure
initial begin
    // Test case 1: 3 * 5
    A = 16'sb0000_0000_0000_0011; // 3
    B = 16'sb0000_0000_0000_0101; // 5
    #10;
    $display("A = %0d, B = %0d, P = %0d", A, B, P);
    
    // Test case 2: -2 * 2
    A = 16'sb1111_1111_1111_1110; // -2
    B = 16'sb0000_0000_0000_0010; // 2
    #10;
    $display("A = %0d, B = %0d, P = %0d", A, B, P);
    
    // Test case 3: -1 * 1
    A = 16'sb1111_1111_1111_1111; // -1
    B = 16'sb0000_0000_0000_0001; // 1
    #10;
    $display("A = %0d, B = %0d, P = %0d", A, B, P);
    
    // Test case 4: -32768 * 1
    A = 16'sb1000_0000_0000_0000; // -32768
    B = 16'sb0000_0000_0000_0001; // 1
    #10;
    $display("A = %0d, B = %0d, P = %0d", A, B, P);

    // Test case 5: 32767 * 1
    A = 16'sb0111_1111_1111_1111; // 32767
    B = 16'sb0000_0000_0000_0001; // 1
    #10;
    $display("A = %0d, B = %0d, P = %0d", A, B, P);

    // Test case 6: -12345 * -6789
    A = 16'sb1100_1100_1100_0111; // -12345
    B = 16'sb1110_1000_1001_0011; // -6789
    #10;
    $display("A = %0d, B = %0d, P = %0d", A, B, P);

    $stop;
end

endmodule
