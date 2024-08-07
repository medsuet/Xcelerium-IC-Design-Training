module tb;

    logic clk, rst, src_valid, src_ready, dest_valid, dest_ready;
    logic [15:0] divisor, dividend;
    logic [15:0] remainder, quotient, exp_remainder, exp_quotient;

    restoring_division uut (
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready),
        .divisor(divisor),
        .dividend(dividend),
        .remainder(remainder),
        .quotient(quotient)
    );

    //generating wavefile
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end
endmodule

