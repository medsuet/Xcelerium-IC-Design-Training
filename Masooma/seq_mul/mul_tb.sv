//==============Author: Masooma Zia==============
//==============Date: 29-07-2024==============
//==============Description:Test Bench for 16-bit signed sequential multiplier==============
module mul_tb;
    reg signed [15:0] q;
    reg signed [15:0] m;
    reg signed start;
    reg signed clk;
    reg signed rst;
    wire signed [31:0] p;
    wire signed ready;
    mul uut (
        .clk(clk),
        .rst(rst),
        .q(q), 
        .m(m), 
        .start(start), 
        .p(p), 
        .ready(ready)
    );

    // Clock generation
    initial begin
        $dumpfile("mul.vcd");
        $dumpvars(0,mul_tb);
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        start=0;
        q=0;
        m=0;
        //=============================================================
        reset();
        //=============================================================
        basic_test(16'h0001, 16'h0003); // 1, 3
        basic_test(16'hFFFF, 16'h0007); // -1, 7
        basic_test(16'h0000, 16'h0014); // 0, 20
        basic_test(16'hFFFE, 16'h0008); // -2, 8
        //=============================================================
        fork
            launch_tests();
        join
        
        $finish;
    end

    task reset();
        begin
            rst = 0;
            #10;
            rst = 1;
        end
    endtask

    task basic_test(input [15:0] num1, input [15:0] num2);
    begin
        @(posedge clk);
        q = num1;
        m = num2;
        start = 1;
        @(posedge clk);
        start = 0;
        @(posedge ready);
        if (q*m === p) begin
            $display("Test Pass for %d and %d", q, m);
        end else begin
            $display("Test Fail for %d and %d as Expected output is %d and you got %d", q, m, q*m, p);
        end
        @(posedge clk);
    end
    endtask
    task driver(input [15:0] num1, input [15:0] num2);
    begin
        @(posedge clk);
        q = num1;
        m = num2;
        start = 1;
        @(posedge clk);
        start = 0;
        @(posedge ready);
    end
    endtask
    task monitor();
    begin
        if (q*m === p) begin
            $display("Test Pass for %d and %d", q, m);
        end else begin
            $display("Test Fail for %d and %d as Expected output is %d and you got %d", q, m, q*m, p);
        end
        @(posedge clk);

    end
    endtask
    task launch_tests();
    begin
        reg signed [15:0] num1;
        reg signed [15:0] num2;
        for (int i = 0; i < 1000; i = i + 1) begin
                num1 = $urandom_range(-32768, 32767);
                num2 = $urandom_range(-32768, 32767);
                driver(num1,num2);
                monitor();
            end
    end
    endtask


        

endmodule
