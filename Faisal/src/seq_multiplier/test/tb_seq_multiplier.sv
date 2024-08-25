module tb_seq_multiplier;

    // Inputs
    logic signed [15:0] Multiplicand;
    logic signed [15:0] Multiplier;
    logic clk;
    logic rst;
    logic start;

    // Reference model output
    logic signed [31:0] expected;

    // Outputs
    logic ready;
    logic signed [31:0] Product;

    // Instantiation
    seq_multiplier uut (
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
        $dumpfile("seq_multiplier.vcd");
        $dumpvars(0, tb_seq_multiplier);
    end

    // Task for driving inputs
    task drive_inputs(input logic signed [15:0] input1, input logic signed [15:0] input2);
        begin
            Multiplicand = input1;
            Multiplier = input2;
            start = 1;
            @(posedge clk);
            start = 0;
        end
    endtask

    // Task for monitoring outputs
    task monitor_outputs;
        begin
            wait (ready == 1);
            expected = Multiplicand * Multiplier;
            if (expected != Product) begin
                $display("Fail: A = %0d, B = %0d, Product = %0d, Expected = %0d", Multiplicand, Multiplier, Product, expected);
            end else begin
                $display("Pass: A = %0d, B = %0d, Product = %0d, Expected = %0d", Multiplicand, Multiplier, Product, expected);
            end
        end
    endtask

    // Directed test cases using fork-join for edge cases
    initial begin
        // Initialize Inputs
        Multiplicand = 0;
        Multiplier = 0;
        // first reset apply acychronus reset
        rst = 0;
        start = 0;
        @(posedge clk);
        rst = 1;

        // Fork-join for parallel test execution
        fork
            begin
                // directed tests
                drive_inputs(0, 12345);   
                monitor_outputs();

                @(posedge clk);

                drive_inputs(12345, 0);   
                monitor_outputs();

                @(posedge clk);

                drive_inputs(0, 0);   
                monitor_outputs();

                @(posedge clk);

                drive_inputs(12345, -1); 
                monitor_outputs();

                @(posedge clk);
                
                drive_inputs(-1, 1); 
                monitor_outputs();

                @(posedge clk);
                
                // Random testing loop
                for (int i = 0; i < 200; i++) begin
                    logic signed [15:0] rand_multiplicand, rand_multiplier;
                    
                    // Generate random numbers
                    rand_multiplicand = $random % 65536; 
                    rand_multiplier = $random % 65536;  

                    // Drive random inputs and check output
                    drive_inputs(rand_multiplicand, rand_multiplier);
                    monitor_outputs();

                    @(posedge clk); // Synchronize with the clock
                end
            end
        join

        $finish;
    end
endmodule