module sequential_multiply_tb();

logic CLK;
logic signed [15:0] A;
logic signed [15:0] B;
logic src_valid;
logic dst_ready;
logic src_ready;
logic dst_valid;
logic RESET;
logic signed [31:0] product;

int simulator_run;

// Change Count Value
int count = 10000000;

sequential_multiply DUT (
    .CLK(CLK),
    .A(A),
    .B(B),
    .src_valid(src_valid),
    .RESET(RESET),
    .product(product),
    .dst_ready(dst_ready),
    .src_ready(src_ready),
    .dst_valid(dst_valid)
);

// Clock generation
initial 
begin
    CLK = 0;
    forever #10 CLK = ~CLK;
end

// Reset sequence
task reset_sequence();
begin
    @(posedge CLK);
    RESET = 0;
    src_valid = 0;
    dst_ready = 0;
    simulator_run = 1;
    @(posedge CLK);
    RESET = 1;
end
endtask

// Task to perform ready_before_valid test
task directed_test(input logic signed [15:0] A_in, input logic signed [15:0] B_in);
    logic signed [31:0] expected_product;

    begin
        A <= #1 A_in;
        B <= #1 B_in;

        // Directed Test - ANY TYPE
        @(posedge CLK);

        src_valid <= #1 1;
        // Handshake occurs

        // Wait for processing to start / Handshake to be occured
        while (src_valid)
        begin
            @(posedge CLK);
        end


        // Wait for dst_valid - A valid output
        while (!dst_valid)
        begin
            @(posedge CLK);
        end
        dst_ready <= #1 1;

        // Product will be stable at negedge of clock
        //@(negedge CLK);

        // Compute expected product
        expected_product = A_in * B_in;

        // Compare the result
        if (product !== expected_product) 
            begin
            $display("ERROR: A=%d, B=%d, Expected Product=%d, Got=%d", A_in, B_in, expected_product, product);
            $finish;
            end 
        else 
            begin
            $display("PASS: A=%d, B=%d, Product=%d", A_in, B_in, product);
            end

        // Wait for handshake to occur        
        while (dst_ready)
        begin
            @(posedge CLK);
        end

        @(posedge CLK);
    end
endtask


// Task to perform ready_before_valid test
task ready_before_valid(input logic signed [15:0] A_in, input logic signed [15:0] B_in);
    logic signed [31:0] expected_product;

    begin
        A <= #1 A_in;
        B <= #1 B_in;

        // src_ready will be 1 since state is at S0
        // Delay to test if src_ready stays 1 till handshake - Ready before valid
        repeat (1) @(posedge CLK);

        src_valid <= #1 1;
        // Handshake occurs

        // Wait for processing to start / Handshake to be occured
        while (src_valid)
        begin
            @(posedge CLK);
        end

        // Ready before valid
        repeat (10) @(posedge CLK);
        dst_ready <= #1 1;

        // Wait for dst_valid - A valid output
        while (!dst_valid)
        begin
            @(posedge CLK);
        end

        // Product will be stable at negedge of clock
        //@(negedge CLK);

        // Compute expected product
        expected_product = A_in * B_in;

        // Compare the result
        if (product !== expected_product) 
            begin
            $display("ERROR: A=%d, B=%d, Expected Product=%d, Got=%d", A_in, B_in, expected_product, product);
            $finish;
            end 
        else 
            begin
            $display("PASS: A=%d, B=%d, Product=%d", A_in, B_in, product);
            end

        // Wait for handshake to occur        
        while (dst_ready)
        begin
            @(posedge CLK);
        end

        @(posedge CLK);
    end
endtask

// Task to perform valid_before_ready test
task valid_before_ready(input logic signed [15:0] A_in, input logic signed [15:0] B_in);
    logic signed [31:0] expected_product;

    begin
        // Requires a directed test to be called previously!
        // We will start another src_valid signal once processing starts - Valid before ready
        while (src_valid)
        begin
            @(posedge CLK);
        end

        // It will take atleast 16 cycles for processing to complete
        // Generating a src_valid before processing completes - Valid before ready
        repeat (14) @(posedge CLK);
        A <= #1 A_in;
        B <= #1 B_in;
        src_valid <= #1 1;

        @(posedge CLK);
        // Handshake occurs
        // Wait for processing to start / Handshake to be occured
        while (src_valid)
        begin
            @(posedge CLK);
        end

        // Wait for dst_valid - A valid output - Valid before ready
        while (!dst_valid)
        begin
            @(posedge CLK);
        end

        // Product will be stable at negedge of clock
        //@(negedge CLK);

        // Compute expected product
        expected_product = A_in * B_in;

        // Compare the result
        if (product !== expected_product) 
            begin
            $display("ERROR: A=%d, B=%d, Expected Product=%d, Got=%d", A_in, B_in, expected_product, product);
            $finish;
            end 
        else 
            begin
            $display("PASS: A=%d, B=%d, Product=%d", A_in, B_in, product);
            end

        // Valid is asserted, but ready must go on after a delay - Valid before ready
        repeat (3) @(posedge CLK);
        dst_ready <= #1 1;

        // Wait for handshake to occur
        while (dst_ready)
        begin
            @(posedge CLK);
        end

        @(posedge CLK);
    end
endtask

// Task to perform valid_with_ready handshake test
task valid_with_ready(input logic signed [15:0] A_in, input logic signed [15:0] B_in);
    logic signed [31:0] expected_product;

    begin
        // We will start src_valid once src_ready is on - Valid with ready

        // Wait for prev ready to end
        while (src_ready)
        begin
            @(posedge CLK);
        end

        // Wait for next ready to start
        while (!src_ready)
        begin
            @(posedge CLK);
        end

        // Wait for prev ready to end
        while (src_ready)
        begin
            @(posedge CLK);
        end

        @(posedge src_ready);
        
        A <= #1 A_in;
        B <= #1 B_in;
        src_valid <= #1 1;

        // Handshake occurs
        // Wait for processing to start / Handshake to be occured
        while (src_valid)
        begin
            @(posedge CLK);
        end

        // Wait for dst_valid - A valid output - Valid with ready
        @(posedge dst_valid);
        dst_ready <= #1 1;      // Valid with ready

        // Product will be stable at negedge of clock
        @(negedge CLK);

        // Compute expected product
        expected_product = A_in * B_in;

        // Compare the result
        if (product !== expected_product) 
            begin
            $display("ERROR: A=%d, B=%d, Expected Product=%d, Got=%d", A_in, B_in, expected_product, product);
            $finish;
            end 
        else 
            begin
            $display("PASS: A=%d, B=%d, Product=%d", A_in, B_in, product);
            end

        // Wait for handshake to occur
        while (dst_ready)
        begin
            @(posedge CLK);
        end

        @(posedge CLK);
    end
endtask


task handshake_reset_valid();
    logic reset_src_valid;
    logic reset_dst_ready;

    begin
        while (simulator_run)
        begin
            @(posedge CLK);
            reset_src_valid = src_valid & src_ready;
            reset_dst_ready = dst_ready & dst_valid;
            if (reset_src_valid)
            begin
                src_valid <= #1 0;
            end
            if (reset_dst_ready)
            begin
                dst_ready <= #1 0;
            end
        end
    end

endtask

task driver();
    int i;
    begin
        for (i=0; i<count; i++)
        begin
            @(posedge CLK);
            A = #1 ($random);
            B = #1 ($random);

            src_valid <= #1 1;

            while (src_valid)
            begin
                @(posedge CLK);
            end

            repeat (16) @(posedge CLK);

            dst_ready <= #1 1;

            while (dst_ready)
            begin
                @(posedge CLK);
            end

            @(posedge CLK);
        end
    end
endtask

task monitor();
    int j;
    logic signed [15:0] multiplier_m, multiplicand_m;
    logic signed [31:0] expected_product;

    begin
        for (j=0; j<count; j++)
        begin
            @(posedge src_valid);
            @(negedge CLK);

            multiplier_m = A;
            multiplicand_m = B;

            expected_product = multiplier_m * multiplicand_m;

            while (!dst_valid)
            begin
                @(posedge CLK);
            end
            //@(negedge CLK);

            // Compare the result
            if (product !== expected_product) 
            begin
                $display("ERROR: A=%d, B=%d, Expected Product=%d, Got=%d", multiplier_m, multiplicand_m, expected_product, product);
                $display("ERROR: A=%d, B=%d, Expected Product=%d, Got=%d", multiplier_m, multiplicand_m, expected_product, product);
                $finish;
            end 
            else 
            begin
                $display("Test #%0d  |  PASS  |  A=%d  |  B=%d  |  Product=%d",j+1, multiplier_m, multiplicand_m, product);
            end
        end
    end
endtask


initial
begin
    reset_sequence();
    handshake_reset_valid();
end

// Main test sequence
initial 
begin
    @(negedge RESET);
    @(posedge RESET);

    // You can run any test by commenting the test


    // ##########################################
    // RUN: ready_before_valid handshake test
    // REQUIREMENTS: none
    // ##########################################
    fork
        ready_before_valid(10, -10);
    join

    // ##########################################
    // RUN: valid_before_ready handshake test
    // REQUIREMENTS: directed_test
    // ##########################################
    fork
        directed_test(1,1);
        valid_before_ready(-100,10);
    join

    // ##########################################
    // RUN: valid_with_ready handshake test
    // REQUIREMENTS: directed_test
    // ##########################################
    fork
        directed_test(1,1);
        valid_with_ready(1000,10);
    join

    fork
        driver();
        monitor();
    join

    simulator_run = 0;          // Turn off the reset loop.
    $stop;
    $finish;
end


endmodule
