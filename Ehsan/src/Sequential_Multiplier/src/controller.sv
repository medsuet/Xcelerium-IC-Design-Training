module controller (
    input logic clk, rst, Q0_bit, Q_1_bit, counter_signal, start_bit,
    output logic mux0_sel, mux1_sel, mux2_sel, alu_ctrl, counter_en, ready_bit, clear_bit
);
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
                if (start_bit == 0) begin
                    clear_bit = 1;
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
                        alu_ctrl = 1'b0;
                    end else if (Q0_bit == 1'b1 && Q_1_bit == 1'b1) begin
                        mux1_sel = 1'b0;
                        alu_ctrl = 1'b0;
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