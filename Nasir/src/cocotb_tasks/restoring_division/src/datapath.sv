// datapath datapath_design (.dividend(dividend),
//                           .divisor(divisor),
//                           .clk(clk),
//                           .reset(reset),
//                           .select_aq(select_aq),
//                           .enable(enable),
//                           .update_quotient(update_quotient),
//                           .ready(ready),
//                           count_16(count_16),
//                           .msb_remainder(msb_remainder),
//                           .remainder(remainder),
//                           .quotient(quotient));

module datapath (
    input logic [15:0] dividend,
    input logic [15:0] divisor,
    input logic clk,
    input logic reset,
    input logic select_aq,
    input logic enable,
    input logic update_quotient,
    input logic ready,
    output logic count_16,
    output logic msb_remainder,
    output logic [15:0] remainder,
    output logic [15:0] quotient
);

// register for remainder
logic [16:0] a, a_in; // remainder
logic [15:0] q;  // quotient
logic [16:0] m; // divisor
logic [15:0] dividend_out, dividend_in; // dividend
logic [15:0] restored_a;
logic [4:0] counter;
logic [32:0] remainder_dividend;
logic [32:0] shifted_remainder_dividend;
logic [16:0] a_updated;
logic [16:0] a_new;
always_ff @( posedge clk or negedge reset ) begin : remainder_reg
    if (!reset | !enable) begin
        a <=  17'b0;
    end
    // else if (enable & update_quotient) begin
    //     // restore a or remainder
    //     a <=  restored_a;
    // end
    else begin
        a <=  restored_a;
    end
end
// restore a 
// assign restored_a = a;

// dividend register

always_ff @( posedge clk or negedge reset ) begin : dividend_reg
    if (!reset | !enable) begin
        dividend_out <=  16'b0; 
    end
    else begin
        dividend_out <=  dividend_in;
    end
end

// divisor register

always_ff @( posedge clk or negedge reset ) begin : divisor_reg
    if (!reset | !enable) begin
        m <=  17'b0;
    end
    else begin
        m <=  divisor; 
    end
end

// quotient 
always_ff @( posedge clk or negedge reset ) begin : quotient_reg
    if (!reset | !enable) begin
        q <= 16'b0;
    end
    else if (update_quotient) begin
        q <=  q << 1;
        // q[0] <=  1'b0;
    end
    else begin
        q <=  q << 1;
        q[0] <=  1'b1;
    end
end

// counter

always_ff @( posedge clk or negedge reset ) begin 
    if (!reset | !enable) begin
        counter <=  5'b0; 
    end
    else begin
        counter <=  counter +1;
    end
end

always_comb begin : cancatenate_AQ_and_shift_left
    // cancatenate remainder(a) and dividend(dividend_out)

    remainder_dividend = {a, dividend_out};

    // left shift AQ, remainder(a) and dividend(dividend_out)
    shifted_remainder_dividend = remainder_dividend << 1;   
end

// extract a and extract msb of remainder
always_comb begin 
    a_new = shifted_remainder_dividend[32:16];
    a_updated = a_new - m;
end

// mux's for remainder(a) and dividend(dividend_out) and count16

always_comb begin 
    a_in = select_aq ? a_updated : 17'b0;
    dividend_in = select_aq ? shifted_remainder_dividend[15:0]: dividend;
    // if (a_updated[3]) begin
    //     dividend_in[0] = 1'b0;
    // end
    // else begin
    //     // dividend_in << 1;
    //     dividend_in[0] = 1'b1;
    // end
        
end 

assign restored_a = msb_remainder ? a_new : a_in;

// output signals 

always_comb begin 
    // remainder msb 
    msb_remainder = a_updated[16];
    // count 15
    count_16 = (counter == 17) ? 1 :0;
    if (ready) begin
        // remainder
        remainder = a;
        // quotient 
        quotient = q;
    end

end

endmodule