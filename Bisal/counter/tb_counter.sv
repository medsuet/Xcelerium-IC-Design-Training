module tb_counter;
    // Declare signals using logic
    logic clk;
    logic reset;
    logic clear;
    logic [3:0] count;

    // Instantiate the counter module
    counter UUT (
        .clk(clk),
        .reset(reset),
	    .clear(clear),
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // Initialize input and reset
    initial begin
        // Initially, apply reset
        reset = 1;
        #10;
        reset = 0;
	//repeat(200)@(posedge clk);
	#200;
        // End simulation
        $stop;
    end

endmodule
