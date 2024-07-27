//==============Author: Masooma Zia==============
//==============Date: 25-07-2024==============
//==============Description:Test bench for 16-bit Binary Multiplier(Array Multiplier)==============
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

    initial begin
        a = 16'd0;
        b = 16'd0;
        #10;

        // Apply random test cases
        for (i = 0; i < 1000; i = i + 1) begin
            a = $urandom_range(-32768, 32767);
            b = $urandom_range(-32768, 32767);
            #10;
            if (pro !== a * b) begin
                $display("ERROR: a * b = %d, pro = %d", a * b, pro);
            end else begin
                //$display("PASS: a * b = %d, pro = %d", a * b, pro);
            end
        end
        $stop;
    end
endmodule
