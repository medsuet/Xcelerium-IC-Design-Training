`include "../define/array_mul.svh"

module array_multiplier_tb (
        
        `ifdef Verilator 
            input logic clk
        `endif     
        
);
    `ifndef Verilator
        reg clk; 
    `endif
    reg reset;
    reg signed [width-1:0] multiplier, multiplicand;
    reg start;
    wire signed [result_width-1:0] product;
    wire ready;

    array_multiplier DUT (
        .clk(clk), .reset(reset),
        .multiplicand(multiplicand), .multiplier(multiplier),
        .start(start),
        .product(product),
        .ready(ready)
    );

    `ifndef Verilator
    // Clock Generator
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    `endif 

    initial begin
        // Applying Reset
        reset_sequence();

        // Run 10 random test cases
        repeat(10) begin
            // Enabling driver circuit for the inputs
            driver();

            // Enabling monitor circuit for checking the output
            monitor();
        end
        $stop; // Stop the simulation after 10 tests
    end

    task reset_sequence();
        begin
            reset = 1;
            @(posedge clk);
            reset = 0;
            @(posedge clk);
            reset = 1;
        end
    endtask

    task driver();
        apply_inputs();
        @(posedge clk);
        start = 1'b1;
        @(posedge clk);
        start = 1'b0;
    endtask

    task monitor();
        // Wait for the ready signal to be asserted
        wait(ready);
        
        // Check if the product matches the expected value
        if ($signed (product) == $signed (multiplier) * $signed (multiplicand)) begin
            $display("================= Test Passed ================");
            $display( " Multiplier: %0d | Multiplicand: %0d | Product: %0d",
                  multiplier, multiplicand, product);
           
        end

        else begin
            $display("================== Test Failed ================");
            $display( " Multiplier: %0d | Multiplicand: %0d ",multiplier, multiplicand); 
            $display(" Expected %0d, got %0d", $signed(multiplier * multiplicand), product);
        end

        // Ensure ready goes low before the next operation
        @(negedge ready);
    endtask

    task apply_inputs();
        multiplicand = $random;
        multiplier = $random;
    endtask

endmodule
