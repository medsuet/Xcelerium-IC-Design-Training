module controller (
    input logic clk, rst, Q0_bit, Q_1_bit, counter_signal, src_valid, dest_ready,
    output logic mux0_sel, mux1_sel, alu_ctrl, clear_bit, dest_valid, src_ready, product_en
);
    logic [1:0] c_state, n_state;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            c_state <= S0;
        end
        else begin
            c_state <= n_state;
        end
    end

    always_comb begin
        case (c_state)
            S0: begin
                src_ready = 1;
                dest_valid = 0;
                mux1_sel = 0;
                mux0_sel = 0;
                product_en = 0;
                clear_bit = 1;

                if (src_valid == 0) begin
                    n_state = S0;
                end
                else if (src_valid == 1) begin
                    clear_bit = 0;
                    n_state = S1;
                end
            end

            S1: begin
                    dest_valid = 0;
                    src_ready = 0;
                    clear_bit = 0;
                    product_en = 0;
                    mux0_sel = 1;

                    if (counter_signal == 1 && dest_ready == 1) begin
                        dest_valid = 1;
                        product_en = 1;
                        n_state = S0;
                    end

                    else if (counter_signal == 1 && dest_ready == 0) begin
                        dest_valid = 1;
                        product_en = 1;
                        n_state = S2;
                    end

                    else if (counter_signal == 0) begin
                        dest_valid = 0;
                        n_state = S1;

                        case ({Q0_bit, Q_1_bit})
                            2'b00: begin
                                mux1_sel = 1'b0;
                            end
                            2'b11: begin
                                mux1_sel = 1'b0;
                            end
                            2'b10: begin
                                mux1_sel = 1'b1;
                                alu_ctrl = 1'b1;
                            end
                            2'b01: begin
                                mux1_sel = 1'b1;
                                alu_ctrl = 1'b0;
                            end
                        endcase
                    end
            end


            S2: begin
                src_ready = 0;
                dest_valid = 1;
                product_en = 0;
                clear_bit = 1; 

    
                if (dest_ready == 0) begin
                    n_state = S2;
                end
                else if (dest_ready == 1) begin                    
                    n_state = S0;
                end
            end
            default : begin
                n_state = S0;
            end 
        endcase
    end
endmodule

