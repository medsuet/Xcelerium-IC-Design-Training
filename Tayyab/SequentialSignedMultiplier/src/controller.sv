/*
    Name: controller.sv
    Author: Muhammad Tayyab
    Date: 30-7-2024
    Description: Controller for SequentialSignedMultiplier.sv
*/

module controller #(parameter NUMBITS)
(
 input logic clk, reset, start,
 output logic ready,
 
 output logic numA_wr, numB_wr, numA_mux_sel, numB_mux_sel, product_wr, product_clear,
 input logic numA_lsb, finish
);

// Define states
typedef enum logic [1:0] { Idle, InputData, Calculate, Ready } type_states_e;

type_states_e current_state, next_state;

// Store current state
always_ff @(posedge clk, negedge reset) begin
    if (!reset)
        current_state <= Idle;
    else
        current_state <= next_state;
end

// Next state logic
always_comb 
begin
    case (current_state)
        Idle: next_state = (start) ? InputData : Idle;
        InputData: next_state = Calculate;
        Calculate: next_state = (finish) ? Ready : Calculate;
        Ready: next_state = Idle;
        default: next_state = Idle;
    endcase
end

// Output logic
always_comb 
begin
    case (current_state)
        Idle: 
            begin
                numA_wr=1'bx;
                numB_wr=1'bx;
                numA_mux_sel=1'bx;
                numB_mux_sel=1'bx;
                product_wr=1'b0;
                product_clear=1'b0;
                ready=1'b0;
            end
        InputData: 
              begin
                numA_wr=1'b1;
                numB_wr=1'b1;
                numA_mux_sel=1'b1;
                numB_mux_sel=1'b1;
                product_wr=1'b1;
                product_clear=1'b1;
                ready=1'b0;
              end
        Calculate: 
              begin
                numA_wr=1'b1;
                numB_wr=1'b1;
                numA_mux_sel=1'b0;
                numB_mux_sel=1'b0;
                product_wr=numA_lsb;
                product_clear=1'b0;
                ready=1'b0;
              end
        Ready: 
            begin
                numA_wr=1'bx;
                numB_wr=1'bx;
                numA_mux_sel=1'bx;
                numB_mux_sel=1'bx;
                product_wr=1'b0;
                product_clear=1'b0;
                ready=1'b1;
            end
    endcase
end


endmodule