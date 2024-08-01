module Multiplier_tb;

    // Inputs
    logic signed [15:0] Multiplicand;
    logic signed [15:0] Multiplier;
    logic clk;
    logic rst;

    logic src_ready;
    logic dest_valid;
    logic src_valid;
    logic dest_ready;

    // Reference model output
    logic signed [31:0] exp;

    // Outputs
    logic signed [31:0] Product;


    // Instantiate the Unit Under Test (UUT)
    Multiplier uut (
        .Multiplicand(Multiplicand),
        .Multiplier(Multiplier),
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .dest_ready(dest_ready),
        .dest_valid(dest_valid),
        .src_ready(src_ready),
        .Product(Product)
    );
   // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; // 10 ns period clock
    end

    // Dump file for waveform
    initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, Multiplier_tb);
    end

    // Task for driving inputs
    task drive_inputs(input logic signed [15:0] in1, input logic signed [15:0] in2);
        begin
            Multiplicand = in1;
            Multiplier = in2;
            src_valid = 1;
            @(posedge clk);
            src_valid = 0;
        end
    endtask

    // Task for monitoring outputs
    task monitor_outputs;
        begin
            dest_ready = 1;
            @(posedge clk);
            dest_ready = 0;
            // repeat(15) @(posedge clk);
            wait(dest_valid == 1);
            // #5
            // exp = Multiplicand * Multiplier;
            repeat(6) @(posedge clk);
            dest_ready = 1;
            repeat(4)@(posedge clk);
            dest_ready = 0;

        end
    endtask

    // Task for reset sequence
    task reset_sequence;
        begin
            rst = 0;
            @(posedge clk);
            rst = 1;
        end
    endtask

    // Stimulus process
    initial begin
        // Initialize Inputs
        Multiplicand = 0;
        Multiplier = 0;
        src_valid = 0;
        dest_ready = 0;
        rst = 1;
        
        reset_sequence();

        // Test case: Multiplication with 0
        drive_inputs(2, 4);
        monitor_outputs();
        drive_inputs(999, 222);
        monitor_outputs();

        $finish;
    end

endmodule