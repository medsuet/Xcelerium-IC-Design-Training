module tb_sequential_adder;
    logic clk;
    logic reset;
    logic [3:0] number;
    logic [3:0] sum;

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
        number = 0; reset = 0;
        $display("Time\tReset\tNumber\tControl_in");
        $monitor("%0d\t%b\t%b\t%b", $time, reset, number, uut.input_LSB);

        // Initialize signals
        @(posedge clk);
        reset = 1;
        
        @(posedge clk);
        number = 4'b1010; // Example input
        
        @(posedge clk);
        reset = 0;

        repeat(7) @(posedge clk);
        
        @(posedge clk);
        reset = 1;
        
        repeat(2)@(posedge clk);
        number = 4'b1001; // Example input
       
        @(posedge clk);
        reset = 0;
       
        repeat(7) @(posedge clk);

        @(posedge clk);
        reset = 1;
        
        repeat(2)@(posedge clk);
        number = 4'b1011; // Example input
        
        @(posedge clk);
        reset = 0;
       
        repeat(7) @(posedge clk);
        
        @(posedge clk);
        reset = 1;
       
        repeat(2)@(posedge clk);
        number = 4'b1111; // Example input
        
        @(posedge clk);
        reset = 0;
        
        repeat(7) @(posedge clk);

        // Finish simulation
        $finish;
    end

    initial begin
        // Create VCD file
        $dumpfile("tb_sequential_adder.vcd"); // Output file name
        $dumpvars(0, tb_sequential_adder);    // Dump all signals in the testbench
    end

endmodule