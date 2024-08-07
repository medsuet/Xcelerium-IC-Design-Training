module tb_seq_multiplier;

// parameter define
parameter CYCLE = 20; 
parameter WIDTH = 16; // width of multiplicand and multiplier 
parameter MAXNUM = 65536; // max number of 16 bit
parameter NUMTESTS = 500; // number of random tests


    // Inputs define
    logic signed [WIDTH-1:0] Multiplicand;
    logic signed [WIDTH-1:0] Multiplier;
    logic clk;
    logic rst;

    logic src_ready;
    logic dest_valid;
    logic src_valid;
    logic dest_ready;

  // for check how many tests are passed 
    logic [31:0] count_tests;
    logic [31:0] failed;
    logic [31:0] passed;

    // Reference model output
    logic signed [(2*WIDTH)-1:0] expected;

    // Outputs
    logic signed [(2*WIDTH)-1:0] Product;


    // Instantiate the Unit Under Test (UUT)
    seq_multiplier uut (
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
        forever #(CYCLE/2) clk = ~clk; // 10 ns period clock
    end

    // Dump file for waveform
    initial begin
        $dumpfile("seq_multiplier.vcd");
        $dumpvars(0, tb_seq_multiplier);
    end

    // Task for initialization
    task init_sequence;
        begin
            Multiplicand = 0;
            Multiplier = 0;
            src_valid = 0;
            expected = 0;
            count_tests = 0;
            passed = 0;
            failed = 0;
            dest_ready = 0;
            rst = 1;
            end     
    endtask 

    // Task for reset sequence
    task reset_sequence;
        begin
            rst = 0;
            repeat(5) @(posedge clk);
            rst = 1;
        end
    endtask

    // Task for driver
    task drive_inputs(input logic signed [WIDTH-1:0] input1, input logic signed [WIDTH-1:0] input2);
        begin
            Multiplicand = input1;
            Multiplier = input2; 
            src_valid = 1;
            @(posedge clk);
            while (!src_ready) @(posedge clk);
            src_valid = 0;
        end
    endtask

    // Task for monitor
    task monitor_outputs;
        begin 
            expected = Multiplicand * Multiplier;          
            while (!dest_valid) @(posedge clk);
            dest_ready = 1;
            count_tests ++;
            
            if (expected != Product) 
            begin
                failed ++;
                $display("Test:%0d Fail: A = %0d, B = %0d, P = %0d, E = %0d",count_tests, Multiplicand, Multiplier, Product, expected);
            end 
            else 
            begin
                passed ++;
                $display("Test:%0d Pass: A = %0d, B = %0d, P = %0d, E = %0d",count_tests, Multiplicand, Multiplier, Product, expected);
            end
            
            @(posedge clk) dest_ready = 0;
        end
    endtask

    // Stimulus process
    initial begin
        // Initialize Inputs signals
        init_sequence();
        
        // reset apply
        reset_sequence();

        fork
            begin
            // Directed Tests
            drive_inputs(1, 22115);
            monitor_outputs();

            drive_inputs(999, 222);
            monitor_outputs();

            drive_inputs(1, 222);
            monitor_outputs();

            drive_inputs(0, 12345);
            monitor_outputs();

            drive_inputs(12345, -1);
            monitor_outputs();

            drive_inputs(-1, 1);
            monitor_outputs();

            // Random testing 
            for (int i = 0; i < NUMTESTS; i++) begin

                // Generate random numbers
                Multiplicand = $random % MAXNUM; 
                Multiplier = $random % MAXNUM;  

                // Drive random inputs and check output
                drive_inputs(Multiplicand, Multiplier);
                monitor_outputs();
            end
            $display("%0d Tests failed", failed);
            $display("%0d Tests passed", passed);
            end     
        join
        $finish;
    end

endmodule