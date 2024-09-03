/*********************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 27-7-2024
  +  Description : Implementation of sequential multiplier using booth algorithm.
*********************************************************************************/

module controller (

//======================= Declearing Input And Outputs =======================//

    input     logic     clk,
    input     logic     rst,
    input     logic     Q0_bit,
    input     logic     Q_1_bit,
    input     logic     counter_signal,
    input     logic     start_bit,

    output    logic     mux0_sel,
    output    logic     mux1_sel,
    output    logic     mux2_sel,
    output    logic     alu_ctrl,
    output    logic     counter_en,
    output    logic     ready_bit,
    output    logic     clear_bit
);
//============================= State Machine ================================//

    logic c_state, n_state;
    parameter idle = 0, multiplication = 1;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            c_state <= idle;
        end
        else begin
            c_state <= n_state;
        end
    end

    always_comb begin
        case (c_state)
            idle: begin
                mux2_sel = 0;
                alu_ctrl = 0;
                clear_bit = 1;
                if (start_bit == 0) begin
                    ready_bit = 0;
                    mux0_sel = 0;
                    n_state = idle;
                end

                else if (start_bit == 1) begin
                    clear_bit = 0;
                    ready_bit = 0;
                    mux0_sel = 0;
                    mux1_sel = 0;
                    counter_en = 1;
                    n_state = multiplication;
                end
            end

            multiplication: begin
                if (counter_signal == 1) begin
                    mux2_sel = 1;
                    ready_bit = 1;
                    clear_bit = 1;
                    counter_en = 0;
                    n_state = idle;
                end

                else if (counter_signal == 0) begin
                    ready_bit = 0;
                    clear_bit = 0;
                    mux0_sel = 1;
                    counter_en = 1;
                    n_state = multiplication;
                    if (Q0_bit == 1'b0 && Q_1_bit == 1'b0) begin
                        mux1_sel = 1'b0;
                    end else if (Q0_bit == 1'b1 && Q_1_bit == 1'b1) begin
                        mux1_sel = 1'b0;
                    end else if (Q0_bit == 1'b1 && Q_1_bit == 1'b0) begin
                        mux1_sel = 1'b1;
                        alu_ctrl = 1'b1;
                    end else if (Q0_bit == 1'b0 && Q_1_bit == 1'b1) begin
                        mux1_sel = 1'b1;
                        alu_ctrl = 1'b0;
                    end
                end
            end
        endcase
    end
endmodule