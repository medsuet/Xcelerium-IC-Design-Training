module counter_tb();
    logic CLK;
    logic RST;
    logic [3:0] Q;

    counter uut(
        .CLK(CLK),
        .RST(RST),
        .Q(Q)
    );
    initial begin
        CLK = 1;
        forever #10 CLK = ~CLK;         // 20ns clock period
    end
    initial begin
        RST <= #1 1;
        repeat(2) @(posedge CLK);      // Wait for two clock cycles
        RST <= #1 0;
        repeat (30) @(posedge CLK);    // Wait for 30 clock cycles
        $stop;
        $finish;
    end
endmodule