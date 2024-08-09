/* verilator lint_off NULLPORT */
/* verilator lint_off UNOPTFLAT */

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
    task driver (input logic signed [15:0] input_1, input logic signed [15:0] input_2);
        begin
            Multiplier = input_1;
            Multiplicand = input_2;

            src_valid = 1;
            @(posedge clk);
            src_valid = 0;

            while (!dest_valid) @(posedge clk);
                              
            @(posedge clk);
            dest_ready = 1;
            @(posedge clk);
            dest_ready = 0;
        end
    endtask

    // Task for driving ouptuts
    task monitor;
        begin
            @(posedge dest_ready) exp = Multiplicand * Multiplier;
            if (exp != Product) begin
                $display("Fail: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
            end else begin
                $display("Pass: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
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

    // Stimulus process
    initial begin
        // Initialize Inputs
        Multiplicand = 0;
        Multiplier = 0;
        src_valid = 0;
        exp = 0;
        dest_ready = 0;
        
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
/* verilator lint_on UNOPTFLAT */