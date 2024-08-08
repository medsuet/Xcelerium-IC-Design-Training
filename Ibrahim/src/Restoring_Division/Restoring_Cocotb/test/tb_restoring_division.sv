module tb_restoring_division;
    // Parameter definition with default value
    parameter WIDTH = 16;  // Width of data signals

    // Inputs
    logic [WIDTH-1:0] dividend; // Input for dividend
    logic [WIDTH-1:0] divisor;  // Input for divisor
    logic clk;                  // Clock signal
    logic rst_n;                // Reset signal (active-low)
    logic src_valid;            // Source valid signal
    logic dest_ready;           // Destination ready signal

    // Expected outputs for verification
    logic [WIDTH-1:0] expected_quotient;
    logic [WIDTH-1:0] expected_remainder;

    // Outputs
    logic [WIDTH-1:0] quotient;    // Output quotient
    logic [WIDTH-1:0] remainder;   // Output remainder
    logic src_ready, dest_valid;   // Handshake signals

    // Instantiate the Unit Under Test (UUT)
    restoring_division #(.WIDTH(WIDTH)) uut (
        .dividend(dividend),
        .divisor(divisor),
        .clk(clk),
        .rst_n(rst_n),
        .src_valid(src_valid),
        .dest_ready(dest_ready),
        .dest_valid(dest_valid),
        .src_ready(src_ready),
        .quotient(quotient),
        .remainder(remainder)
    );
     
    // Dump file for waveform
    initial begin
        $dumpfile("restoring_tb.vcd");
        $dumpvars(0);
    end

endmodule
