module multiplier_tb;
    reg signed [15:0] a;
    reg signed [15:0] b;
    wire signed [31:0] pro;
    multiplier uut (
        .a(a),
        .b(b),
        .pro(pro)
    );

    integer i;
    reg signed [31:0] expected; // Move declaration here

    initial begin
        a = 16'd0;
        b = 16'd0;
        #10; // Initial delay

        // Apply random test cases
        for (i = 0; i < 500; i = i + 1) begin
            a = $urandom_range(-32768, 32767);
            b = $urandom_range(-32768, 32767);
            #10; 

            // expected value
            expected = $signed(a) * $signed(b);

            // result
            if (pro !== expected) begin
                $display("ERROR: a = %d, b = %d, Expected = %d, pro = %d", a, b, expected, pro);
            end else begin
                $display("PASS: a = %d, b = %d, Expected = %d, pro = %d", a, b, expected, pro);
            end
        end
        $stop; 
    end
endmodule
