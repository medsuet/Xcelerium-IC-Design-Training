module tb_combinational_multiplier;

// Testbench signals
logic signed [15:0] A, B;
logic signed [31:0] P;
logic signed [31:0] exp;

// Instantiate the Signed_Multiplier module
Signed_Multiplier UUT (
    .A(A),
    .B(B),
    .P(P)
);

// Test procedure
initial begin
  for(int i=0;i<10000;i++)begin 
   A = $random % 65536 - 32768;;
   B = $random % 65536 - 32768;;
   original = A*B;
   #1;
   if (original != P)begin
    $display("TEST FAILED");end
   else begin
    $display("TEST PASSED");end
  
    $display("A = %0d, B = %0d, P = %0d", A, B, P);
  end

    $finish;
end

endmodule