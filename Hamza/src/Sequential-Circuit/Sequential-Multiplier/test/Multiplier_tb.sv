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
    logic start;
    logic signed [WIDTH-1:0] Multiplicand, m_in;
    logic signed [WIDTH-1:0] Multiplier, m_in2;

    // Reference model output
    logic signed [(2*WIDTH)-1:0] exp;

    // Outputs
    logic ready;
    logic signed [(2*WIDTH)-1:0] Product;

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

    task driver (input int tests);
        begin
            for (int j = 0;j <= tests ; j++) begin
                Multiplier = $random();
                Multiplicand = $random();

                start = 1;
                @(posedge clk);
                start = 0;

                while(!ready) begin
                    @(posedge clk);
                end
            end
        end
    endtask

    task monitor(input int tests);
        for(int i = 0; i <= tests; i++) begin
            @(posedge start);
            repeat (2) @(posedge clk);
            
            // gives the clock signal till the ready comes
            while (!ready) begin
                @(posedge clk);
            end

            exp = Multiplier * Multiplicand;
            if (exp != Product) begin
                $display("Fail: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
            end else begin
                $display("Pass: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
            end
        end
    endtask

    task direct_test(input signed [WIDTH-1:0] in_a, in_b);
    
        Multiplier =  in_a; Multiplicand = in_b;

        start = 1;
        @(posedge clk);
        start = 0;

        // gives the clock signal till the ready comes
        while (!ready) begin
            @(posedge clk);
        end

        exp = in_a * in_b;
        if (exp != Product) begin
            $display("Fail: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
        end else begin
            $display("Pass: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
        end
        
    endtask

    // Task for reset sequence
    task reset_sequence;
        begin
            rst = 0;
            repeat(10) @(posedge clk);
            rst = 1;
        end
    endtask

    // Directed test cases using fork-join for edge cases
    initial begin
        // Initialize Inputs
        Multiplicand = 0;
        Multiplier = 0;
        m_in = 0;
        m_in2 = 0;
        start = 0;
        
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
