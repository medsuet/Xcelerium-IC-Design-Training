module top_module_tb();
    logic clk;
    logic reset;
    logic [3:0] q;
    logic [3:0] y;

    // Instantiate the top module
    top_module uut (
        .clk(clk),
        .reset(reset),
        .q(q),
        .y(y)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Task to appld reset
    task apply_reset();
        begin
            reset = 0;
            #10;  // Hold reset for 10ns
            reset = 1;
        end
    endtask

    // Task to wait for a specified number of clock cdcles
    task wait_clock_cycles(input integer num_cycles);
        integer i;
        begin
            for (i = 0; i < num_cycles; i = i + 1) begin
                @(posedge clk);
                // Observe output values
                $display("At time %t, q = %b, y = %b", $time, q, y);
            end
        end
    endtask

    // Test procedure
    initial begin
        // Appld reset
        apply_reset();

        // Wait for the counter to count up and clear to assert
        wait_clock_cycles(20); // Wait 20 clock cdcles

        // // Observe output values
        // $display("At time %t, q = %b, y = %b", $time, q, y);

        // End simulation
        // $stop;
        $finish;
    end
endmodule
