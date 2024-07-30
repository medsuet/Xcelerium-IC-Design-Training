module tb_seq_multiplier;

  // Inputs
  logic signed [15:0] Multiplicand;
  logic signed [15:0] Multiplier;
  logic clk;
  logic rst;
  logic start;

  // Reference model output for expected result
  logic signed [31:0] exp;

  // Outputs
  logic ready;
  logic signed [31:0] Product;

  // Instantiate the Unit Under Test (UUT)
  seq_multiplier uut (
      .multiplicand(Multiplicand),
      .multiplier(Multiplier),
      .clk(clk),
      .rst_n(rst),
      .start(start),
      .ready(ready),
      .product(Product)
  );

  // Clock generation: Generate a clock signal with a period of 10 ns
  initial begin
      clk = 1;
      forever #5 clk = ~clk; // Toggle clock every 5 ns
  end

  // Dump file for waveform: Set up the dump file for waveform viewing
  initial begin
      $dumpfile("multiplier.vcd");
      $dumpvars(0, tb_seq_multiplier);
  end

  // Task for driving inputs: Apply the inputs to the UUT
  task drive_inputs(input logic signed [15:0] in1, input logic signed [15:0] in2);
      begin
          @(posedge clk);
          Multiplicand = in1;
          Multiplier = in2;
          start = 1;
          @(posedge clk);
          start = 0;
      end
  endtask

  // Task for monitoring outputs: Check the outputs against the expected results
  task monitor_outputs;
      begin
          wait (ready == 1); // Wait for the UUT to signal it is ready
          exp = Multiplicand * Multiplier; // Calculate the expected result
          if(exp != Product)begin
              $display("FAIL: A = %0d, B = %0d, P = %0d, E = %0d", Multiplicand, Multiplier, Product, exp);
          end
          else begin
              $display("PASS: A = %0d, B = %0d, P = %0d", Multiplicand, Multiplier, Product);
          end
      end
  endtask

  task reset_sequence();
    begin
      rst = 0;
      start = 0;
      @(posedge clk);
      rst = 1;
    end
  endtask

  // Stimulus process: Apply various test cases to the UUT
  initial begin
      // Initialize Inputs
      Multiplicand = 0;
      Multiplier = 0;
      
      reset_sequence();

      // Test case: Multiplication with 0
      drive_inputs(0, 0);
      monitor_outputs();
      drive_inputs(32767, 0);
      monitor_outputs();
      drive_inputs(-32768, 0);
      monitor_outputs();

      // Test case: Multiplication with 1
      drive_inputs(1, 1);
      monitor_outputs();
      drive_inputs(32767, 1);
      monitor_outputs();
      drive_inputs(-32768, 1);
      monitor_outputs();

      // Test case: Multiplication with negative numbers
      drive_inputs(-1, -1);
      monitor_outputs();
      drive_inputs(-32768, -1);
      monitor_outputs();
      drive_inputs(32767, -1);
      monitor_outputs();

      // Test case: Random Testing
      for(int i = 0; i < 16; i++) begin 
          // Non-random testing
          drive_inputs(0 + i, 10 + i); 
          monitor_outputs();
          // Random testing
          drive_inputs($random, $random); 
          monitor_outputs();
          @(posedge clk);
      end

      $finish;
  end
endmodule
