module sequential_multiplier (
    input logic clk, rst, src_valid, dest_ready,
    input logic [15:0] multiplier, multiplicand,
    output logic dest_valid, src_ready,
    output logic [31:0] product
);
logic mux0_sel, mux1_sel, mux2_sel, counter_signal,
        Q_1_bit, Q0_bit, clear_bit, alu_ctrl, product_en;

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
        .product_en(product_en),
        .alu_ctrl(alu_ctrl)
    );

    controller ctrl_unit(
        .clk(clk),
        .rst(rst),
        .clear_bit(clear_bit),

        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready),


        .Q0_bit(Q0_bit),
        .Q_1_bit(Q_1_bit),
        .counter_signal(counter_signal),
        .mux0_sel(mux0_sel),
        .mux1_sel(mux1_sel),
        .product_en(product_en),

        .alu_ctrl(alu_ctrl)
    );

endmodule