module tb_multiplier;
    reg [15:0] a, b;
    wire [31:0] s;
    reg signed [31:0] expected_s;
    integer i;

    // Instantiate the multiplier
    multiplier uut (
        .a(a),
        .b(b),
        .s(s)
    );

    initial begin
        // Apply specific test vectors
        a = 16'd3; b = 16'd2;
        #10;
        expected_s = a * b;
        if (s === expected_s)
            $display("Test Pass: a = %d, b = %d, s = %d", a, b, s);
        else
            $display("Test Fail: a = %d, b = %d, s = %d, expected_s = %d", a, b, s, expected_s);

        a = 16'd7; b = 16'd5;
        #10;
        expected_s = a * b;
        if (s === expected_s)
            $display("Test Pass: a = %d, b = %d, s = %d", a, b, s);
        else
            $display("Test Fail: a = %d, b = %d, s = %d, expected_s = %d", a, b, s, expected_s);

        a = 16'd15; b = 16'd15;
        #10;
        expected_s = a * b;
        if (s === expected_s)
            $display("Test Pass: a = %d, b = %d, s = %d", a, b, s);
        else
            $display("Test Fail: a = %d, b = %d, s = %d, expected_s = %d", a, b, s, expected_s);

        $stop;
    end

    initial begin
        // Apply random test vectors
        for (i = 0; i < 500; i = i + 1) begin
            a = $random;
            b = $random;
            #10;
            expected_s = a * b;
            if (s === expected_s)
                $display("Test Pass: Random Test %0d: a = %d, b = %d, s = %d", i, a, b, s);
            else
                $display("Test Fail: Random Test %0d: a = %d, b = %d, s = %d, expected_s = %d", i, a, b, s, expected_s);
        end
        $stop;
    end
endmodule

