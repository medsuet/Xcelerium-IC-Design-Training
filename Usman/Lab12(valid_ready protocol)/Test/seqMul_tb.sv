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
        .A(A), .B(B), .clk(clk), .reset(reset),.src_valid(src_valid), .dst_ready(dst_ready),
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
         @(posedge clk) src_valid = 0;
         @(posedge clk) reset = 0;
         @(posedge clk) reset = 1;
        end
    endtask
      
    
    task direct_test(input logic [15:0] test_A, test_B);
            A = test_A;
            B = test_B;
            src_valid = 1;
            @(posedge clk);
            @(posedge clk);
            while(~src_ready) 
            begin
                @(posedge clk);
            end    
            
            src_valid = 0;
            @(posedge clk);
	    
    endtask

    task driver(input logic [3:0]k);
      for(int i =0;i<=k;i++) begin
        A = $random;
        B = $random;
        src_valid = 1;
        @(posedge clk);
        @(posedge clk);
        while(~src_ready) 
        begin
            @(posedge clk);
        end    
            
        src_valid = 0;
        @(posedge clk);
      end
      src_valid = 0;
    endtask

    task monitor();
       dst_ready = 0;
      forever begin 
           @(posedge clk);
           while(~src_valid ) begin
              @(posedge clk);
            end  
            signed_A = A;
            signed_B = B;
            expected_product = signed_A * signed_B;
            while(~dst_valid) begin
              @(posedge clk);
            end
            if (out !== expected_product) begin
                $display("Test Failed: A = %d, B = %d, Expected = %x, Got = %x", signed_A, signed_B, expected_product, out);
            end else begin
                $display("Test Passed: A = %d, B = %d, Expected = %x, Got = %x", signed_A, signed_B, expected_product, out);
            end
        
         dst_ready = 1;
         @(posedge clk) 
         dst_ready =0;
      end 
    endtask

initial begin
	monitor(); 
end
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

