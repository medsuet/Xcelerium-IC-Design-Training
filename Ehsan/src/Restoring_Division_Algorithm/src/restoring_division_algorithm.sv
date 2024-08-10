/*******************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 01-08-2024
  +  Description : Implementation of restoring division algorithm, utilizing 
                   valid-ready (handshake) protocol.
*******************************************************************************/

module restoring_division_top (

//======================= Declearing Input And Outputs =======================//

    input    logic                 clk,
    input    logic                 rst,
    input    logic                 src_valid,
    input    logic                 dest_ready,
    input    logic   [WIDTH-1:0]   dividend,
    input    logic   [WIDTH-1:0]   divisor,

    output   logic                 dest_valid,
    output   logic                 src_ready,
    output   logic   [WIDTH-1:0]   quotient,
    output   logic   [WIDTH-1:0]   remainder
);

//======================= Declearing Internal Signals ========================//

logic mux0_sel, mux1_sel, counter_signal, Q_0, A_msb, clear_bit, enable;

//=========================== Module Instantiation ===========================//

    data_path #(.WIDTH(WIDTH)) data_path(
        .clk(clk),
        .rst(rst),
        .clear_bit(clear_bit),
        .counter_signal(counter_signal),
        .mux0_sel(mux0_sel),
        .mux1_sel(mux1_sel),
        .Q_0(Q_0),
        .A_msb(A_msb),
        .enable(enable),
        .dividend(dividend),
        .divisor(divisor),
        .remainder(remainder),
        .quotient(quotient)     
    );
//=========================== Module Instantiation ===========================//

    controller ctrl_unit(
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready),
        .clear_bit(clear_bit),
        .A_msb(A_msb),
        .counter_signal(counter_signal),
        .mux0_sel(mux0_sel),
        .mux1_sel(mux1_sel),
        .Q_0(Q_0),
        .enable(enable)
    );

endmodule