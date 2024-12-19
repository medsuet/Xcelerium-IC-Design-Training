module seqMul_tb;

    // Signals
    logic clk, reset, start, cmp, ready;
    logic [15:0] A, B;
    logic [31:0] out;
    logic M1_sel, M2_sel, M3_sel, enA, enB, enAA, enBB;
    logic [15:0] rand_A, rand_B;
    // DUT instantiation
    seqMul dut (
        .A(A), .B(B), .clk(clk), .reset(reset), .start(start),
        .ready(ready), .out(out)
    );

    // Clock generation
   initial begin 
    clk = 0;
    forever #5 clk = ~clk;
   end
    // Tasks
    task rst();
        begin
         
         @(posedge clk) reset = 0;
         @(posedge clk) reset = 1;
        end
    endtask
      
    task strt();
        begin
         @(posedge clk) start = 1;
         @(posedge clk) start = 0;
        end
    endtask
    task direct_test(input logic [15:0] test_A, test_B);
      
        
            A = test_A;
            B = test_B;
            rst();
            strt();
            wait(ready);
            $display("Direct Test: A = %d, B = %d, Product = %d", test_A, test_B, out);
        
    endtask

    task driver();
        
         @(negedge reset);
         @(posedge reset);
        
        for (int i = 0; i < 1000; i++) begin
            @(posedge clk);
            rand_A = $random;
            rand_B = $random;
            A = rand_A;
            B = rand_B;
            strt();
            wait(ready);
        end
    endtask

    task monitor();
        logic signed [31:0] expected_product;
        logic signed [15:0] signed_A, signed_B;
         @(negedge reset);
         @(posedge reset);
        for (int i = 0; i < 1000; i++) begin
           @(posedge clk)
            signed_A = A;
            signed_B = B;
            expected_product = signed_A * signed_B;
            wait(ready);
            if (out !== expected_product) begin
                $display("Test Failed: A = %d, B = %d, Expected = %d, Got = %d", signed_A, signed_B, expected_product, out);
            end else begin
                $display("Test Passed: A = %d, B = %d, Product = %d", signed_A, signed_B, out);
            end
        end
    endtask

    // Testbench
    initial begin
        
       
       
        // Direct Test
        direct_test(16'd15, 16'd3);
        direct_test(-16'd5, 16'd7);
        direct_test(16'd8, -16'd4);
        direct_test(-16'd6, -16'd5);
        
        fork
            driver();
            monitor();
        join

        $stop;
    end
endmodule

