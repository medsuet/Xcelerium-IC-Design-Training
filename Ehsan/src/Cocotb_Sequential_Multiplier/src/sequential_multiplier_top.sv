/********************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 07-08-2024
  +  Description : Testing sequential multiplier using Cocotb.
********************************************************************************/

module sequential_multiplier_top (

//======================= Declearing Input And Outputs =======================//

    input    logic                                  clk,
    input    logic                                  rst,
    input    logic                                  src_valid,
    input    logic                                  dest_ready,
    input    logic   signed   [MUL_WIDTH-1:0]       multiplicand,
    input    logic   signed   [MUL_WIDTH-1:0]       multiplier,

    output   logic   signed   [(2*MUL_WIDTH)-1:0]   product,
    output   logic                                  dest_valid, 
    output   logic                                  src_ready
);
//======================= Declearing Internal Signals ========================//

logic mux0_sel, mux1_sel, counter_signal, Q_1_bit, Q0_bit, clear_bit, alu_ctrl, product_en;

//=========================== Module Instantiation ===========================//

    data_path #(.MUL_WIDTH(MUL_WIDTH)) data_path(
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
//========================== Module Instantiation ============================//

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