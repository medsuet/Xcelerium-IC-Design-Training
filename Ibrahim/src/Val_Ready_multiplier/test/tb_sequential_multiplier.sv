module tb_sequential_multiplier;
    // Parameter definition with default value
    parameter WIDTH = 16;

    // Inputs
    logic signed [WIDTH-1:0] Multiplicand; // Input for multiplicand
    logic signed [WIDTH-1:0] Multiplier;   // Input for multiplier
    logic clk;                             // Clock signal
    logic rst;                             // Reset signal
    logic src_valid;                       // Source valid signal
    logic dest_ready;                      // Destination ready signal

    // Expected product for verification
    logic signed [(2*WIDTH)-1:0] expected_product;

    // Outputs
    logic signed [(2*WIDTH)-1:0] Product;  // Output product
    logic src_ready, dest_valid;           // Handshake signals

    // Pass and fail counters
    integer pass_count = 0;
    integer fail_count = 0;

    // Instantiate the Unit Under Test (UUT)
    seq_multiplier #(.WIDTH(WIDTH)) uut (
        .multiplicand(Multiplicand),
        .multiplier(Multiplier),
        .clk(clk),
        .rst_n(rst),
        .src_valid(src_valid),
        .dest_ready(dest_ready),
        .dest_valid(dest_valid),
        .src_ready(src_ready),
        .product(Product)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; // 10 ns period clock
    end

    // Dump file for waveform
    initial begin
        $dumpfile("val_ready.vcd");
        $dumpvars(0);
    end

    // Task for driving inputs
    task drive_inputs(input logic signed [WIDTH-1:0] in1, input logic signed [WIDTH-1:0] in2);
        begin
            Multiplicand = in1;            // Assign input to multiplicand
            Multiplier = in2;              // Assign input to multiplier
            src_valid = 1;                 // Assert src_valid signal
            @(posedge clk);
            while (!src_ready) @(posedge clk); // Wait for src_ready signal
            $display("\nHandshake 1 complete: Multiplicand = %0d, Multiplier = %0d", Multiplicand, Multiplier);
            src_valid = 0;                 // Deassert src_valid signal
        end
    endtask

    // Task for monitoring outputs
    task monitor_outputs;
        begin
            wait(dest_valid == 1);         // Wait for dest_valid signal
            $display("Handshake 2 NOT Initiated");
            repeat(5)@(posedge clk);       // Random delay before asserting dest_ready
            dest_ready = 1;                // Assert dest_ready signal
            expected_product = Multiplicand * Multiplier; // Calculate expected product
            $display("'dest_ready' is 1, Handshake 2 Initiated: Waiting for product");
            @(posedge clk);
            if (expected_product == Product) begin
                pass_count += 1;
                $display("PASS: time = %0t, Multiplicand = %0d, Multiplier = %0d, Product = %0d, Expected = %0d", $time, Multiplicand, Multiplier, Product, expected_product);
            end else begin
                fail_count += 1;
                $display("FAIL: time = %0t, Multiplicand = %0d, Multiplier = %0d, Product = %0d, Expected = %0d", $time, Multiplicand, Multiplier, Product, expected_product);
            end
            dest_ready = 0;                // Deassert dest_ready signal
            @(posedge clk);
        end
    endtask

    // Task for reset sequence
    task reset_sequence();
        begin
            @(posedge clk);
            rst = 0;                       // Assert reset signal
            repeat(1000) @(posedge clk);
            rst = 1;                       // Deassert reset signal
        end
    endtask

    // Task to initialize the signals
    task init_sequence();
        begin
            // Initialize Inputs
            Multiplicand = 0;              // Initialize multiplicand to 0
            Multiplier = 0;                // Initialize multiplier to 0
            src_valid = 0;                 // Initialize src_valid to 0
            dest_ready = 0;                // Initialize dest_ready to 0
            rst = 1;                       // Initialize rst to 1
        end
    endtask

    // Task for generating random delay
    // Random delay between tests will ensure that even if src_ready is 1, if src_valid is not 1 handshake won't occur
    task random_delay();
        begin
            repeat(($random % 10)) @(posedge clk);
        end
    endtask

    // Stimulus process
    initial begin
        // Initialize Inputs
        init_sequence();
        
        reset_sequence();

        // Test with various inputs and random delays
        drive_inputs(2, 4);
        monitor_outputs();
        // Random delay between tests will ensure that even if src_ready is 1, if src_valid is not 1 handshake won't occur
        random_delay();
        drive_inputs(999, 222);
        monitor_outputs();

        // Test case: Multiplication with 0
        drive_inputs({WIDTH-1{1'b1}}, 0);
        monitor_outputs();
        random_delay();
        drive_inputs({1'b1, {WIDTH-1{1'b0}}}, 0);
        monitor_outputs();
        random_delay();

        // Test case: Multiplication with 1
        drive_inputs(1, 1);
        monitor_outputs();
        random_delay();
        drive_inputs({WIDTH-1{1'b1}}, 1);
        monitor_outputs();
        random_delay();
        drive_inputs(1, {WIDTH-1{1'b1}});
        monitor_outputs();
        random_delay();

        // Test case: Multiplication with negative numbers
        drive_inputs(-1, -1);
        monitor_outputs();
        random_delay();
        drive_inputs({WIDTH-1{1'b1}}, -1);
        monitor_outputs();
        random_delay();
        drive_inputs(-1, {WIDTH-1{1'b1}});
        monitor_outputs();
        random_delay();

        // Max positive numbers
        drive_inputs({WIDTH-1{1'b1}}, {WIDTH-1{1'b1}});
        monitor_outputs();
        random_delay();

        // Max positive and max negative numbers
        drive_inputs({WIDTH-1{1'b1}}, {1'b1, {WIDTH-1{1'b0}}});
        monitor_outputs();
        random_delay();

        // Random Testing with delays
        for(int i = 0; i < 50000; i++) begin
            // Drive random inputs to the multiplier
            drive_inputs($random, $random); 
            monitor_outputs();
            random_delay(); // Random delay between tests
        end

        // Display final results
        $display("\nTotal PASS count: %0d", pass_count);
        $display("Total FAIL count: %0d\n", fail_count);

        $finish;
    end

endmodule
