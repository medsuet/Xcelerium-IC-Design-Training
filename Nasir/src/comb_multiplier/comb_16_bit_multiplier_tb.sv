module comb_16_bit_multiplier_tb;
// define parameters
    parameter width = 16, maxNumber = 32768;
    // define variables for inputs outputs for our main module
    logic signed [width -1:0] multiplicand1, multiplier1;
    logic signed [(2*width)-1:0] product1;
    logic signed [(2*width)-1:0] multiplication;
    // counter for counting all test cases
    logic [31:0] counter;
// module instantiation
    comb_16_bit_multiplier UUT (
        .multiplicand(multiplicand1),
        .multiplier(multiplier1),
        .product(product1)
    );

// random Test cases
// range - 2^15  --- + (2^15 - 1)
// 32768 - 32767
// random numbers generator and multiplication by 0, 1, -1
// Test procedure
initial begin

    for(int i = 0; i < 10000; i++)begin 
        // generate random multiplicand and multiplier
        multiplicand1 = $random % maxNumber;
        multiplier1 = $random % maxNumber;
        // calculate reference actual product
        multiplication = multiplicand1*multiplier1;
        // delay for collecting custom product
        // delay added because of propagation delay
        #1;
        // displaying all inputs, output and reference product 
        $display("multiplicand = %0d, multiplier = %d, product = %d, referenceProduct= %d ", multiplicand1, multiplier1, product1, multiplication);
        // if reference product is equal to our custom product - test passed
        if (multiplication == product1)begin
            // displaying which test number passed
            $display("Test %0d Passed", i);
        end
        // if reference product is not equal to our custom product - test failed
        else begin
            // displaying which test number failed
            $display("Test %0d Failed", i);
        end  
        counter = i; 
    end
// multiplication by 0, 1, -1
    for(int i = 0; i < 10000; i++)begin 
        // generate random multiplicand and multiplier
        multiplicand1 = $random % maxNumber;
        // multiplier = 0, 1, -1
        multiplier1 = $random % 2;
        // calculate reference actual product
        multiplication = multiplicand1*multiplier1;
        // delay for collecting custom product
        // delay added because of propagation delay
        #1;
        // displaying all inputs, output and reference product 
        $display("multiplicand = %0d, multiplier = %d, product = %d, referenceProduct= %d ", multiplicand1, multiplier1, product1, multiplication);
        // if reference product is equal to our custom product - test passed
        if (multiplication == product1)begin
            // displaying which test number passed
            $display("Test %0d Passed", i);
        end
        // if reference product is not equal to our custom product - test failed
        else begin
            // displaying which test number failed
            $display("Test %0d Failed", i);
        end  
    end
    // finish simulation
    $finish;

end

endmodule
