module sequential_multiply (
    input logic CLK,                // Input Clock
    input logic signed [15:0] A,           // 16-bit Input A
    input logic signed [15:0] B,           // 16-bit Input B
    input logic src_valid,              // FSM Start Signal
    input logic dst_ready,
    input logic RESET,              // Active Low Asynchronous Reset
    output logic signed [31:0] product,    // Output product
    output logic src_ready,
    output logic dst_valid
);

logic en_A, en_B, en_prod;
logic b_val;
logic a_sel, sign_sel;
logic clear, prod_clear, count_en;
logic stop;

logic signed [15:0] reg_A;
logic signed [15:0] reg_B;
//logic [31:0] product;

logic [31:0] a_mux_out;
logic [31:0] sign_mux_out;
logic [3:0] count,D;            // counter data
logic [31:0] reg_partial_product;
logic [31:0] adder_out;
//logic [3:0] shift_val;
logic [31:0] shift_out;

assign b_val = reg_B[0];
assign stop = (count == 4'd15);

sequential_multiply_controller controller(
    .CLK(CLK),
    .RESET(RESET),
    .src_valid(src_valid),
    .dst_ready(dst_ready),
    .b_val(b_val),
    .stop(stop),
    .en_A(en_A),
    .en_B(en_B),
    .sign_sel(sign_sel),
    .a_sel(a_sel),
    .count_en(count_en),
    .clear(clear),
    .prod_clear(prod_clear),
    .en_prod(en_prod),
    .src_ready(src_ready),
    .dst_valid(dst_valid)
);


always_ff @(posedge CLK or negedge RESET)
begin
    // Active Low Asynchronous Reset
    if (!RESET)
    begin
        reg_A <= #1 0;
        reg_B <= #1 0;
    end
    else
    begin
        // Store A - DIRECT
        if (en_A)
        begin
            reg_A <= #1 A;
        end
        // Store B - MUX
        if (en_B)
        begin
            reg_B <= #1 B;                  // new B value
        end
        else
        begin
            reg_B <= #1 (reg_B >> 1);       // right shifted B value
        end
    end
end

// Reg_A Mux - Using a_sel
always_comb
begin
    if (a_sel)
        a_mux_out = { {16{reg_A[15]}} , reg_A };
    else
        a_mux_out = 32'h00000000;
end

// Sign Mux - Using sign_sel
always_comb
begin
    if (sign_sel)
        sign_mux_out = -(a_mux_out);        // 2's Compliment
    else
        sign_mux_out = a_mux_out;           // Directly equivalent
end

// Counter
always_comb
begin
    D = clear ? (4'd0) : (count + 1);
end

always_ff @(posedge CLK or negedge RESET)   
begin
    if (!RESET)
        count <= #1 0;
    else if (count_en)
        count <= #1 D;
    else if (clear)
        count <= #1 D;
end

// Ripple Carry Adder
always_comb
begin
    shift_out = sign_mux_out << count;
    adder_out = shift_out + reg_partial_product;
end

// 32'b Register to store partial products
always_ff @(posedge CLK or negedge RESET)
begin
    if (!RESET)
        reg_partial_product <= #1 0;
    else
        if (prod_clear)
            reg_partial_product <= #1 0;
        else if (en_prod)
            reg_partial_product <= adder_out;
end

// product output mux - uses dst_valid
always_comb
begin
    if (dst_valid)
        product = adder_out;
    else
        product = 32'h00000000;
end

endmodule