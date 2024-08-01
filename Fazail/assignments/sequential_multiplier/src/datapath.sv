module datapath #(
    WIDTH = 16
) (
    input logic signed [WIDTH-1:0] multiplicand,
    input logic signed [WIDTH-1:0] multiplier,

    input logic clk, n_rst,

    // Controller -> Datapath
    input logic en_in,
    input logic bit_sel,
    input logic count_lb,
    input logic count_en,
    input logic clr,

    // Datapath -> Controller
    output logic count_15,
    output logic count_14,
    output logic bit_01,

    // Final Product
    output logic signed [2*WIDTH-1:0] product
);

logic signed [WIDTH-1 : 0] in_a;
logic signed [2*WIDTH-1 : 0] ext_a, mux_a, mux_lb, shft_a, pp, add_pp;
logic [(WIDTH/2)+1:0] count_value, value;

always_ff @( posedge clk or negedge n_rst ) begin : Register_a
    if (!n_rst)
        in_a <= 0;
    else begin
        if (en_in)
            in_a <= multiplier;
        else 
            in_a <= in_a;
    end    
end

// signedextention
always_comb
        begin
            if(in_a[WIDTH-1] == 1'b0)
                assign ext_a = {16'h0000,in_a};
            else
                assign ext_a = {16'hFFFF,in_a};
        end

shift_register shift_register(.in(multiplicand), .en(en_in),  .clk(clk), .n_rst(n_rst), .out_b(bit_01));

// mux for extended a or 0
assign mux_a = (bit_sel) ? ext_a : 32'b0;

// mux count last bit
assign mux_lb = (count_lb) ? (~mux_a + 1) : mux_a;

// 5-bit counter
always_ff @( posedge clk or negedge n_rst ) begin : counter
    if (!n_rst) 
        count_value <= '0;
    else begin
        if (count_en) count_value <= value;
        else if (clr) count_value <= '0;
        else count_value <= '0;
    end
end

assign value = count_value + 1;

// comparator
assign count_15 = (count_value == 16) ? 1 : 0;
assign count_14 = (count_value == 15) ? 1 : 0; 


// shifting left 
assign shft_a = mux_lb << count_value;

// Product Register
always_ff @( posedge clk or negedge n_rst ) begin : partial_product
    if (!n_rst) pp <= '0;
    else if (clr) pp <= '0;
    else pp <= add_pp;
end

// adder
assign add_pp =  pp + shft_a;

// product mux
assign product =  (clr) ? pp : '0; 

endmodule

module shift_register #(
    WIDTH = 16
)(
    input logic signed [16-1:0]in,
    input logic en,

    input logic clk, n_rst,

    output logic signed out_b
);

logic signed [WIDTH-1:0] in_b;

assign out_b = in_b[0];

always_ff @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        in_b <= '0;
    end
    else begin
        if (en) begin
            in_b <= in;
        end
        else begin
            in_b[0] <= in_b[1];
            in_b[1] <= in_b[2];
            in_b[2] <= in_b[3];
            in_b[3] <= in_b[4];
            in_b[4] <= in_b[5];
            in_b[5] <= in_b[6];
            in_b[6] <= in_b[7];
            in_b[7] <= in_b[8];
            in_b[8] <= in_b[9];
            in_b[9] <= in_b[10];
            in_b[10] <= in_b[11];
            in_b[11] <= in_b[12];
            in_b[12] <= in_b[13];
            in_b[13] <= in_b[14];
            in_b[14] <= in_b[15];   
        end
    end
end
    
endmodule