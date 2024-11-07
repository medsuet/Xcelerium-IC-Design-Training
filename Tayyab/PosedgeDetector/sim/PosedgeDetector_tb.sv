/*
    Name: PosedgeDetector_tb.sv
    Author: Muhammad Tayyab
    Date: 
    Description: Testbanch for PosedgeDetector_moore.sv and PosedgeDetector_mealy.sv
                 
    Parameters: SIGNAL      : input SIGNAL to both modules
                LENSIGNAL   : length of input signal

*/

module PosedgeDetector_tb();
    parameter SIGNAL = 8'b00111010;
    parameter LENSIGNAL = 8;

    logic clk, reset, signal_in, is_posedge_moore, is_posedge_mealy;
    
    PosedgeDetector_mealy mealy(clk, reset, signal_in, is_posedge_mealy);
    PosedgeDetector_moore moore(clk, reset, signal_in, is_posedge_moore);

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        reset_sequence();
        
        for (int i=(LENSIGNAL-1); i>=0; i--) begin
            signal_in = SIGNAL[i];
            @(posedge clk);
        end
        $finish();
    end

    task reset_sequence();
        reset = 1;
        #3;
        reset = 0;
    endtask

endmodule