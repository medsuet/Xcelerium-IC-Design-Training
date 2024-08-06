/*
    Name: PosedgeDetector_moore.sv
    Author: Muhammad Tayyab
    Date: 
    Description: Detects input signal's transition from 0 to 1.
                 Moore state machine implementation.

    Inputs: clk             : clock signal
            reset           : reset signal
            signal_in       : serial input signal
        
    Output: is_posedge      : =1 at transition of signal_in from 0 to 1 for 1 clock cycle
                              =0 else
*/

module PosedgeDetector_moore
(
    input logic clk, reset,
    input logic signal_in,
    output logic is_posedge
);

    typedef enum logic [1:0] { S0, S1, S2 } type_state_e;

    type_state_e current_state, next_state;

    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state
    always_comb begin
        case (current_state)
            S0: next_state = (signal_in) ? S1:S0;
            S1: next_state = (signal_in) ? S2:S0;
            S2: next_state = (signal_in) ? S2:S0;
            default: next_state = S0;
        endcase
    end

    // Output
    always_comb begin
        case (current_state)
            S1: is_posedge = 1;
            default: is_posedge = 0;
        endcase
    end

endmodule
