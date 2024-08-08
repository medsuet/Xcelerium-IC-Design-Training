module tb;
    logic clk, rst, b;
    logic a;

    //instantiate the adder
    adder_state_machine uut (
        .clk(clk),
        .rst(rst),
        .b(b),
        .a(a)
    );

    //clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    task reset_circuit;
       rst = 0;
       #5;
       rst = 1;
    endtask 

    initial begin
        reset_circuit;
        //input 3
        b = 1;
        @ (posedge clk) ;
        b = 1;
        @ (posedge clk) ;
        b = 0;
        @ (posedge clk) ;
        b = 0;
        @ (posedge clk) ;

        //next input 4
        b = 0;
        @ (posedge clk) ;
        b = 0;
        @ (posedge clk) ;
        b = 1;
        @ (posedge clk) ;
        b = 0;
        @ (posedge clk) ;
        
        //next input 11
        b = 1;
        @ (posedge clk) ;
        b = 1;
        @ (posedge clk) ;
        b = 0;
        @ (posedge clk) ;
        b = 1;
        @ (posedge clk) ;

        $finish;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,tb);
    end

endmodule
