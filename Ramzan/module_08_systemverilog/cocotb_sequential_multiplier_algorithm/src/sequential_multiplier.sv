module sequential_multiplier(
    input logic CLK,
    input logic RST,
    input logic [15:0] A,
    input logic [15:0] B,
   //input logic START,
    input logic src_valid_in,   // Source to multiplier valid signal
    input logic dist_ready_out,   // Destination to multiplier ready signal
   // output logic READY,
    output logic dist_valid_out, // Multiplier to destination valid signal
    output logic src_ready_in,  // Multiplier to source ready signal
    output logic [31:0] PRODUCT
);


logic enable_A;
logic enable_B;
logic signed[15:0] reg_A;
logic signed [15:0] reg_B;
logic comp_sel;
logic a_sel;
logic CLEAR;
logic count_en;
logic clear_product;



logic [31:0] mux1_out;
logic [31:0] new_mux_out;
logic [3:0] count;
logic [3:0] D;
//logic [31:0] s_value;
logic [31:0] shift_out;
logic [31:0] finall_addition;
logic [31:0] reg_partial_product;


controller uut(
    .CLK(CLK),
    .RST(RST),
    .STOP(STOP),
    .b_val(b_val),
    //.START(START),
    .src_valid_in(src_valid_in),
    .dist_ready_out(dist_ready_out),
    .enable_A(enable_A),
    .enable_B(enable_B),
    .a_sel(a_sel),
    .comp_sel(comp_sel),
    .count_en(count_en),
    .clear_product(clear_product),
    .CLEAR(CLEAR),
    //.READY(READY)
    .dist_valid_out(dist_valid_out),
    .src_ready_in(src_ready_in)
);

assign STOP = (count == 4'd15);
assign b_val = reg_B[0];



always_ff @(posedge CLK or negedge RST) 
begin
    if(!RST)
    begin
        reg_A <= #1 0;
        reg_B <= #1 0;
    end
    else
    begin
        if(enable_A)
        begin
            reg_A <= #1 A;
        end

        if (enable_B)
        begin
            reg_B <= #1 B;
        end
        else
        begin
            reg_B <= #1 (reg_B>>1);
        end
    end
end

always_comb
begin
    if(a_sel)
    begin
        mux1_out = {{16{reg_A[15]}},reg_A};
    end
    else
    begin
        mux1_out = 32'b0;
    end
end


always_comb
begin
    if(comp_sel)
    begin
        new_mux_out = -(mux1_out);
    end
    else 
    begin
        new_mux_out = mux1_out;
    end
end

always_comb
begin
    D = (CLEAR) ? (4'd0) : (count+1);
end

always_ff @(posedge CLK or negedge RST) 
begin
    if(!RST)
    begin
        count <= #1 4'b0000;
    end
    else if(count_en)
    begin
        count <= #1 D;
    end
    else if (CLEAR)
    begin
        count <= #1 D;
    end
end

always_comb
begin
    shift_out = new_mux_out << count;
    finall_addition = shift_out + reg_partial_product;
end
// 32'b Register to store partial products

always_ff @(posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        reg_partial_product <= #1 0;
    end
    else if (clear_product)
    begin
        reg_partial_product <= #1 0;
    end
    else
    begin
        reg_partial_product <= #1 finall_addition;
    end
end

always_comb
begin
    if(dist_valid_out)
    begin
        PRODUCT = finall_addition;
    end
    else
    begin
        PRODUCT = 32'b0;
    end
end

endmodule





