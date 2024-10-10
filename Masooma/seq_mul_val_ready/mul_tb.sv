//==============Author: Masooma Zia==============
//==============Date: 1-08-2024==============
//==============Description:Test Bench for 16-bit signed sequential multiplier with ready-val interface==============
module mul_tb;
    reg signed [15:0] q;
    reg signed [15:0] m;
    reg signed src_valid;
    reg signed dest_ready;
    reg signed clk;
    reg signed rst;
    wire signed [31:0] p;
    wire signed src_ready;
    wire signed dest_valid;

    mul uut (
        .clk(clk),
        .rst(rst),
        .q(q), 
        .m(m), 
        .src_valid(src_valid), 
        .dest_valid(dest_valid),
        .src_ready(src_ready),
        .dest_ready(dest_ready),
        .p(p)
    );

    // Clock generation
    initial begin
        $dumpfile("mul.vcd");
        $dumpvars(0,mul_tb);
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        src_valid=0;
        dest_ready=0;
        q=0;
        m=0;
        //=============================================================
        reset();
        //=============================================================
        basic_test(16'h0001, 16'h0003); // 1, 3
        basic_test(16'hFFFF, 16'h0007); // -1, 7
        basic_test(16'h0000, 16'h0014); // 0, 20
        basic_test(16'hFFFE, 16'h0008); // -2, 8
        another_input_before_dest_ready(2,7);
        another_input_before_dest_ready(-45,-100);
        another_input_before_dest_ready(-56,29193);
        another_input_before_dest_ready(0,90);
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
        wait (src_ready);
        src_valid = 1;
        @(posedge clk);
        src_valid = 0;
        wait (dest_valid);
        dest_ready=1;
        if (q*m === p) begin
          $display("Test Pass for %d and %d", q, m);
        end else begin
          $display("Test Fail for %d and %d as Expected output is %d and you got %d", q, m, q*m, p);
        end
        @(posedge clk);
    end
    endtask
    task another_input_before_dest_ready(input signed [15:0] num1, input signed [15:0] num2);
    begin
        @(posedge clk);
        dest_ready=0;
        q = num1;
        m = num2;
        wait (src_ready);
        src_valid = 1;
        @(posedge clk);
        src_valid = 0;
        q=$urandom_range(-100,100);
        m=$urandom_range(-100,100);
        repeat(10)@(posedge clk);
        src_valid = 1;
        repeat(2)@(posedge clk);
        src_valid=0;
        wait (dest_valid);
        dest_ready=1;
        if (num1*num2 === p) begin
          $display("Test Pass for %d and %d", num1, num2);
        end else begin
          $display("Test Fail for %d and %d as Expected output is %d and you got %d", num1, num2, num1*num2, p);
        end
        @(posedge clk);
    end
    endtask
  task driver(input [15:0] num1, input [15:0] num2);
  begin
        @(posedge clk);
        dest_ready=0;
        q = num1;
        m = num2;
        wait (src_ready);
        src_valid = 1;
        @(posedge clk);
        src_valid=0;
        wait (dest_valid);
        dest_ready=1;
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
