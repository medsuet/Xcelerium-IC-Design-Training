module tb_seq_multiplier;

    // Parameters
    parameter WIDTH_M = 16;
    parameter WIDTH_P = 32;
  
    // Inputs
    logic clk;
    logic rst_n;
    logic start;
    logic signed [WIDTH_M-1:0] multiplier;
    logic signed [WIDTH_M-1:0] multiplicand;
  
    // Outputs
    logic [WIDTH_P-1:0] product;
    logic ready;
  
    // Instantiate the module
    seq_multiplier uut (
      .clk(clk),
      .rst_n(rst_n),
      .start(start),
      .multiplier(multiplier),
      .multiplicand(multiplicand),
      .product(product),
      .ready(ready)
    );
  
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
  
    // Test procedure
    initial begin
        // Initialize inputs
        clk = 0;
        rst_n = 1;
        start = 0;
        multiplier = 0;
        multiplicand = 0;
        @(posedge clk);
        rst_n = 0;
        // @(negedge rst_n);
        #10
        // @(posedge rst_n);
        @(posedge clk);
        // Test case 1: 3 * -2

        multiplier = 16'd3;
        multiplicand = 16'd2;
        start = 1;
        #10;
        start = 0;
        repeat(16) @(posedge clk);
        $display("Test Case 1: 3 * 2 = %d", $signed(product));  // Expected: -6
  
    //   // Test case 2: -4 * 5
    //   multiplier = -16'd4;
    //   multiplicand = 16'd5;
    //   start = 1;
    //   #10;
    //   start = 0;
    //   wait(ready);
    //   $display("Test Case 2: -4 * 5 = %d", $signed(product));  // Expected: -20
  
    //   // Test case 3: -3 * -3
    //   multiplier = -16'd3;
    //   multiplicand = -16'd3;
    //   start = 1;
    //   #10;
    //   start = 0;
    //   wait(ready);
    //   $display("Test Case 3: -3 * -3 = %d", $signed(product));  // Expected: 9
  
    //   // Test case 4: 7 * 7
    //   multiplier = 16'd7;
    //   multiplicand = 16'd7;
    //   start = 1;
    //   #10;
    //   start = 0;
    //   wait(ready);
    //   $display("Test Case 4: 7 * 7 = %d", $signed(product));  // Expected: 49
  
    //   // Test case 5: 0 * -10
    //   multiplier = 16'd0;
    //   multiplicand = -16'd10;
    //   start = 1;
    //   #10;
    //   start = 0;
    //   wait(ready);
    //   $display("Test Case 5: 0 * -10 = %d", $signed(product));  // Expected: 0
  
    //   // Test case 6: -10 * 0
    //   multiplier = -16'd10;
    //   multiplicand = 16'd0;
    //   start = 1;
    //   #10;
    //   start = 0;
    //   wait(ready);
    //   $display("Test Case 6: -10 * 0 = %d", $signed(product));  // Expected: 0
  
      // Finish simulation
      $stop;
    end
  
    // // Wait for the 'ready' signal
    // task wait(input logic ready_signal);
    //   while (!ready_signal) #10;
    // endtask
    initial begin
        $dumpfile("multiplier.vcd");
        $dumpvars(0);
    end
  endmodule
  