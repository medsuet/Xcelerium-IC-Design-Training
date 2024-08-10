/* verilator lint_off LATCH */
module data_path (

//======================= Declearing Input And Outputs =======================//

    input    logic            clk, rst, clear_bit, mux0_sel, mux1_sel, Q_0, enable,
    input    logic   [15:0]   dividend, divisor,
    output   logic   [15:0]   remainder, quotient,
    output   logic            counter_signal, A_msb
);
//======================= Declearing Internal Signals ========================//

logic   [4:0]    counter;
logic   [15:0]   Q,  mux0_out; 
logic   [16:0]   M, A, subtractor_out , mux1_out;
logic   [32:0]   combined_shift_A_Q;

//================================== Mux 0 ===================================//

assign mux0_out = (mux0_sel) ? {combined_shift_A_Q[15:1], Q_0} : dividend;

//================================== Mux 1 ===================================//

assign mux1_out = (mux1_sel) ? combined_shift_A_Q[32:16] : subtractor_out;

//================================= Shifting =================================//

assign combined_shift_A_Q = {A[15:0], Q[15:0], 1'b0};

//================================ Subtractor ================================//

assign subtractor_out =  combined_shift_A_Q[31:16] - M; 

//============================= Taking Msb of A ==============================//

assign A_msb = subtractor_out[16]; 

//================================= Counter ==================================//

assign counter_signal = (counter == 17) ? 1 : 0;

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
        A <=  mux1_out;
        counter <= counter + 1;
    end
end

//========================= Quotient And Remainder ===========================//

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

/* verilator lint_on LATCH */
endmodule
