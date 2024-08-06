module comb_multiplier_tb;

    logic signed [15:0] a;
    logic signed [15:0] b;
    logic signed [31:0] prod;
    logic signed [31:0] a_prod;
    logic [31:0] count_pass;
    logic [16:0] count_fail;
    
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
        a = 6000; b = 4000;
        #10;
        $display("a=%d b=%d prod=%d", a, b, prod);

        count_pass = 0;
        count_fail = 0;
        a_prod = 0;
        for (int i=0; i<200000; i++) begin
            a = $random; b = $random;
            a_prod = a*b;
            #1;
            if (prod == a_prod) begin
                count_pass++;
            end else begin
                count_fail++;
            end
        end
        $display("Passed Test = %d Fail Test = %d", count_pass, count_fail);
        $finish;
    end


endmodule
    
