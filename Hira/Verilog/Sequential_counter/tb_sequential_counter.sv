module tb_Sequential_counter();
    logic       clk;
    logic       rst;
    logic  bit_number; 
    logic  state;

    counter dut (
        .clk(clk),
        .rst(rst),    
        .bit_number(bit_number), 
        .system_output(state)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period
    end

    initial begin
        rst = 1;

        @(posedge clk) 
        rst = 0;
        //for 2
        bit_number = 1'b0;
        @(posedge clk) 
        bit_number = 1'b1;
        @(posedge clk) 
        bit_number = 1'b0;
        @(posedge clk) 
        bit_number = 1'b0;
        @(posedge clk) 

        //for 3
        bit_number = 1'b1;
        @(posedge clk) 
        bit_number = 1'b1;
        @(posedge clk) 
        bit_number = 1'b0;
        @(posedge clk) 
        bit_number = 1'b0;
        @(posedge clk) 


         //for 4
        bit_number = 1'b0;
        @(posedge clk) 
        bit_number = 1'b0;
        @(posedge clk) 
        bit_number = 1'b1;
        @(posedge clk) 
        bit_number = 1'b0;
        @(posedge clk) 


         //for 5
        bit_number = 1'b1;
        @(posedge clk) 
        bit_number = 1'b0;
        @(posedge clk) 
        bit_number = 1'b1;
        @(posedge clk) 
        bit_number = 1'b0;
        @(posedge clk) 

         //for 6
        bit_number = 1'b0;
        @(posedge clk) 
        bit_number = 1'b1;
        @(posedge clk) 
        bit_number = 1'b1;
        @(posedge clk) 
        bit_number = 1'b0;
        @(posedge clk) 


        $monitor("At time %t, bit_numbe%d ,state = %d", $time, bit_number ,state);

        $finish;
    end
    

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, dut);
    end


endmodule
