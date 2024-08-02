module sequential_multiplier_tb();

    logic signed [15:0] Multiplicand;
    logic signed [15:0] Multiplier;
    logic reset;
    logic clk;
    logic signed [31:0] Product;
    logic [31:0] expected_product;
    logic [18:0] count_pass;
    logic src_valid, src_ready;
    logic dest_valid, dest_ready;

    sequential_multiplier dut (
        .clk(clk),
        .reset(reset),
        .src_valid(src_valid),
        .dest_ready(dest_ready),
        .Multiplicand(Multiplicand),
        .Multiplier(Multiplier),
        .Product(Product),
        .dest_valid(dest_valid),
        .src_ready(src_ready)
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
        #100 reset = 0;
        #100 reset = 1;
         directed_test(2, 3);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        directed_test(0, 3);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        directed_test(-2, 3);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        directed_test(-2, 0);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        directed_test(8, 9);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        directed_test(1, 32767);
        $display("Multiplicand: %d Multiplier: %d Product: %d", Multiplicand, Multiplier, Product);
        fork
            driver();
            monitor();
        join
        $display("Pass Test: %d", count_pass);
        $finish;
    end

    task directed_test(input logic [15:0] a, input logic [15:0] b);
        Multiplicand = a;
        Multiplier = b;
        src_valid = 1;
        @(posedge clk);
        src_valid = 0;
        while (!dest_valid) @(posedge clk);
        dest_ready = 1;
        @(posedge clk);
        dest_ready = 0;
     endtask 


    task driver;
        logic [15:0] a, b;
        for (int i=0; i<200000; i++) begin
            a = $random;
            b = $random;
            directed_test(a, b);
        end
    endtask
        
    task monitor;
        for (int i=0; i<200000; i++) begin
            expected_product = Multiplicand * Multiplier;
            // Check the result
            if (Product != expected_product) begin
                $display("Error: Expected product %d, but got %d", expected_product, Product);
            end else begin
                count_pass++;
            end
        end
    endtask
endmodule

