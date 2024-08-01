module sequential_multiplier_tb();

    logic signed [15:0] Multiplicand;
    logic signed [15:0] Multiplier;
    logic reset;
    logic clk;
    logic signed [31:0] Product;
    logic [31:0] expected_product;
    logic [18:0] count_pass;
    logic input_valid, input_ready;
    logic output_valid, output_ready;

    sequential_multiplier dut (
        .clk(clk),
        .reset(reset),
        .input_valid(input_valid),
        .output_ready(output_ready),
        .Multiplicand(Multiplicand),
        .Multiplier(Multiplier),
        .Product(Product),
        .output_valid(output_valid),
        .input_ready(input_ready)
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
//         $dumpfile("sequential_multiplier_tb.vcd");
//         $dumpvars(0, sequential_multiplier_tb);
        count_pass = 0;
        expected_product = 0;
        reset = 1;
        #1 reset = 0;
        #1 reset = 1;
         test_directives(2, 3);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        test_directives(0, 3);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        test_directives(-2, 3);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        test_directives(-2, 0);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        test_directives(8, 9);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        test_directives(1, 32767);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        fork
            driver();
            monitor();
        join
        $display("Pass Test: %d", count_pass);
        $finish;
    end

    task test_directives(input logic [15:0] a, input logic [15:0] b);
        Multiplicand = a;
        Multiplier = b;
        input_valid = 1;
        @(posedge clk);
        input_valid = 0;
        @(posedge clk);
        input_valid = 1;
        @(posedge clk);
        input_valid = 0;
        wait (output_valid); 
        output_ready = 1;
        @(posedge clk);
        output_ready = 0;
        @(posedge clk);
        output_ready = 1;
        @(posedge clk);
        output_ready = 0;
        @(posedge clk);
        endtask 


    task driver;
        logic [15:0] a, b;
        for (int i=0; i<200000; i++) begin
            a = $random;
            b = $random;
            test_directives(a, b);
        end
    endtask
        
    task monitor;
        for (int i=0; i<200000; i++) begin
            @(negedge input_valid);
            wait(output_ready && output_valid);
            expected_product = Multiplicand * Multiplier;

            repeat(2) @(posedge clk);
            // Check the result
            if (Product !== expected_product) begin
                $display("Error: Expected product %d, but got %d", expected_product, Product);
            end else begin
                count_pass++;
            end
        end
    endtask
endmodule

