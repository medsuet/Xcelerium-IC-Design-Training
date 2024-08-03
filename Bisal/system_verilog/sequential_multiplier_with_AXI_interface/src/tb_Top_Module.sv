module tb_Top_Module;
    // Testbench signals
    logic clk;
    logic reset;
    logic src_valid;
    logic signed [15:0] A;
    logic signed [15:0] B;
    logic signed [31:0] P;
    logic signed [31:0] expected_product;
    logic dst_ready;
    logic dst_valid;
    logic src_ready;
    logic [31:0] count_pass;
    logic [31:0] count_fail;

    Top_Module uut (
        .clk(clk),
        .reset(reset),
        .src_valid(src_valid),
        .dst_ready(dst_ready),
        .A(A),
        .B(B),
        .P(P),
        .src_ready(src_ready),
        .dst_valid(dst_valid)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset = 0;
        dst_ready = 0;
        src_valid = 0;
        A = 16'h0000;
        B = 16'h0000; 
        count_pass = 0;
        count_fail = 0;
        
        // RESET SEQUENCE
        reset = 1;
        @(posedge clk);
        reset = 0;
        
        // Execute directed tests
        directed_test(1, 1);
        directed_test(2, 3);
        directed_test(-1, 1);
        directed_test(0, 3);
         
        // Execute random tests 
        fork
            driver();
            monitor();
            scoreboard();
        join
        
        $display("Total passed tests: %d", count_pass);
        $display("Total failed tests: %d", count_fail);
        $finish;
    end
   //FOR DIRECTED TESTS
    task directed_test(input logic signed [15:0] a, input logic signed [15:0] b);
        A = a;
        B = b;
        src_valid = 1;
        @(posedge src_ready);
        @(negedge src_ready);
        @(posedge clk);
        src_valid = 0;
        dst_ready = 1;
        while (!dst_valid) begin
            @(posedge clk);
        end
        dst_ready = 0;
        // dst_ready = 0 but becomes 1 after some clock cycles
        while (!dst_valid) begin
            @(posedge clk);
        end
        dst_ready = 1;

        expected_product = A * B;
        $display("Monitor: A = %d, B = %d, Product = %d,Expected Product=%d", A, B, P,expected_product);
        @(posedge clk); 
    endtask
    //GENERATE RANDOM INPUTS
    task driver;
        logic signed [15:0] a, b;
        for (int i = 0; i < 200000; i++) begin
            a = $random;
            b = $random;
            launch_test(a, b);
        end
    endtask
    //VALID INPUT SIGNAL FOR RANDOM INPUTS
    task launch_test(input logic signed [15:0] a, input logic signed [15:0] b);
        A = a;
        B = b;
        src_valid = 1;
        @(posedge src_ready);
        @(negedge src_ready);
        @(posedge clk);
        src_valid = 0;
    endtask
    //MONITOR PRODUCT FOR RANDOM INPUTS
    task monitor;
        logic signed [15:0] mon_A, mon_B;
        logic signed [31:0] mon_P;
        for (int i = 0; i < 200000; i++) begin
            // dst_ready stays 1 after giving inputs 
            dst_ready = 1;
            while (!dst_valid) begin
                @(posedge clk);
            end
            dst_ready = 0;
            // dst_ready = 0 but becomes 1 after some clock cycles
            while (!dst_valid) begin
                @(posedge clk);
            end
            dst_ready = 1;
            mon_A = A;
            mon_B = B;
            mon_P = P;
            expected_product = mon_A * mon_B;
            $display("Monitor: A = %d, B = %d, Product = %d,Expected Product=%d", mon_A, mon_B, mon_P,expected_product);
            @(posedge clk); 
        end
    endtask
    //COUNT TESTS PASSED AND FAILED
    task scoreboard;
        for (int i = 0; i < 200000; i++) begin
            if (dst_valid) begin
                if (P != expected_product) begin
                    $display("Error: Expected product %d, but got %d", expected_product, P);
                    count_fail++;
                end else begin
                    count_pass++;
                end
            end
            @(posedge clk);
        end
    endtask
endmodule