module tb_sequential_adder;
    logic clk;
    logic reset;
    logic [3:0] num;
    logic out;

    // Instantiate the sequential_adder
    sequential_adder uut (
        .clk(clk),
        .reset(reset),
        .num(num),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Clock period of 10 time units
    end

    // Task for reset sequence
    task reset_sequence;
        input integer delay; // Delay before releasing reset
        begin
            reset = 1;
            @(posedge clk); // Wait for one clock cycle
            repeat(delay) @(posedge clk); // Wait for specified delay
            reset = 0;
        end
    endtask

    // Test procedure
    initial begin
        num = 4'b0000;
        $display("Time\tReset\tNum\tSum");
        $monitor("%0d\t%b\t%b\t%b", $time, reset, num, out);

        // Apply reset sequence
        reset_sequence(5);

        @(posedge clk)
        // Loop through all possible 4-bit numbers
        for (int i = 0; i < 16; i++) begin
            num = i[3:0]; // Set num to the current value
            repeat(4) @(posedge clk); 
        end

        // Finish simulation
        $finish;
    end

    initial begin
        // Create VCD file
        $dumpfile("tb_sequential_adder.vcd"); // Output file name
        $dumpvars(0, tb_sequential_adder);    // Dump all signals in the testbench
    end

endmodule
