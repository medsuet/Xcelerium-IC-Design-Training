/*
    Name: controller.sv
    Author: Muhammad Tayyab
    Date: 5-8-2024
    Description: Controller for SequentialSignedMultiplier.sv
*/

module controller #(parameter NUMBITS)
(
 input logic clk, reset,
 
 input logic valid_src, ready_dst, 
 output logic valid_dst, ready_src,
 
 output logic num_a_wr, num_b_wr, num_a_mux_sel, num_b_mux_sel, product_wr, product_clear,
 input logic num_a_lsb, finish
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
    num_a_wr=1'b1;
    num_b_wr=1'b1;

    case (current_state)
        S0: 
            begin
                num_a_mux_sel = (valid_src) ? 1'b1 : 1'bx ;
                num_b_mux_sel = (valid_src) ? 1'b1 : 1'bx ;
                product_wr    = (valid_src) ? 1'b1 : 1'b0 ;
                product_clear = (valid_src) ? 1'b1 : 1'b0 ;
                valid_dst     = (valid_src) ? 1'b0 : 1'b0 ;
                //ready_src     = (valid_src) ? 1'b0 : 1'b1 ;
                ready_src     = 1'b1 ;
            end
        S1: 
            begin
                num_a_mux_sel = (finish) ? 1'bx : 1'b0 ;
                num_b_mux_sel = (finish) ? 1'bx : 1'b0 ;
                product_wr    = (finish) ? 1'b0 : num_a_lsb ;
                product_clear = (finish) ? 1'b0 : 1'b0 ;
                valid_dst     = (finish) ? 1'b1 : 1'b0 ;
                ready_src     = (finish) ? ready_dst : 1'b0 ;
            end
    endcase
end


endmodule