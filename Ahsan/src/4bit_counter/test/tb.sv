module tb_counter_4bit;

    logic clk;
    logic rst;
    logic [3:0] count;


    counter_4bit #(
        .MAX_COUNT(13) // Parameterize the counter to reset at 13
    ) uut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // clock generation
    initial 
    begin
        clk = 1;
        forever #5 clk = ~clk; 
    end

    initial 
    begin
    // initialize signals
        rst <=  0;
        @(posedge clk);
        rst <=  1;

        #200;

        // Finish simulation
        $finish;
    end

    initial 
    begin
        $monitor("rst: %b , count: %0d",rst, count);
    end

     initial 
     begin
        $dumpfile("counter.vcd");
        $dumpvars(0);
    end

endmodule
