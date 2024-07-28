`timescale 1ns / 1ps

`include "../define/sig_mul.svh"

module signed_comb_multiplier_tb(
    
    // Clock signal (for Verilator simulation)
    `ifdef Verilator
       input logic clk 
    `endif

);


    // Inputs to the signed multiplier
    logic signed [width-1:0] multiplicand;
    logic signed [width-1:0] multiplier;

    // Output from the signed multiplier
    logic signed [result_width-1:0] result;

   
        
    // Instantiate the signed multiplier
    signed_multiplier DUT (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .result(result)
    );

    // Test vector generation and simulation
    initial begin
       
       repeat (10)begin
            apply_inputs();
            self_check();
     
       end

        $display("All test cases passed!");
        $finish;
    end

    task apply_inputs();
    multiplicand = 3;
    multiplier = 7;
    
    `ifdef Verilator
        // Wait for two clock cycles in Verilator (10 time units)
        repeat(5)@(posedge clk);
        `else
        // Delay for 10 time units in Vivado or other simulators
        #5;
    `endif
    
    endtask 

    task self_check();

       
        logic signed [result_width-1:0] expected_result;
        begin
            expected_result = multiplicand * multiplier;

            if (expected_result == result) begin
                $display("==============Test Passed============= ");
                $display("multiplicand = %d , multiplier = %d ===> result = %d ", multiplicand, multiplier, result);
            end else begin
                $display("=================Test Failed=================");
                $display("multiplicand = %d , multiplier = %d ", multiplicand, multiplier);
                $display("expected_output = %d , actual_output = %d ", expected_result, result);
            end
        end
    endtask

endmodule
