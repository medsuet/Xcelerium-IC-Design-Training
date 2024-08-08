module tb_py_cocotb;

// Inputs
logic [15:0] dividend;
logic [15:0] divisor;
logic clk;
logic rst;
logic valid_src;


// Outputs
logic valid_des;
logic [15:0] quotient;
logic [15:0] reminder;


restoring_division uut (
    .dividend(dividend),
    .divisor(divisor),
    .clk(clk),
    .rst(rst),
    .valid_src(valid_src),
    .valid_des(valid_des),
    .quotient(quotient),
    .reminder(reminder)
);

    // Dump file for waveform
    initial begin
        $dumpfile("tb_cocotb.vcd");
        $dumpvars(0,tb_py_cocotb);
    end

endmodule

