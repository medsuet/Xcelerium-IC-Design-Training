module tb_comb_16bit_mul;

 // define inputs and output
    logic signed [15:0] multiplicand, multiplier;
    logic signed [31:0] product;
    logic signed [31:0] expected;

   
// instantiation
    comb_16bit_mul UUT (
        .input1(multiplicand),
        .input2(multiplier),
        .product(product)
    );

    // Test procedure
initial 
begin
  for(int i=0;i<100;i++)begin 
   multiplicand = $random;
   multiplier = $random;
   expected = multiplicand * multiplier;
   #1;
   if (expected != product)
   begin
    $display("A = %0d, B = %0d, product = %0d  Fail",multiplicand, multiplier, product);
    end
   else 
   begin
    $display("A = %0d, B = %0d, product = %0d  Pass",multiplicand, multiplier, product);
    end
  
    //$display("A = %0d, B = %0d, P = %0d", A, B, P);
  end

    $finish;
end

endmodule
