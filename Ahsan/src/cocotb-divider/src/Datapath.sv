module Datapath(divident,divisor,clk,rst,remainder,quotient,mux_sel_msb,mux_sel_quotient,clear,count_comp,msb,enable);
input logic [15:0] divident,divisor;  
input logic clk,rst,mux_sel_quotient,mux_sel_msb,clear,enable;
output logic count_comp;
output logic msb;
output logic [15:0] remainder,quotient;

// intermediate wires
logic [31:0] combined,shifted;
logic [15:0] A,Q,M,A_in,A_M,Q_in,Q_mod;
logic [4:0] counter ;

assign combined = {A,Q};

assign shifted  = {combined[30:0],1'b0};

assign A_M     = shifted[31:16] - M;

//mux for choosing if we wana recover A or not
assign A_in = ( mux_sel_msb == 1'b0 )? A_M  : A_M + M ;

//mux for setting lsb of Q
assign Q_mod = ( mux_sel_msb == 1'b0 )? shifted[15:0] | 1 : shifted[15:0] & (~1);

//mux fro selecting Q_in
assign Q_in = ( mux_sel_quotient == 1'b0 )? divident : Q_mod;

//counter comparison
assign count_comp = ( counter == 5'd17 ) ? 1'b1: 1'b0;

//msb of A for checking
assign msb  = A_M[15];

//flipflops
always_ff @( posedge clk or negedge rst ) 
begin 
    if(!rst)
    begin
        A    <= 0;
        M    <= 0;
        Q    <= 0;
    counter  <= 0;
    end
    if(clear)
    begin
        A    <= 0;
        M    <= 0;
        Q    <= 0;
    counter  <= 0;
    end
    else
    begin
        A    <= A_in;
        M    <= divisor;
        Q    <= Q_in;
    counter  <= counter + 1;    
    end   
end
always_ff@(posedge clk or negedge rst) begin
    if (!rst)
    begin
        remainder = 0;
        quotient  = 0;
    end
    else if (!enable)
    begin
        remainder = remainder;
        quotient  = quotient;
    end
    else
    begin
        remainder = A_in;
        quotient  = Q_mod;
    end  
end
endmodule