/* verilator lint_off LATCH */
module data_path (
    input logic clk, rst, clear_bit, mux0_sel, mux1_sel, alu_ctrl, product_en,
    input logic [15:0] multiplier,multiplicand,
    output logic [31:0] product,
    output counter_signal, Q_1_bit, Q0_bit
);

logic Q_0_bit, Q_1__bit;
logic [4:0] counter;
logic [15:0] Q, M, A, mux0_out, mux1_out, alu_out;
logic [31:0] combined_shift_A_Q;

//to controller
assign Q_1_bit = Q_1__bit;
assign Q0_bit = Q[0]; 

//mux 0
assign mux0_out = (mux0_sel) ? combined_shift_A_Q[15:0] : multiplier;

//mux 1
assign mux1_out = (mux1_sel) ? alu_out : A;

//alu
always_comb begin 
    case (alu_ctrl)
        0:
            alu_out = A + M;
        1: 
            alu_out = A - M;
    endcase
end

//shifting
assign combined_shift_A_Q = {mux1_out[15],mux1_out[15:0],Q[15:1]};

//comparator
assign counter_signal = (counter == 16) ? 1 : 0;

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
        A <=  combined_shift_A_Q[31:16];
        Q_1__bit <=  Q[0];
        counter <= counter + 1;
    end
end

//product
always_comb begin
    if (!rst) begin
        product = 0;
    end else if (product_en == 1) begin
        product = combined_shift_A_Q;
    end else if (product_en == 0) begin
        product = product;
    end
end
/* verilator lint_on LATCH */

endmodule


