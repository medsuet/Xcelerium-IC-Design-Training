module tb_counter;

    // Testbench signals
    logic clk;
    logic reset;
    logic [3:0] count;

    // Instantiate the counter_4bit module
    counter uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 0; // Initialize clock to 0
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end
    
    task apply_reset;
        reset = 1; // Assert reset
        #50;       // Hold reset for 10 time units
        reset = 0; // Deassert reset
    endtask

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;

        apply_reset;

        // Wait for a few clock cycles and observe count value
        #5;

        // Apply a few clock cycles
        $display("Starting clock cycles...");
        repeat (20) @(posedge clk); // Run for 20 clock cycles

        // Run for a few more clock cycles and observe count value
        #20;

        // End simulation
        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0t, reset = %b, count = %b", $time, reset, count);
    end

endmodule
