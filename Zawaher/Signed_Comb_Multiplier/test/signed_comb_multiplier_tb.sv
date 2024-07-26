`timescale 1ns / 1ps

`include "sig_mul.svh"

module signed_multiplier_tb;


    // Inputs to the signed multiplier
    logic signed [width-1:0] multiplicand;
    logic signed [width-1:0] multiplier;

    // Output from the signed multiplier
    logic signed [result_width-1:0] result;

    // Instantiate the signed multiplier
    signed_multiplier #(width, result_width) DUT (
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

    multiplicand = $random;
    multiplier = $random;
    #10;
        
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
