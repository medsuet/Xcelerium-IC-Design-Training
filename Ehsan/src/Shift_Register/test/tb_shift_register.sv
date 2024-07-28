module tb;

    logic clk ,rst, D ,A;

    shift_reg uut (
        .clk(clk),
        .rst(rst),
        .D(D),
        .A(A)
    );

    //clock generation
    initial begin
        clk = 1;
        forever #10 clk = ~clk;  // 10 time units clock period
    end

    task reset_circuit;
        rst = 0;
        #20;
        rst = 1;
    endtask 

    initial begin
        D = 1; //initialize D to 0
        reset_circuit;
        @(posedge clk);
        @(posedge clk);
        D = #1 0; 

        @(posedge clk);
        @(posedge clk);
        D = #1 1; 

        @(posedge clk);
        @(posedge clk);
        D = #1 0; 

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $finish;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,tb);
    end

endmodule
