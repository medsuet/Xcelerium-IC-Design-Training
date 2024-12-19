module counter
#
(
    parameter Counter_bit = 4
) 
(
    input  logic clk,
    input  logic rst,
    output logic [Counter_bit-1: 0] C_out
);

localparam Comparative_number = 13;
logic [Counter_bit-1: 0] C_in;
logic [Counter_bit-1: 0] A;
logic clear = '0;

always_comb
begin
    A    =  C_out + 1;
    C_in =  clear ? 'h0 : A;
end

always_ff @(posedge clk or posedge rst) 
begin
    if (rst) C_out <= #1 '0;
    else     C_out <= #1 C_in;     
end

always_comb
    clear =  (C_out==Comparative_number);


endmodule