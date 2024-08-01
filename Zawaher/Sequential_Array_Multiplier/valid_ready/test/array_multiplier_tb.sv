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
    reg valid_src, dst_ready;
    wire signed [result_width-1:0] product;
    wire src_ready, dst_valid;

    array_multiplier DUT (
        .clk(clk), .reset(reset),
        .multiplicand(multiplicand), .multiplier(multiplier),
        .valid_src(valid_src), .dst_ready(dst_ready),
        .product(product),
        .src_ready(src_ready), .dst_valid(dst_valid)
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

            // Applying the dst_ready signal
           // apply_dst_ready();

            // Enabling monitor circuit for checking the output
            monitor();
           repeat(3) @(posedge  clk);
            // Applying the dst_ready signal
            apply_dst_ready();
        end
        $stop; // Stop the simulation after 10 tests
    end

    task reset_sequence();
        begin
            reset = 1;
            dst_ready = 1'b0;
            @(posedge clk);
            reset = 0;
            @(posedge clk);
            reset = 1;
        end
    endtask

    task driver();
        apply_inputs();
        @(posedge clk);
        valid_src = 1'b1;
        @(posedge clk);
        valid_src = 1'b0; // Deassert valid_src after one clock cycle
    endtask

    task monitor();
        // Wait for the dst_valid signal to be asserted
        wait(dst_valid);
        
        // Check if the product matches the expected value
        if ($signed(product) == $signed(multiplier) * $signed(multiplicand)) begin
            $display("================= Test Passed ================");
            $display("Multiplier: %0d | Multiplicand: %0d | Product: %0d",
                      multiplier, multiplicand, product);
        end
        else begin
            $display("================== Test Failed ================");
            $display("Multiplier: %0d | Multiplicand: %0d ", multiplier, multiplicand);
            $display("Expected %0d, got %0d", $signed(multiplier * multiplicand), product);
        end
        
        
    endtask

    task apply_inputs();
        multiplicand = $random;
        multiplier = $random;
    endtask

    task apply_dst_ready();
        // Ensure dst_ready is asserted when necessary
        @(posedge clk);
        dst_ready = 1'b1;
        @(posedge clk);
        dst_ready = 1'b0; // Optionally deassert dst_ready to see different responses
    endtask
    
endmodule
