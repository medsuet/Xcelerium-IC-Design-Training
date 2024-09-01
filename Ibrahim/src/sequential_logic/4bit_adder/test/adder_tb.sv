/* verilator lint_off LATCH */

module tb_sequential_adder(
    `ifdef VERILATOR
    input logic clk
    `endif
);

    // Testbench signals
    `ifndef VERILATOR
    logic clk;
    `endif
    logic reset;
    logic [3:0] number;
    logic output_lsb;

    // Instantiate the design under test (DUT)
    sequential_adder dut (
        .clk(clk),
        .reset(reset),
        .number(number),
        .output_lsb(output_lsb)
    );

    `ifndef VERILATOR
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    `endif

    // Task to apply reset
    task apply_reset();
        begin
            @(posedge clk);
            reset = 1;
            @(posedge clk);
            reset = 0;
        end
    endtask

    // Task to apply a test case
    task apply_test_case(input logic [3:0] test_number);
        begin
            number = test_number;
            repeat(4) @(posedge clk);  // Wait enough time for the FSM to process the number
        end
    endtask

    // Test sequence
    initial begin
        // Initialize signals
        `ifndef VERILATOR
        clk = 0;
        `endif
        reset = 0;
        number = 4'b0000;

        // Apply reset
        apply_reset();

        // Apply test cases using a for loop
        for (int i = 0; i < 16; i++) begin
            apply_test_case(i[3:0]);
        end

        // End of simulation
        $finish;
    end

    // Monitor the output
    initial begin
        $monitor("Time: %0t, Reset: %b, Number: %b, Output LSB: %b", $time, reset, number, output_lsb);
    end

    // Generate VCD file for waveform analysis
    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0);
    end

endmodule

/* verilator lint_on LATCH */