module tb_counter_4bit;

    // Testbench signals
    logic clk;
    logic reset;
    logic [3:0] count;

    // Instantiation
    counter_4bit uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test Case
    initial begin
        // Initialize signals
        reset = 0;

        // Apply initial reset
        $display("Applying reset");
        #5
        reset = 1;
        #5;  
        reset = 0;

        // After reset
        $display("After reset");
        repeat (17) @(posedge clk); // Run for 20 clock cycles
        
        $finish; // End simulation
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0t, reset = %b, count = %b", $time, reset, count);
    end

     // Generate waveform 
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb_counter_4bit);
    end

endmodule
