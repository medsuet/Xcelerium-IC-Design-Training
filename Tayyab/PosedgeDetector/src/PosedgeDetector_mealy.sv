/*
    Name: PosedgeDetector_mealy.sv
    Author: Muhammad Tayyab
    Date: 
    Description: Detects input signal's transition from 0 to 1.
                 Mealy state machine implementation.

    Inputs: clk             : clock signal
            reset           : reset signal
            signal_in       : serial input signal
        
    Output: is_posedge      : =1 at transition of signal_in  from 0 to 1 for 1 clock cycle
                              =0 else
*/

module PosedgeDetector_mealy
(
    input logic clk, reset,
    input logic signal_in,
    output logic is_posedge
);

    parameter S0 = 0, S1 = 1;

    logic current_state, next_state;
    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state
    always_comb begin
        next_state = (signal_in) ? S1:S0;
    end

    // Output
    always_comb begin
        case (current_state)
            S0: is_posedge = signal_in;
            S1: is_posedge = 0;
        endcase
    end

endmodule
