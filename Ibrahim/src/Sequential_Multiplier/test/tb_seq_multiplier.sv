module tb_seq_multiplier;
    // Parameter definition with default value
    parameter WIDTH = 16;
    // Inputs
    logic signed [WIDTH-1:0] Multiplicand;
    logic signed [WIDTH-1:0] Multiplier;
    logic clk;
    logic rst;
    logic start;

    // Reference model output
    logic signed [(2*WIDTH)-1:0] exp;

    // Outputs
    logic ready;
    logic signed [(2*WIDTH)-1:0] Product;

    // Counters for pass and fail
    int pass_count = 0;
    int fail_count = 0;

    // Instantiate the Unit Under Test (UUT)
    seq_multiplier #(.WIDTH(WIDTH)) uut (
        .multiplicand(Multiplicand),
        .multiplier(Multiplier),
        .clk(clk),
        .rst_n(rst),
        .start(start),
        .ready(ready),
        .product(Product)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; // 10 ns period clock
    end

    // Dump file for waveform
    initial begin
        $dumpfile("multiplier.vcd");
        $dumpvars(0, tb_seq_multiplier);
    end

    // Task for driving inputs
    task drive_inputs(input logic signed [WIDTH-1:0] in1, input logic signed [WIDTH-1:0] in2);
        begin
            Multiplicand = in1;
            Multiplier = in2;
            start = 1;
            @(posedge clk);
            start = 0;
        end
    endtask

    // Task for monitoring outputs
    task monitor_outputs;
        begin
            repeat(15) @(posedge clk);
            // wait(ready == 1);
            // #5
            exp = Multiplicand * Multiplier;
            @(posedge clk);
            if(exp != Product) begin
                fail_count++;
                $display("FAIL: time = %0t, A = %0d, B = %0d, P = %0d, E = %0d", $time, Multiplicand, Multiplier, Product, exp);
            end else begin
                pass_count++;
                $display("PASS: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
            end
        end
    endtask

    // Task for reset sequence
    task reset_sequence();
        begin
            rst = 0;
            start = 0;
            @(posedge clk);
            rst = 1;
        end
    endtask

    // Stimulus process
    initial begin
        // Initialize Inputs
        Multiplicand = 0;
        Multiplier = 0;
        
        reset_sequence();

        // Test case: Multiplication with 0
        drive_inputs(0, 0);
        monitor_outputs();
        // 32767 x 0
        drive_inputs({WIDTH-1{1'b1}}, 0);
        monitor_outputs();
        // -32768 x 0
        drive_inputs({1'b1, {WIDTH-1{1'b0}}}, 0);
        monitor_outputs();

        // Test case: Multiplication with 1
        drive_inputs(1, 1);
        monitor_outputs();
        drive_inputs({WIDTH-1{1'b1}}, 1);
        monitor_outputs();
        drive_inputs(1, {WIDTH-1{1'b1}});
        monitor_outputs();

        // Test case: Multiplication with negative numbers
        drive_inputs(-1, -1);
        monitor_outputs();
        drive_inputs({WIDTH-1{1'b1}}, -1);
        monitor_outputs();
        drive_inputs(-1, {WIDTH-1{1'b1}});
        monitor_outputs();

        // Max positive numbers
        drive_inputs({WIDTH-1{1'b1}}, {WIDTH-1{1'b1}});
        monitor_outputs();

        // Max positive and max negative numbers
        drive_inputs({WIDTH-1{1'b1}}, {1'b1, {WIDTH-1{1'b0}}});
        monitor_outputs();

        // Test case: Random Testing
        for(int i = 0; i < 100000; i++) begin 
            // Non-random testing
            drive_inputs(0 + i, 10 + i); 
            monitor_outputs();
            // Random testing
            drive_inputs($random, $random); 
            monitor_outputs();
        end

        // Print the number of passes and fails
        $display("Number of PASSES: %0d", pass_count);
        $display("Number of FAILS: %0d", fail_count);

        $finish;
    end

endmodule

