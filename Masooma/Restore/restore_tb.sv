module restore_tb;
    reg unsigned [31:0] dd;
    reg unsigned [31:0] ds;
    reg signed src_valid;
    reg signed dest_ready;
    reg signed clk;
    reg signed rst;
    wire unsigned [31:0] quo;
    wire unsigned [31:0] rem;
    wire signed src_ready;
    wire signed dest_valid;
    integer seed;

    restore uut (
        .clk(clk),
        .rst(rst),
        .dd(dd), 
        .ds(ds), 
        .src_valid(src_valid), 
        .dest_valid(dest_valid),
        .src_ready(src_ready),
        .dest_ready(dest_ready),
        .quo(quo),
        .rem(rem)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        seed = $urandom;
        src_valid = 0;
        dest_ready = 0;
        dd = 0;
        ds = 0;
        //=============================================================
        reset();
        //basic_test(1728176395, 3835077831);
        basic_test(0, 9);
        basic_test(1, 23);
        basic_test(24, 3);
        basic_test(164, 11);

        launch_tests();
        $finish;
    end

    task reset();
        begin
            rst = 0;
            #10;
            rst = 1;
        end
    endtask

    task basic_test(input [31:0] num1, input [31:0] num2);
    begin
        dest_ready = 0;
        @(posedge clk);
        dd = num1;
        ds = num2;
        while (!src_ready) begin
            @(posedge clk);
        end
        src_valid = 1;
        @(posedge clk);
        src_valid = 0;
        while (!dest_valid) begin
            @(posedge clk);
        end
        dest_ready = 1;
        if ((dd / ds === quo) && (dd % ds === rem)) begin
            $display("Test Pass for %d and %d", dd, ds);
        end else begin
            $display("Test Fail for %d and %d as Expected quo=%0d and rem=%d you got quo=%0d and rem=%d", dd, ds, dd / ds, dd % ds, quo, rem);
        end
        @(posedge clk);
    end
    endtask

    task driver(input [31:0] num1, input [31:0] num2);
    begin
        dest_ready = 0;
        @(posedge clk);
        dd = num1;
        ds = num2;
        while (!src_ready) begin
            @(posedge clk);
        end
        src_valid = 1;
        @(posedge clk);
        src_valid = 0;
        while (!dest_valid) begin
            @(posedge clk);
        end
    end
    endtask

    task monitor(input [31:0] num1, input [31:0] num2);
    begin
        dest_ready = 1;
        if ((dd / ds === quo) && (dd % ds === rem)) begin
            $display("Test Pass for %d and %d", dd, ds);
        end else begin
            $display("Test Fail for %d and %d as Expected quo=%0d and rem=%d you got quo=%0d and rem=%d", dd, ds, dd / ds, dd % ds, quo, rem);
        end
        @(posedge clk);
    end
    endtask

    task launch_tests();
    logic unsigned [31:0] num1, num2;
    begin
        for (int i = 0; i < 1000; i++) begin
            num1 = $urandom(seed) % $unsigned('hFFFFFFFF);
            seed = $urandom;
            num2 = $urandom(seed) % $unsigned('hFFFFFFF);
            driver(num1, num2);
            monitor(num1, num2);
        end
    end
    endtask
endmodule
