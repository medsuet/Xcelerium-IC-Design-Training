/*
    Name: Counter.sv
    Author: Muhammad Tayyab
    Date: 24-7-2024
    Description: <NUMBITS> wide up-counter. Counts up from 0 UBOUND times.
                 Resets when count == UBOUND-1, or at rising reset signal.

    Inputs: 1'b clk: clock signal.
            1'b reset: asynchronous reset signal. sets count to zero.
            
    Output: <NUMBITS>'b count: current value of counter.

    Parameters: NUMBITS: number of bits (width) of counter.
                UBOUND: maximum value the counter will count before reseting.
*/

module Counter #(parameter NUMBITS, parameter UBOUND)
(
    input logic clk, reset,
    output logic [(NUMBITS-1):0]count
);

    always_ff @(posedge clk, posedge reset)
    begin
        if (reset)
            count <= 0;
        else if (count == (UBOUND-1))
            count <= 0;
        else
            count <= count + 1;
    end

endmodule