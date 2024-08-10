module tb;

//=================== Declearing Input And Outputs For UUT ===================//

    logic            clk, rst, src_valid, src_ready, dest_valid, dest_ready;
    logic   [15:0]   divisor, dividend;
    logic   [15:0]   remainder, quotient, exp_remainder, exp_quotient;

//========================== Instantiations Module ===========================//

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
//=========================== Generating Waveform ============================//

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end
    
endmodule

