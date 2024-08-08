localparam WIDTH = 16;

module tb_sequential_multiplier (
    `ifdef VERILATOR
        input logic clk
    `endif
);

// Input signals
logic signed [WIDTH-1:0] multiplier, m_in;
logic signed [WIDTH-1:0] multiplicand, m_in2;

// Output signal
logic signed [2*WIDTH-1:0] product;

// Val-ready protoccol
logic src_valid_i, dst_ready_i;
logic src_ready_o, dst_valid_o;

`ifndef VERILATOR
    logic clk;
`endif
logic n_rst;

int fd; // file variable
int tests = 10;

sequential_multiplier UUT (
    .multiplier (multiplier), .multiplicand(multiplicand),
    .src_valid_i(src_valid_i), .dst_ready_i(dst_ready_i),
    //.start(start), 
    .clk(clk), .n_rst(n_rst), .product(product),
    .src_ready_o(src_ready_o), .dst_valid_o(dst_valid_o)
    //.ready(ready)
    );

`ifndef VERILATOR
    initial begin
        clk = 1;
        forever begin
            #20 clk = ~clk;
        end
    end
`endif
initial begin
    init_signals;

    /* ---> Direct Test <--- */
    // every test takes atleast 16-18 cycles
    direct_test (16'hFFFF, 16'hFFFF);
    direct_test (16'h8000, 16'hFFFF);
    direct_test (16'h90, 16'h8000);
    direct_test (16'h8001, 16'h1);

    reset_seq;

    fork
        driver_src(tests);
        driver_dst(tests);
        monitor(tests);  
    join

    @(posedge clk);
    //$stop;
    $finish;
end

task driver_src (input int tests);
    begin
        for (int j = 1; j < tests ; j++) begin
            multiplier <= $random();
            multiplicand <= $random();
            src_valid_i <= 1;
            while(!src_ready_o) begin
                @(posedge clk);
            end
            @(posedge clk);
            src_valid_i = 0;
            repeat(1) @(posedge clk);
        end
    end
endtask

task driver_dst (input int tests);
    begin
        for (int k = 1; k < tests; k++) begin
            dst_ready_i <= 1;
            while (!dst_valid_o) begin
                @(posedge clk);
            end
            @(posedge clk); 
            dst_ready_i = 0;
            @(posedge clk); 
        end
    end 
endtask 

task monitor(input int tests);
    fd = $fopen ("log/output_result.log", "w");

    for(int i = 1; i < tests; i++) begin
        
        while (!(src_ready_o & src_valid_i)) begin
            @(posedge clk);
        end

        m_in <= multiplier;
        m_in2 <= multiplicand;
        
        while (!(dst_valid_o & dst_ready_i)) begin
            @(posedge clk);
        end
        
        // Self Check 
        if (mul_ref(m_in, m_in2) == product) begin
            $fdisplay(fd,"PASS: multiplier = %d, multiplicand = %d | product = %d ", multiplier, multiplicand, product);
            $display("Test No. : %0d PASS: multiplier = %d, multiplicand = %d | product = %d ",i ,multiplier, multiplicand, product);
        end
        else begin
            $fdisplay(fd,"FAIL: multiplier = %0d, multiplicand = %0d, product = %0d, expected_value = %0d ", multiplier,
            multiplicand, product, mul_ref(m_in, m_in2));
            $display("FAIL: multiplier = %0d, multiplicand = %0d, product = %0d, expected_value = %0d ", multiplier,
            multiplicand, product, mul_ref(m_in, m_in2));
            $finish;
        end
    end
    $fclose(fd);
endtask

task init_signals;
    n_rst = 1; m_in = 0; m_in2 = 0;
    multiplier = 0; multiplicand = 0;

    src_valid_i = 0; dst_ready_i = 0;
    src_ready_o = 0; dst_valid_o = 0;
    @(posedge clk);
endtask 

task reset_seq;
    n_rst <= 0;
    @(posedge clk); 
    n_rst <= 1;
    @(posedge clk);
endtask
    

task direct_test(input signed [WIDTH-1:0] in_a, input signed [WIDTH-1:0] in_b);
    
    reset_seq;
    multiplier =  in_a; multiplicand = in_b;

    src_valid_i <= 1;
    //@(posedge clk);
    while(!src_ready_o) begin
        @(posedge clk);
        $display("src");
    end
    @(posedge clk);
    src_valid_i = 0;
    repeat(0) @(posedge clk);

    dst_ready_i <= 1;
    @(posedge clk); 
    while (!dst_valid_o) begin
        @(posedge clk);
    end
    dst_ready_i = 0;

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