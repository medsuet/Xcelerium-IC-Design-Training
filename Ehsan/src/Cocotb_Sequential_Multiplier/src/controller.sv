/********************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 07-08-2024
  +  Description : Testing sequential multiplier using Cocotb.
********************************************************************************/

module controller (

//======================= Declearing Input And Outputs =======================//

    input    logic    clk,
    input    logic    rst,
    input    logic    Q0_bit,
    input    logic    Q_1_bit,
    input    logic    counter_signal,
    input    logic    src_valid,
    input    logic    dest_ready,
    
    output   logic    mux0_sel,
    output   logic    mux1_sel,
    output   logic    alu_ctrl,
    output   logic    clear_bit,
    output   logic    dest_valid,
    output   logic    src_ready,
    output   logic    product_en
);
//============================= State Machine ================================//

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
        endcase
    end
endmodule

