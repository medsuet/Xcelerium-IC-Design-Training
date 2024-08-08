module Top(clk,rst,divident,divisor,ready,remainder,quotient,start);
input logic clk,rst,start;
input logic [15:0] divident,divisor;
output logic ready;
output logic [15:0] remainder,quotient;

//intermediate wire
logic msb,clear,count_comp,enable,mux_sel_msb,mux_sel_quotient;

Datapath DP(.divident(divident),
            .divisor(divisor),
            .clk(clk),
            .rst(rst),
            .remainder(remainder),
            .quotient(quotient),
            .mux_sel_msb(mux_sel_msb),
            .mux_sel_quotient(mux_sel_quotient),
            .clear(clear),
            .count_comp(count_comp),
            .msb(msb),
            .enable(enable));

Controller CU(  .clk(clk),
                .rst(rst),
                .ready(ready),
                .start(start),
                .clear(clear),
                .enable(enable),
                .count_comp(count_comp),
                .msb(msb),
                .mux_sel_msb(mux_sel_msb),
                .mux_sel_quotient(mux_sel_quotient));

endmodule