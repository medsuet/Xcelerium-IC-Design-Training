module tb;

    int test_cases=100;                   //no. of test cases
    logic signed [15:0] multiplier;       
    logic signed [15:0] multiplicand;
    logic signed [31:0] product;
    logic signed [31:0] expected_product;

    //instantiate the multiplier
    signed_multiplier uut (
        .multiplicand(multiplicand), 
        .multiplier(multiplier), 
        .product(product)
    );
    
    //using random numbers to test multiplier
    initial begin
        for (int i=0;i<test_cases+1;i++) begin
            multiplier = $random % 65536;   //ensure that number is in 16 bits
            multiplicand = $random % 65536; //ensure that number is in 16 bits
            expected_product = multiplicand * multiplier;
            #1;
            //if (product !== expected_product) begin
            //    $display("test %0d: mismatch",i);
            //end else begin
            //    $display("test %0d: match",i);
            //end
        end
        $finish;
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,tb);
    end
endmodule
