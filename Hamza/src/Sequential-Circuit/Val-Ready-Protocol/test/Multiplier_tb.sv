/* verilator lint_off NULLPORT */

module Multiplier_tb #(
    parameter WIDTH = 16  // Parameter for width of input and output signals
)(
    `ifdef VERILATOR
    input logic clk,
    `endif
);

    // Inputs
    `ifndef VERILATOR
    logic clk;
    `endif
    logic rst;
    logic signed [WIDTH-1:0] Multiplicand, m_in;
    logic signed [WIDTH-1:0] Multiplier, m_in2;

    logic src_ready;
    logic dest_valid;
    logic src_valid;
    logic dest_ready;

    // Reference model output
    logic signed [(2*WIDTH)-1:0] exp;

    // Outputs
    logic signed [(2*WIDTH)-1:0] Product;


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

    `ifndef VERILATOR
    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Clock period of 10 time units
    end
    `endif


    // Dump file for waveform
    initial begin
        $dumpfile("Multiplier_tb.vcd");
        $dumpvars(0, Multiplier_tb);
    end

    // Task for driving inputs
    task driver (input int tests);
        begin
            for (int j = 0;j <= tests ; j++) begin
                Multiplier = $random();
                Multiplicand = $random();

                src_valid = 1;
                @(posedge clk);
                src_valid = 0;

                while (!dest_valid) @(posedge clk);
            end
        end
    endtask

    // Task for driving ouptuts
    task monitor(input int tests);
        for(int i = 0; i <= tests; i++) begin
            @(posedge src_valid);
            repeat (2) @(posedge clk);
            
            dest_ready = 1;
            
            while (!dest_valid) @(posedge clk);

            exp = Multiplier * Multiplicand;
            if (exp != Product) begin
                $display("Fail: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
            end else begin
                $display("Pass: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
            end
            
            dest_ready = 0;
        end
    endtask

    // Task for direct tests
    task direct_test(input signed [WIDTH-1:0] in_a, in_b);
    
        Multiplier =  in_a; Multiplicand = in_b;

        src_valid = 1;
        @(posedge clk);
        src_valid = 0;

        dest_ready = 1;

        // gives the clock signal till the ready comes
        while (!dest_valid) @(posedge clk);

        exp = in_a * in_b;
        if (exp != Product) begin
            $display("Fail: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
        end else begin
            $display("Pass: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
        end

        dest_ready = 0;
        
    endtask

    // Task for reset sequence
    task reset_sequence;
        begin
            rst = 0;
            repeat(10) @(posedge clk);
            rst = 1;
        end
    endtask

    // Stimulus process
    initial begin
        // Initialize Inputs
        Multiplicand = 0;
        Multiplier = 0;
        src_valid = 0;
        exp = 0;
        dest_ready = 0;
        rst = 1;
        
        reset_sequence();

        /* ---> Direct Test <--- */
        direct_test (10, 1);
        direct_test (10, -1);
        direct_test (-10, 1);
        direct_test (-10, -1);
        direct_test (0, 0);
        direct_test (0, -1);
        direct_test (-1, 0);
        direct_test (-100, -1001);

        // Fork-join for parallel test execution
        fork
            driver(50);
            monitor(50); 
        join


        $finish;
    end

endmodule

/* verilator lint_on NULLPORT */