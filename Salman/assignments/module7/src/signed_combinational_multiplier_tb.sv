// Top testbench module
module signed_combinational_multiplier_tb;

    // Variable/Signals Declaration
    logic signed [15:0] multiplier;
    logic signed [15:0] multiplicand;
    logic signed [31:0] product;

    // Seed - Change it for different generation of signed numbers
//    int unsigned seed = 1;
    int MAX = 32768;        // Max range for signed 16 bit
    int num_tests = 1000000;
    int i = 0;
    int fail_count = 0;
    int pass_count = 0;

    // Call Module
    signed_combinational_multiplier DUT(
        .A(multiplier),
        .B(multiplicand),
        .P(product)
    );

    initial
        begin
            for (i=1; i<=num_tests; i++)
            begin
                // Generate random signed 16-bit number
                multiplier = $urandom_range(0,MAX);
                multiplicand = $urandom_range(0,MAX);
                if ($urandom_range(0,10) % 2) 
                    begin
                    multiplier = -multiplier;                   // Randomly negate to get a signed number
                    end
                if ($urandom_range(0,10) % 2) 
                    begin
                    multiplicand = -multiplicand;               // Randomly negate to get a signed number
                    end
                #1;
                // Testing the output
                if ((multiplier*multiplicand) == product)
                    begin
                        $display("Test #%d Passed!",i);
                        pass_count += 1;
                    end
                else 
                    begin
                        $display("Error for input multiplier=%d; multiplicand=%d; product=%d",multiplier,multiplicand,product);
                        fail_count += 1;
                    end
                #1;
            end
        $display("\nTotal of %d tests: Passed Tests = %d; Faied Tests = %d",num_tests,pass_count,fail_count);
        $stop;
        #10;
        $finish;
        end
endmodule