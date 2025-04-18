module seqMul_tb;

    // Signals
    logic clk, reset, cmp, src_ready,dst_valid;
    logic [15:0] A, B;
    logic [31:0] out;
   
    logic [15:0] rand_A, rand_B;
    logic src_valid,dst_ready;

    logic signed [31:0] expected_product;
    logic signed [15:0] signed_A, signed_B;
    
    // DUT instantiation
    seqMul dut (
        .A(A), .B(B), .clk(clk), .reset(reset), .start(start),.src_valid(src_valid), .dst_ready(dst_ready),
        .src_ready(src_ready), .dst_valid(dst_valid), .out(out)
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
      
    
    task direct_test(input logic [15:0] test_A, test_B);
            src_valid = 1;
            A = test_A;
            B = test_B;

            while(~src_ready) begin
                @(posedge clk)
            end    
            
            src_valid = 0;
            @(posedge clk);
	    
    endtask

    task driver(k);
      for(int i =0;i<=k;i++) begin
        src_valid=1;        
        rand_A = $random;
        rand_B = $random;
        A = rand_A;
        B = rand_B;
        while(src_ready!=1)begin
            @(posedge clk);
        end
        src_valid = 0;
      end
      $finish;
    endtask

    task monitor();
      forever begin 
        
        
           while(src_valid) begin
              @(posedge clk);
            end  
            signed_A = A;
            signed_B = B;
            expected_product = signed_A * signed_B;
            while(~dst_valid) begin
              @(posedge clk);
            end  
            if (out !== expected_product) begin
                $display("Test Failed: A = %d, B = %d, Expected = %d, Got = %d", signed_A, signed_B, expected_product, out);
            end else begin
                $display("Test Passed: A = %d, B = %d, Product = %d", signed_A, signed_B, out);
            end
         dst_ready = 1;
         @(posedge clk) 
         dst_ready =0;
      end 
    endtask

    // Testbench
    initial begin
        
       rst();
       
        // Direct Test
        direct_test(16'd15, 16'd3);
        direct_test(-16'd5, 16'd7);
        direct_test(16'd8, -16'd4);
        direct_test(-16'd6, -16'd5);
        
        fork
          
              driver(4);
              monitor();
            
        join

        $stop;
    end
endmodule

