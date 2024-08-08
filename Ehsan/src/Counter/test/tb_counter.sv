module tb;

    logic clk, rst;
    logic [3:0] Q;

    counter uut (
        .clk(clk),
        .rst(rst),
        .Q(Q)
    );

    task reset_circuit;
        rst = #1 0;
        #10; 
        rst = #1 1;
    endtask 

    //clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; 
    end

    initial begin
        reset_circuit;
        //run the simulation for 100
        #200;
        $finish;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end

endmodule
