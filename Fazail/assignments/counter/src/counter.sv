module counter #(
    WIDTH = 4   // Number of bits in the counter
) (
    input logic clk,
    input logic n_rst,

    output logic [WIDTH-1:0] value,
    output logic [WIDTH-1:0] mux_out,
    output logic clr    // clear bit
);
logic [WIDTH-1:0] in;

// adder
assign in = value + 1;

// mux for clear
assign mux_out = clr ? '0 : in;

// Register with asynchronous active low reset
always_ff @( posedge clk or negedge n_rst ) 
begin
    if (!n_rst) value <= '0;
    else value <= #1 mux_out;  
end

// comparator
assign clr = (value == 4'b1101) ? 1'b1 : 1'b0;
    
endmodule