module sequential_adder_tb;
    // Parameters
    parameter WIDTH = 4;

    // Testbench signals
    logic clk;
    logic reset;
    logic [WIDTH-1:0] number;
    logic [WIDTH-1:0] result;
    logic [WIDTH -1:0] reference;

    // Instantiate the Device Under Test (DUT)
    sequential_adder dut (
        .number(number),
        .result(result),
        .reset(reset),
        .clk(clk)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period: 10 time units
    end

    // Test sequence
    initial begin
        // Initial values
        // number = 4'b0000;
        reset =  1'b1;

        // Apply reset
        #10 reset =  1'b0;

        // Test different numbers
        for (integer i = 0; i < 16; i = i + 1) begin
            number =  i;
            #50; // Ensure to wait for enough clock cycles to process the number
            // reset = 1'b1;
            // #10 reset = 1'b0;
            // reference 
            reference = number + 1;
            // Display results
            $display("Number = %b, Result = %b, reference result = %b", number, result, reference);
            if (result == reference) begin
                $display("Test %0d Passed", i);
            end
            else begin
                $display("Test %0d Failed", i);
            end
        end

        // Finish simulation
        $finish;
    end
endmodule
