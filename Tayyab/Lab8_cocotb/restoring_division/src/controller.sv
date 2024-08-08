/*
    Name: controller.sv
    Author: Muhammad Tayyab
    Date: 8-8-2024
    Description: Controller for restoring_division.sv
*/

module controller
(
 input logic clk, reset,
 
 input logic valid_src, ready_dst, 
 output logic valid_dst, ready_src,
 
 output logic input_data, a_en, q_en, counter_clear,
 input logic finish
);

// Define states
typedef enum logic { S0, S1 } type_states_e;

type_states_e current_state, next_state;

// Store current state
always_ff @(posedge clk, negedge reset) begin
    if (!reset)
        current_state <= S0;
    else
        current_state <= next_state;
end

// Next state logic
always_comb 
begin
    case (current_state)
        S0: next_state = (valid_src) ? S1 : S0;
        S1: next_state = (finish && ready_dst) ? S0 : S1;
        default: next_state = S0;
    endcase
end

// Output logic
always_comb 
begin
    // Static values

    case (current_state)
        S0: 
            begin
                input_data = 1'b1;
                a_en       = (valid_src);
                q_en       = (valid_src);
                counter_clear = 1'b1;
                valid_dst  = 1'b0;
                ready_src  = 1'b1;
            end
        S1: 
            begin
                input_data = 1'b0;
                a_en      = ~(finish);
                q_en      = ~(finish);
                counter_clear = 1'b0;
                valid_dst  = (finish);
                ready_src  = (finish && ready_dst);
            end
    endcase
end


endmodule