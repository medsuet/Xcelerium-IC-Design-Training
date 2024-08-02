module tb_counter_0_to_13;

    // Inputs
    logic clk;
    logic rst;
    // Outputs
    logic [3:0] count;
    logic clear;


    counter_0_to_13 dut (
        .clk(clk),
        .rst(rst),
        .count(count),
        .clear(clear)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        #10 rst = 0; // Release reset

        //For Monitoring output
        $monitor("At time %t, count = %d", $time, count);

        //after
        #200;

        #100;

        // Finish simulation
        $finish;
    end
    

    initial
    begin
        $dumpfile("counter.vcd");
        $dumpvars(0, dut);
    end

    

endmodule
