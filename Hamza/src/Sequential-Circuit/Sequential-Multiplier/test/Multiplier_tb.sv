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

    // Task for driving inputs
    task driver(input logic signed [15:0] in1, input logic signed [15:0] in2);
        begin
            Multiplicand = in1;
            Multiplier = in2;
            start = 1;
            @(posedge clk);
            start = 0;
            while(! ready) @(posedge clk);
        end
    endtask

    // Task for monitoring outputs
    task monitor;
        begin
            @(posedge ready) exp = Multiplicand * Multiplier;
            if(exp != Product)
            begin
                $display("Fail: A = %0h, B = %0h, P = %0h,E= %0h", Multiplicand, Multiplier, Product,exp);
            end
            else
            begin
                $display("Pass: A = %0h, B = %0h, P = %0h,E= %0h", Multiplicand, Multiplier, Product,exp);
            end
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

        //directed testbench
        fork
            driver(10,1); 
            monitor();
        join
        
        fork
            driver(0,1000); 
            monitor();
        join
        
        fork
            driver(-1,1000); 
            monitor();
        join

        // Fork-join for parallel test execution
        for (int i=0; i<200 ;i++ ) begin
            fork
                driver($random ,$random);
                monitor(); 
            join
        end

        $finish;
    end
endmodule

/* verilator lint_on NULLPORT */
