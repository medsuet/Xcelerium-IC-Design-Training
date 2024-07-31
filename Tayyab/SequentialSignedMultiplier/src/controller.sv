/*
    Name: controller.sv
    Author: Muhammad Tayyab
    Date: 30-7-2024
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
typedef enum logic [1:0] { IDLE, INPUTDATA, CALCULATE, READY } type_states_e;

type_states_e current_state, next_state;

// Store current state
always_ff @(posedge clk, negedge reset) begin
    if (!reset)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

// Next state logic
always_comb 
begin
    case (current_state)
        IDLE: next_state = (valid_src) ? INPUTDATA : IDLE;
        INPUTDATA: next_state = CALCULATE;
        CALCULATE: next_state = (finish) ? READY : CALCULATE;
        READY: next_state = (ready_dst) ? IDLE : READY;
        default: next_state = IDLE;
    endcase
end

// Output logic
always_comb 
begin
    // Static values
    num_a_wr=1'b1;
    num_b_wr=1'b1;

    case (current_state)
        IDLE: 
            begin
                num_a_mux_sel=1'bx;
                num_b_mux_sel=1'bx;
                product_wr=1'b0;
                product_clear=1'b0;
                valid_dst=1'b0;
                ready_src=1'b1;
            end
        INPUTDATA: 
              begin
                num_a_mux_sel=1'b1;
                num_b_mux_sel=1'b1;
                product_wr=1'b1;
                product_clear=1'b1;
                valid_dst=1'b0;
                ready_src=1'b0;
              end
        CALCULATE: 
              begin
                num_a_mux_sel=1'b0;
                num_b_mux_sel=1'b0;
                product_wr=num_a_lsb;
                product_clear=1'b0;
                valid_dst=1'b0;
                ready_src=1'b0;
              end
        READY: 
            begin
                num_a_mux_sel=1'bx;
                num_b_mux_sel=1'bx;
                product_wr=1'b0;
                product_clear=1'b0;
                valid_dst=1'b1;
                ready_src=1'b0;
            end
    endcase
end


endmodule