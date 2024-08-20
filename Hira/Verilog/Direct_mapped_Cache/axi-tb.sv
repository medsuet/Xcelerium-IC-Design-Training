`include "defs.svh"
module axi_tb;
logic clk;
logic rst;
top_cache DUT(
    .clk(clk),
    .rst(rst),
    .flush(flush),
    .wr_data(wr_data),
    .r_data(r_data),
    .opcode(opcode),
    .addr(addr),
    .valid(valid),
    .ready(ready)
);
// Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

endmodule