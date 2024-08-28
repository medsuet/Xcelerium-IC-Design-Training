`timescale 1ns / 1ps

module counter_tb();

    reg clk, reset;
    wire [3:0] value;
    wire counter_clr;

    Counter DUT (
        .clk(clk),
        .reset(reset),
        .value(value),
        .counter_clr(counter_clr)
    );

    // Clock Generator
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Test Sequence
    initial begin
        // Apply reset
        reset_sequence();
        
        // Observe the output
        repeat(20) @(posedge clk);
        $finish;
    end

    task reset_sequence;
        begin
            reset = #1  1'b1;
            @(posedge clk);
            reset = #1 1'b0;
            @(posedge clk);
            reset = #1 1'b1;
        end
    endtask

endmodule
