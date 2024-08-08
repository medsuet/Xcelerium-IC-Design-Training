module sequential_multiplier (
    input logic clk, rst, start_bit,
    input logic [15:0] multiplier, multiplicand,
    output logic ready_bit,
    output logic [31:0] product
);
logic mux0_sel, mux1_sel, mux2_sel, counter_en, counter_signal, Q_1_bit, Q0_bit, clear_bit, alu_ctrl;

    data_path data_path(
        .clk(clk),
        .rst(rst),
        .clear_bit(clear_bit),
        .multiplier(multiplier),
        .multiplicand(multiplicand),
        .product(product),
        .Q0_bit(Q0_bit),
        .Q_1_bit(Q_1_bit),
        .counter_signal(counter_signal),
        .mux0_sel(mux0_sel),
        .mux1_sel(mux1_sel),
        .mux2_sel(mux2_sel),
        .counter_en(counter_en),
        .alu_ctrl(alu_ctrl)
    );

    controller ctrl_unit(
        .clk(clk),
        .rst(rst),
        .clear_bit(clear_bit),
        .ready_bit(ready_bit),
        .start_bit(start_bit),
        .Q0_bit(Q0_bit),
        .Q_1_bit(Q_1_bit),
        .counter_signal(counter_signal),
        .mux0_sel(mux0_sel),
        .mux1_sel(mux1_sel),
        .mux2_sel(mux2_sel),
        .counter_en(counter_en),
        .alu_ctrl(alu_ctrl)
    );

endmodule