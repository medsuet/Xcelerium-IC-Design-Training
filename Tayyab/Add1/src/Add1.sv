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
    parameter logic [1:0]LSB=0;         // First bit (LSB)
    parameter logic [1:0]CARRY0=1;      // Rest of bits & carry: 0
    parameter logic [1:0]CARRY1=2;      // Rest of bits & carry: 1

    // Store current state
    logic [1:0]current_state, next_state;
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= LSB;
        else
            current_state <= next_state; 
    end

    // Next state logic
    always_comb begin
        case (current_state)
            LSB: next_state = (input_bit) ? CARRY1:CARRY0;
            CARRY0: next_state = CARRY0;
            CARRY1: next_state = (input_bit) ? CARRY1:CARRY0;
            default: next_state = 2'bz;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            LSB: output_bit = (input_bit) ? 0:1 ;
            CARRY0: output_bit = (input_bit) ? 1:0 ;
            CARRY1: output_bit = (input_bit) ? 0:1 ;
            default: output_bit = 1'bz;
        endcase
    end
        
endmodule