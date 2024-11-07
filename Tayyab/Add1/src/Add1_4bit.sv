/*
    Name: Add1_4bit.sv
    Author: Muhammad Tayyab
    Date: 25-4-2024
    Description: Adds 1 to the input number. Input is 4 bit wide and given serially (bit by bit).             

    Inputs: clk          :clock signal
            reset        :reset signal
            input_bit    :current bit of input number  (number is input bitwise, stating from lsb)
            
    Output: output_bit   :current bit of output number (number is output bitwise, stating from lsb)
*/

module Add1_4bit
(
    input logic clk, reset,
    input logic input_bit,
    output logic output_bit
);

    // Define states
    typedef enum logic [2:0] 
    { 
        B0, B1C0, B1C1, B2C0, B2C1, B3C0, B3C1
    } type_add1_states_e;

    // Store current state
    type_add1_states_e current_state, next_state;
    
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= B0;
        else
            current_state <= next_state; 
    end

    // Next state logic
    always_comb begin
        case (current_state)
            B0:   next_state = (input_bit) ? B1C1:B1C0;
            B1C0: next_state = B2C0;
            B1C1: next_state = (input_bit) ? B2C1:B2C0;
            B2C0: next_state = B3C0;
            B2C1: next_state = (input_bit) ? B3C1:B3C0;
            B3C0: next_state = B0;
            B3C1: next_state = B0;
            default: next_state = B0;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            B1C0, B2C0, B3C0: output_bit = input_bit;
            B0, B1C1, B2C1, B3C1: output_bit = ~input_bit;
            default: output_bit = 1'bz; 
        endcase
    end
        
endmodule