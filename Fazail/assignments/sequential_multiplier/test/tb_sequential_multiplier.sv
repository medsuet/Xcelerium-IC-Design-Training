localparam WIDTH = 16;

module tb_sequential_multiplier ();

logic signed [WIDTH-1:0] multiplier, m_in;
logic signed [WIDTH-1:0] multiplicand, m_in2;
logic start;

logic clk, n_rst;

logic signed [2*WIDTH-1:0] product;
logic ready;

int count;

int fd;

sequential_multiplier UUT (
    .multiplier (multiplier), .multiplicand(multiplicand),
    .start(start), .clk(clk), .n_rst(n_rst), .product(product),
    .ready(ready)
    );

initial begin
    clk = 1;
    forever begin
        #20 clk = ~clk;
    end
end

initial begin
    init_signals;

    /* ---> Direct Test <--- */
    // every test takes atleast 16-18 cycles
    direct_test (10, 1);
    direct_test (10, -1);
    direct_test (-10, 1);
    direct_test (-10, -1);
    direct_test (0, 0);
    direct_test (0, -1);
    direct_test (-1, 0);
    direct_test (-100, -1001);

    reset_seq;


    fork
        driver(10000);
        monitor(10000);  
    join

    $finish;
end

task driver (input int tests);
    begin
        for (int j = 0;j <= tests ; j++) begin
            multiplier = $random();
            multiplicand = $random();

            @(posedge clk);
            start_seq;

            while(!ready) begin
                @(posedge clk);
            end
        end
    end
endtask

task monitor(input int tests);
    fd = $fopen ("log/output_result.log", "w");

    for(int i = 0; i <= tests; i++) begin
        @(posedge start);
        m_in <= #1 multiplier;
        m_in2 <= #1 multiplicand;
        repeat (2) @(posedge clk);
        
        // gives the clock signal till the ready comes
        count = 0;
        while (!ready) begin
            @(posedge clk);
            if (count > 20) begin
                $fatal("No valid out appears for 20 clock cycles");
            end
            count ++;
        end

        // Self Check 
        if (mul_ref(m_in, m_in2) == product) begin
            $fdisplay(fd,"PASS: multiplier = %d, multiplicand = %d | product = %d ", multiplier, multiplicand, product);
        end
        else begin
            $fdisplay(fd,"FAIL: multiplier = %0d, multiplicand = %0d, product = %0d, expected_value = %0d ", multiplier,
            multiplicand, product, mul_ref(m_in, m_in2));
            $display("FAIL: multiplier = %0d, multiplicand = %0d, product = %0d, expected_value = %0d ", multiplier,
            multiplicand, product, mul_ref(m_in, m_in2));
        end
 
    end
    $fclose(fd);


endtask

task init_signals;
    start = 0; n_rst = 1; 
    multiplier = 0; multiplicand = 0;
    count = 0; m_in = 0; m_in2 = 0;
    @(posedge clk);
endtask 

task reset_seq;
    n_rst = 0;
    @(posedge clk); 
    n_rst = 1;
    @(posedge clk);
endtask

task start_seq;
    start = 1;
    @(posedge clk);
    start = 0;
    @(posedge clk);
endtask

task direct_test(input signed [WIDTH-1:0] in_a, in_b);
    
    reset_seq;
    multiplier =  in_a; multiplicand = in_b;

    @(posedge clk);
    start_seq;

    // gives the clock signal till the ready comes
    while (!ready) begin
        @(posedge clk);
        if (count > 20) begin
            $fatal("No valid out appears for 20 clock cycles");
        end
        count ++;
    end
    count = 0;

    // Self Check 
    if (mul_ref(in_a, in_b) == product) begin
        $display("PASS: multiplier = %d, multiplicand = %d | product = %d ", multiplier, multiplicand, product);
    end
    else begin
        $display("FAIL: multiplier = %d, multiplicand = %d | product = %d, expected_value = %d ", multiplier,
        multiplicand, product, mul_ref(in_a, in_b));
    end
    
endtask

   function [2*WIDTH-1:0]mul_ref(input logic [WIDTH-1:0]in_a, in_b);
   	begin
   		mul_ref = ($signed(in_a) * $signed(in_b));
   	end
   endfunction 	 

endmodule