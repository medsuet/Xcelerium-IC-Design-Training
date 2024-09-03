module tb;

logic clk, rst, detect_signal, data;

    //instantiate module
    posedge_detector uut (
        .clk(clk),
        .rst(rst),
        .data(data),
        .detect_signal(detect_signal)
    );

    //generating clock
    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    task reset_circuit;
        rst = 0;
        #10;
        rst = 1;
    endtask

    initial begin
        reset_circuit;
        data = 0;
        repeat(2)@(posedge clk);
        data = 1;
        repeat(2)@(posedge clk);
        data = 0;
        repeat(2)@(posedge clk);
        data = 1;
        repeat(2)@(posedge clk);
        data = 0;
        @(posedge clk);
        $finish;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end

endmodule