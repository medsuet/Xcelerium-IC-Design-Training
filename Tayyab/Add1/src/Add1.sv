/*
    Name: Add1.sv
    Author: Muhammad Tayyab
    Date: 25-4-2024
    Description: Adds 1 to the input number. Input is given serially (bit by bit), and can be of any length.
                 Reset before inputting new number.

    Inputs: clk          :clock signal
            reset        :reset signal
            input_bit    :current bit of input number  (number is input bitwise, stating from lsb)
            
    Output: output_bit   :current bit of output number (number is output bitwise, stating from lsb)
*/

module Add1
(
    input logic clk, reset,
    input logic input_bit,
    output logic output_bit
);

    // Define states
    parameter logic CARRY0=0;      // Rest of bits & carry: 0
    parameter logic CARRY1=1;      // Rest of bits & carry: 1

    // Store current state
    logic current_state, next_state;
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= CARRY1;
        else
            current_state <= next_state; 
    end

    // Next state logic
    always_comb begin
        case (current_state)
            CARRY0: next_state = CARRY0;
            CARRY1: next_state = (input_bit) ? CARRY1:CARRY0;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            CARRY0: output_bit = (input_bit) ? 1:0 ;
            CARRY1: output_bit = (input_bit) ? 0:1 ;
        endcase
    end
        
endmodule