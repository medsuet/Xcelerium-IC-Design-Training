module comb_multiplier_tb;

    logic signed [15:0] a;
    logic signed [15:0] b;
    logic signed [31:0] prod;
    
    comb_multiplier dut(
        .a(a),
        .b(b),
        .prod(prod)
    );
    
    initial begin
        $dumpfile("comb_multiplier_tb.vcd");
        $dumpvars(0, comb_multiplier_tb);
        a = 0; b = 3;
        #10;
        $display("a=%d b=%d prod=%d", a, b, prod);
        a = 2;
        #10;
        $display("a=%d b=%d prod=%d", a, b, prod);
        b = 2;
        #10;
        $display("a=%d b=%d prod=%d", a, b, prod);
        a = -6;
        #10;
        $display("a=%d b=%d prod=%d", a, b, prod);
        b = -6;
        #10;
        $display("a=%d b=%d prod=%d", a, b, prod);
        a = 4;
        #10;
        $display("a=%d b=%d prod=%d", a, b, prod);
        $finish;
    end

endmodule
    
