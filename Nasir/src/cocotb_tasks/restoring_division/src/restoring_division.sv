module restoring_division (
    input logic [15:0] dividend,
    input logic [15:0] divisor,
    input logic start,
    input logic clk,
    input logic reset,
    output logic [15:0] quotient,
    output logic [15:0] remainder,
    output logic ready
);

logic select_aq;
logic enable;
logic update_quotient;
logic count_16;
logic msb_remainder;

datapath datapath_design (.dividend(dividend),
                          .divisor(divisor),
                          .clk(clk),
                          .reset(reset),
                          .select_aq(select_aq),
                          .enable(enable),
                          .update_quotient(update_quotient),
                          .ready(ready),
                          .count_16(count_16),
                          .msb_remainder(msb_remainder),
                          .remainder(remainder),
                          .quotient(quotient));

controller controller_design (.clk(clk),
                              .reset(reset),
                              .start(start),
                              .count_16(count_16),
                              .msb_remainder(msb_remainder),
                              .ready(ready),
                              .select_aq(select_aq),
                              .update_quotient(update_quotient),
                              .enable(enable));

// dump file
initial begin
    $dumpfile("restoring_division.vcd");
    $dumpvars(0, restoring_division);
end
    
endmodule