/*******************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 01-08-2024
  +  Description : Implementation of restoring division algorithm, utilizing 
                   valid-ready (handshake) protocol.
*******************************************************************************/

module data_path (

//======================= Declearing Input And Outputs =======================//

    input    logic                 clk,
    input    logic                 rst,
    input    logic   [WIDTH-1:0]   dividend,
    input    logic   [WIDTH-1:0]   divisor,
    input    logic                 clear_bit,
    input    logic                 mux0_sel,
    input    logic                 mux1_sel,
    input    logic                 Q_0,
    input    logic                 enable,

    output   logic   [WIDTH-1:0]   remainder,
    output   logic   [WIDTH-1:0]   quotient,
    output   logic                 counter_signal,
    output   logic                 A_msb
);
//======================= Declearing Internal Signals ========================//

logic [$clog2(WIDTH)+1:0] counter;
logic [WIDTH-1:0] Q,  mux0_out; 
logic [WIDTH:0] M, A, subtractor_out , mux1_out;
logic [(2*WIDTH):0] combined_shift_A_Q;

//================================== Mux 0 ===================================//

assign mux0_out = (mux0_sel) ? {combined_shift_A_Q[WIDTH-1:1], Q_0} : dividend;

//================================== Mux 1 ===================================//

assign mux1_out = (mux1_sel) ? combined_shift_A_Q[(2*WIDTH)-1:WIDTH] : subtractor_out;

//============================== Left Shifting ===============================//

assign combined_shift_A_Q = {A[WIDTH-1:0], Q[WIDTH-1:0], 1'b0};

//================================ Subtractor ================================//

assign subtractor_out =  combined_shift_A_Q[(2*WIDTH):WIDTH] - M; 

//============================ Msb of Accumulator ============================//

assign A_msb = subtractor_out[WIDTH]; 

//=============================== Comparator =================================//

assign counter_signal = (counter == WIDTH+1) ? 1 : 0;

//================================ Registers =================================//

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        Q <= 0;
        M <= 0;
        A <= 0;
        counter <= 0;
    end

    else if (clear_bit == 1) begin
        Q <= 0;
        M <= 0;
        A <= 0;
        counter <= 0;
    end

    else begin          
        Q <= mux0_out;
        M <= divisor;
        A <= mux1_out;
        counter <= counter + 1;
    end
end

//========================== Quotient And Remainder ==========================//

always @(*) begin
    if (!rst) begin
        quotient = 0;
        remainder = 0;
    end else if (enable == 1) begin
        quotient = Q;
        remainder = A;
    end else if (enable == 0) begin
        quotient = quotient;
        remainder = remainder;
    end
end


endmodule
