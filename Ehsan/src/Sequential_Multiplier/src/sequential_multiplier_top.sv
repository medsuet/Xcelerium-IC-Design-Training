/*********************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 27-7-2024
  +  Description : Implementation of sequential multiplier using booth algorithm.
*********************************************************************************/

module sequential_multiplier (

//======================= Declearing Input And Outputs =======================//

    input   logic                                 clk,
    input   logic                                 rst,
    input   logic   signed  [MUL_WIDTH-1:0]       multiplicand,
    input   logic   signed  [MUL_WIDTH-1:0]       multiplier,
    input   logic                                 start_bit,
    output  logic                                 ready_bit,
    output  logic   signed  [(2*MUL_WIDTH)-1:0]   product
);
//======================= Declearing Internal Signals ========================//

    logic  mux0_sel, mux1_sel, mux2_sel, counter_en, counter_signal;
    logic  Q_1_bit, Q0_bit, clear_bit, alu_ctrl;

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
        .mux2_sel(mux2_sel),
        .counter_en(counter_en),
        .alu_ctrl(alu_ctrl)
    );
//=========================== Module Instantiation ===========================//

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