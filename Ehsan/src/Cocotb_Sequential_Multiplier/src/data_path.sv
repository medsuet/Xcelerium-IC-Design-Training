/********************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 07-08-2024
  +  Description : Testing sequential multiplier using Cocotb.
********************************************************************************/

module data_path (

//======================= Declearing Input And Outputs =======================//

    input    logic                                  clk, 
    input    logic                                  rst, 
    input    logic                                  clear_bit,
    input    logic                                  mux0_sel,
    input    logic                                  mux1_sel, 
    input    logic                                  alu_ctrl,
    input    logic                                  product_en,
    input    logic   signed   [MUL_WIDTH-1:0]       multiplicand,
    input    logic   signed   [MUL_WIDTH-1:0]       multiplier,

    output   logic   signed   [(2*MUL_WIDTH)-1:0]   product,
    output   logic                                  counter_signal,
    output   logic                                  Q_1_bit,
    output   logic                                  Q0_bit
);
//======================= Declearing Internal Signals ========================//

logic                             Q_0_bit, Q_1__bit;
logic   [$clog2(MUL_WIDTH)+1:0]   counter;
logic   [MUL_WIDTH-1:0]           Q, M, A, mux0_out, mux1_out, alu_out;
logic   [(2*MUL_WIDTH)-1:0]       combined_shift_A_Q;

//===================== Q(0) And Q(-1) Bit Of Multiplier =====================//

assign Q_1_bit = Q_1__bit;
assign Q0_bit = Q[0]; 

//================================== Mux 0 ===================================//

assign mux0_out = (mux0_sel) ? combined_shift_A_Q[MUL_WIDTH-1:0] : multiplier;

//================================== Mux 1 ===================================//

assign mux1_out = (mux1_sel) ? alu_out : A;

//=================================== ALU ====================================//

always_comb begin 
    case (alu_ctrl)
        0:
            alu_out = A + M;
        1: 
            alu_out = A - M;
    endcase
end

//============================== Right Shifting ==============================//

assign combined_shift_A_Q = {mux1_out[MUL_WIDTH-1],mux1_out[MUL_WIDTH-1:0],Q[MUL_WIDTH-1:1]};

//=============================== Comparator =================================//

assign counter_signal = (counter == MUL_WIDTH) ? 1 : 0;

//================================ Registers =================================//

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        Q <= 0;
        M <= 0;
        A <= 0;
        Q_1__bit <= 0;
        counter <= 0;
    end

    else if (clear_bit == 1) begin
        Q <= 0;
        M <= 0;
        A <= 0;
        Q_1__bit <= 0;
        counter <= 0;
    end

    else begin          
        Q <= mux0_out;
        M <= multiplicand;
        A <=  combined_shift_A_Q[(2*MUL_WIDTH)-1:MUL_WIDTH];
        Q_1__bit <=  Q[0];
        counter <= counter + 1;
    end
end

//================================= Product ==================================//

always @(*) begin
    if (!rst) begin
        product = 0;
    end else if (product_en == 1) begin
        product = combined_shift_A_Q;
    end else if (product_en == 0) begin
        product = product;
    end
end


endmodule


