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

    `ifndef Verilator
    initial begin
        // Open a VCD file to write the simulation results
        $dumpfile("waveform.vcd");
        $dumpvars(0, array_multiplier_tb); // Dump all variables in the array_multiplier_tb module
    end
    `endif 

    initial begin
        // Applying Reset
        reset_sequence();

        // Run directed test cases
        directed_tests();

        // Run random test cases
        repeat(10) begin
            driver();
            monitor();
            repeat(3) @(posedge clk);
            apply_dst_ready();
        end

        $finish; // Ensure the simulation ends properly
    end

    task reset_sequence();
        begin
            reset = 1;
            dst_ready = 1'b0;
            @(posedge clk);
            reset <= 0;
            @(posedge clk);
            reset <= 1;
        end
    endtask

    task driver();
        apply_inputs();
        @(posedge clk);
        valid_src <= 1'b1;
        @(posedge clk);
        valid_src <= 1'b0;
    endtask

    task monitor();
        // Wait for the dst_valid signal to be asserted
        @(posedge dst_valid);
        
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

        // Ensure dst_valid goes low before the next operation
        //@(negedge dst_valid);
    endtask

    task apply_inputs();
        multiplicand = $random;
        multiplier = $random;
    endtask

    task apply_dst_ready();
        // Ensure dst_ready is asserted when necessary
        @(posedge clk);
        dst_ready <= 1'b1;
        @(posedge clk);
        dst_ready <= 1'b0;
    endtask
    
    task directed_tests();
        // Test 1: valid_src before dst_ready
        $display("Running Test 1: valid_src before dst_ready");
        apply_inputs();
        @(posedge clk);
        valid_src <= 1'b1;
        @(posedge clk);
        valid_src <= 1'b0;
        @(posedge clk);
        monitor();
        apply_dst_ready();

        // Test 2: dst_ready before valid_src
        $display("Running Test 2: dst_ready before valid_src");
        apply_inputs();
        @(posedge clk);
        valid_src <= 1'b1;
        @(posedge clk);
        valid_src <= 1'b0;
        dst_ready <= 1'b1;
        monitor();
        repeat(2) @(posedge clk);
        dst_ready <= 1'b0;

        // Test 3: valid_src and dst_ready at the same time
        $display("Running Test 3: dst_valid and dst_ready at the same time");
        apply_inputs();
        @(posedge clk);
        valid_src <= 1'b1;
        @(posedge clk);
        valid_src <= 1'b0;
        @(posedge clk);
        // Wait for the dst_valid signal to be asserted
        @(posedge dst_valid);
        dst_ready <= 1'b1;
        
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

        @(negedge dst_valid);
        dst_ready <= 1'b0;
        
    endtask
    
endmodule
