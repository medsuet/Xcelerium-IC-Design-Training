module Multiplier_tb;

    // Inputs
    logic signed [15:0] Multiplicand;
    logic signed [15:0] Multiplier;
    logic clk;
    logic rst;
    logic start;

    // Reference model output
    logic signed [31:0] exp;

    // Outputs
    logic ready;
    logic signed [31:0] Product;

    // Instantiate the Unit Under Test (UUT)
    Multiplier uut (
        .Multiplicand(Multiplicand),
        .Multiplier(Multiplier),
        .clk(clk),
        .rst(rst),
        .start(start),
        .ready(ready),
        .Product(Product)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; // 10 ns period clock
    end

    // Dump file for waveform
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, Multiplier_tb);
    end

    // Task for driving inputs
    task drive_inputs(input logic signed [15:0] in1, input logic signed [15:0] in2);
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
            wait (ready == 1);
            exp = Multiplicand * Multiplier;
            if (exp != Product) begin
                $display("Fail: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
            end else begin
                $display("Pass: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
            end
        end
    endtask

    // Directed test cases using fork-join for edge cases
    initial begin
        // Initialize Inputs
        Multiplicand = 0;
        Multiplier = 0;
        rst = 0;
        start = 0;
        @(posedge clk);
        rst = 1;

        // Fork-join for parallel test execution
        fork
            begin
                drive_inputs(0, 12345);   
                monitor_outputs();

                @(posedge clk);

                drive_inputs(12345, -1); 
                monitor_outputs();

                @(posedge clk);
                
                drive_inputs(-1, 1); 
                monitor_outputs();

                @(posedge clk);

                // Random testing loop
                for (int i = 0; i < 20000; i++) begin
                    logic signed [15:0] randMultiplicand, randMultiplier;
                    
                    // Generate random numbers
                    randMultiplicand = $random % 65536; 
                    randMultiplier = $random % 65536;  

                    // Drive random inputs and check output
                    drive_inputs(randMultiplicand, randMultiplier);
                    monitor_outputs();

                    @(posedge clk); // Synchronize with the clock
                end
            end
        join

        $finish;
    end
endmodule
