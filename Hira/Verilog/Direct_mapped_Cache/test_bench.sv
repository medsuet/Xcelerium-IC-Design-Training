
module tb_top_module;

    // Clock and Reset
    logic clk;
    logic rst;

    // Testbench signals
    logic [31:0] address;
    logic [31:0] input_data;
    logic cpu_request_read;
    logic cpu_request_write;

    // Instantiate Top Module
    top_module dut (
        .clk(clk),
        .rst(rst),
        .address(address),
        .input_data(input_data),
        .cpu_request_read(cpu_request_read),
        .cpu_request_write(cpu_request_write)
    );

    // Clock generation
    always #5 clk = ~clk;



    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        cpu_request_write = 0;
        address = 0;
        input_data = 0;

        // Reset the system
        #10;
        rst = 0;

        // Test case: CPU request for write
        #10;
        address = 32'h00005678;
        input_data = 32'hDEADBEEF;
        cpu_request_write = 1;
        #20;
        cpu_request_write = 0;

        // Wait for some time to observe the results
        #50;
        $finish;
    end

    initial
    begin
        $dumpfile("control.vcd");
        $dumpvars(0, dut);
    end
    endmodule
/*
module tb_Control_unit;

--testing for the controls transition
    // Declare the signals for the inputs and outputs
    logic clk;
    logic rst;
    logic cpu_request;
    logic cache_flush;
    logic dirty_bit;
    logic main_memory_ack;
    logic flush;
    logic cache_hit;
    logic cache_miss;
    logic flush_done;

    // Instantiate the Control_unit module
    Control_unit dut (
        .clk(clk),
        .rst(rst),
        .cpu_request(cpu_request),
        .cache_flush(cache_flush),
        .cache_miss(cache_miss),
        .dirty_bit(dirty_bit),
        .main_memory_ack(main_memory_ack),
        .flush(flush),
        .cache_hit(cache_hit),
        .flush_done(flush_done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period clock
    end

    // Initial block for simulation
    initial begin
        // Initialize signals
        rst = 1;
        cpu_request = 0;
        cache_flush = 0;
        dirty_bit = 0;
        main_memory_ack = 0;
        cache_miss=0;
        flush = 0;
        cache_hit = 0;


        // Apply reset
        @(posedge clk); 
        rst = 0;


        //test-case-1
        @(posedge clk); 
        cpu_request=1;
        @(posedge clk); 
        cpu_request=0;
        cache_hit = 1;
        @(posedge clk); 
        cache_hit = 0;


        //test-case-2
        @(posedge clk); 
        cpu_request=1;
        @(posedge clk); 
        cpu_request=0;
        @(posedge clk);
        cache_miss=1;
        dirty_bit=0;
        @(posedge clk);
        cache_miss=0;
        @(posedge clk);
        main_memory_ack=1;
        @(posedge clk);
        main_memory_ack=0;



        //test_case-2
        cache_miss=1;
        dirty_bit=1;
        @(posedge clk);
        cache_miss=0;
        @(posedge clk);
        main_memory_ack=0;
        @(posedge clk);
        main_memory_ack=1;
        flush=0;
        @(posedge clk);


        //ideal_flush_condition
        dirty_bit=0;
        cache_flush=1;








        $finish;
    end

    // Monitor block to observe the state transitions
    initial begin
        $monitor("Time: %0t, State: %0d", $time, dut.state);
    end

    initial
    begin
        $dumpfile("control.vcd");
        $dumpvars(0, dut);
    end

endmodule


*/
