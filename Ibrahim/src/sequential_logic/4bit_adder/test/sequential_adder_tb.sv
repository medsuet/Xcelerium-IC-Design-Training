module tb_sequential_adder;
    logic clk;
    logic reset;
    logic [3:0] number;
    logic [3:0] sum;
    integer i;

    // Instantiate the sequential_adder
    sequential_adder uut (
        .clk(clk),
        .reset(reset),
        .number(number),
        .sum(sum)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test procedure
    initial begin
        $display("Time\tReset\tNumber\tControl_in");
        $monitor("%0d\t%b\t%b\t%b", $time, reset, number, uut.control_in);

        // Initialize signals
        reset = 0;
        number = 0;
        @(posedge clk);
        reset = 1;
        @(posedge clk);

        // Loop through numbers 0 to 15
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            reset = 0;
            number = i[3:0];  // Assign the value of i to the number input
            repeat(5) @(posedge clk);  // Wait for the sequential adder to complete
            @(posedge clk);
            reset = 1;
            @(posedge clk);
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
