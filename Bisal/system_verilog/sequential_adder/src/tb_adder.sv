module adder_tb;
    reg clk;
    reg reset;
    reg b;
    wire s;
    
    adder uut (
        .clk(clk),
        .reset(reset),
        .b(b),
        .s(s)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // Test sequence
    initial begin
        integer i;
        reg [3:0] test_input;
        reset = 1;
        b = 0;
        reset = 0;  
        @(posedge clk)
        reset = 1;
        @(posedge clk)
        for (i = 0; i < 16; i = i + 1) begin
            test_input = i;
            // Send each bit of the test_input one by one
            b = test_input[0]; @(posedge clk);
            b = test_input[1]; @(posedge clk);
            b = test_input[2]; @(posedge clk);
            b = test_input[3]; @(posedge clk);
        end
        #10 $stop; 
    end
endmodule
