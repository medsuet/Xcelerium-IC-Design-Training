
`include "../define/array_mul.svh"

module array_multiplier_datapath (
    input logic clk,
    input logic reset,
    input logic start_tx,
    input logic counted_15,
    input logic [width-1:0] multiplier,
    input logic [width-1:0] multiplicand,
    output logic counted,
    output logic get_output,
    output logic [result_width-1:0] product
);

logic piso_out;
logic [width-1:0] sixteen_bit_muxout;
logic [result_width-1:0] pipo_out;
logic [result_width-1:0] sign_extented, twos_compliment, thirtytwo_bit_muxout, shifted_out;
logic [3:0] counter_value; // Assuming 4-bit counter
logic [result_width-1:0] carry, sum;

piso #(.width(width))PISO (
    .clk(clk),
    .reset(reset),
    .multiplier(multiplier),
    .start_tx(start_tx),
    .out(piso_out)
);

mux #(.width(width)) Sixteen_bit_Mux (
    .a(0),
    .b(multiplicand),
    .sel(piso_out),
    .out(sixteen_bit_muxout)
);

// 32 bit sign extension
always_comb begin
    sign_extented = {{(result_width - width){sixteen_bit_muxout[width-1]}}, sixteen_bit_muxout};
end

// Two's Complement
always_comb begin 
    twos_compliment = (~sign_extented) + 1;
end

mux #(.width(result_width)) thirtytwo_bit_Mux (
    .a(sign_extented),
    .b(twos_compliment),
    .sel(counted_15),
    .out(thirtytwo_bit_muxout)
);

// Left shifting
always_comb begin 
    shifted_out = thirtytwo_bit_muxout << counter_value;
end

// 32-bit Carry Adder
generate
    genvar i;
    for (i = 0; i < result_width; i++) begin : gen_adders
        if (i == 0) begin
            full_adder FA(
                .a(shifted_out[i]),
                .b(pipo_out[i]),
                .cin(1'b0),
                .sum(sum[i]),
                .carry(carry[i])
            );
        end else begin
            full_adder FA(
                .a(shifted_out[i]),
                .b(pipo_out[i]),
                .cin(carry[i-1]),
                .sum(sum[i]),
                .carry(carry[i])
            );
        end
    end
endgenerate




pipo #(.width(result_width)) PIPO (
    .clk(clk),
    .reset(reset),
    .counted_15(counted_15),
    .in(sum),
    .get_output(get_output),
    .out(pipo_out)
);

//Shows the product when get_output signal becomes one
always_comb begin 
    if (get_output == 1)begin
        product = pipo_out;
        
    end
    else begin
        product = 'h0;
    end
end

// Zero sum and carry when get_output is high
always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        sum <= 'h0;
        carry <= 'h0;
    end else if (get_output) begin
        sum <= 'h0;
        carry <= 'h0;
    end
end


counter counter_instance (
    .clk(clk),
    .reset(reset),
    .start_tx(start_tx),
    .counted(counted),
    .counter_value(counter_value) // Assuming 4-bit counter
);

endmodule


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module pipo #(
    parameter width = 32 // Default width, can be set during instantiation
)(
    input logic     clk,reset,
    input logic     counted_15,
    input logic     [width-1:0]in,
    output logic    get_output,
    output logic    [width-1:0]out 
);

always_ff @( posedge clk or negedge reset ) begin 

    if (!reset)begin
        get_output <= 'h0;
        out <= 'h0;
    end
    else begin
        if (counted_15)begin
            get_output <= 1'b1;
            out <= in;
        end

        else begin
            out <= in ;
            get_output <= 1'b0;
        end
    end
    
end
    
endmodule


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module piso #(
    parameter width = 16 // Default width, can be set during instantiation
)(
    input logic clk,
    input logic reset,
    input logic [width-1:0] multiplier,
    input logic start_tx,
    output logic out 
);

logic [width-1:0] q;
logic shifting; // State flag to indicate ongoing shifting

always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        q <= 'h0;
        out <= 'h0;
        shifting <= 1'b0;
    end else if (start_tx) begin
        if (!shifting) begin
            q <= multiplier; // Load the multiplier
            out <= multiplier[0]; // Output the LSB immediately
            shifting <= 1'b1; // Start shifting
        end else begin
            q <= q >> 1; // Shift right
            out <= q[1]; // Output the next LSB
        end
    end else begin
        shifting <= 1'b0; // Stop shifting when start_tx is not asserted
        out <= 'h0; // Default output when not shifting
    end
end

endmodule


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// MUX 
module mux #(
    parameter width = 16 // Default width, can be set during instantiation
)(
    input logic     [width-1:0]a,b,
    input logic     sel,
    output logic    [width-1:0]out
);

always_comb begin 

    case (sel)
        
       1'b0 : out = a;
       1'b1 : out = b;

        default: out = 'hx;

    endcase
    
end

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module counter (
    input logic     clk,
    input logic     reset,
    input logic     start_tx,
    output logic    counted,
    output logic    [3:0] counter_value // Assuming 4-bit counter
);

logic [3:0] counter; // 4-bit counter register
logic start_flag;    // Flag to indicate counting has started

always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        counter <= 4'b0;
        counter_value <= 4'b0;
        counted <= 1'b0;
        start_flag <= 1'b0;
    end else begin
        if (start_tx && !start_flag) begin
            // Start counting immediately when start_tx is asserted
            counter <= 4'b0; // Reset counter to 0
            counter_value <= counter;
            counter <= counter+1;
            start_flag <= 1'b1; // Set flag to indicate counting has started
            counted <= 1'b0;
        end else if (start_flag) begin
            if (counter == 4'b1111) begin
                counted <= 1'b1;
                counter_value <= counter;
                start_flag <= 1'b0; // Reset start flag after counting completes
                counter <= 'h0;
            end else begin
                counter <= counter + 1; // Increment counter by one
                counter_value <= counter;
                counted <= 1'b0;
            end
        end
    end
end

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// FULL ADDER Module 
module full_adder (
    input logic a,
    input logic b,
    input logic cin,
    output logic sum,
    output logic carry
);
    assign sum = a ^ b ^ cin;
    assign carry = (a & b) | (b & cin) | (cin & a);
endmodule
