
`include "../param/sb_defs.svh"

module store_buffer_tb ();

    parameter NUM_RAND_TESTS = 12;
    parameter RAND_DELAY = 0;
    parameter RANDOM_SEED = 1;
    parameter ADDR_RANGE = 10;

// Signals
    logic                        clk;
    logic                        rst_n;
    logic                        dmem_sel_i;
    logic                        dcache_flush_i;
    logic                        dcache_kill_i;
    logic                        dmem_sel_o;
    logic                        dcache_flush_o;
    logic                        dcache_kill_o;
    // LSU/MMU to store buffer interface
    type_lsummu2dcache_s         lsummu2sb_i;
    type_dcache2lsummu_s         sb2lsummu_o;
    // store buffer to data cache interface
    type_dcache2lsummu_s         dcache2sb_i;
    type_lsummu2dcache_s         sb2dcache_o;

// Instantization
    store_buffer DUT (
        .clk                     (clk),
        .rst_n                   (rst_n),
        .dmem_sel_i              (dmem_sel_i),
        .dcache_flush_i          (dcache_flush_i),
        .dcache_kill_i           (dcache_kill_i),
        .dmem_sel_o              (dmem_sel_o),
        .dcache_flush_o          (dcache_flush_o),
        .dcache_kill_o           (dcache_kill_o),
        .lsummu2sb_i             (lsummu2sb_i),
        .sb2lsummu_o             (sb2lsummu_o),
        .dcache2sb_i             (dcache2sb_i),
        .sb2dcache_o             (sb2dcache_o)
    );

// Generate clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

// Tests
    initial begin
        $urandom(RANDOM_SEED);
        init_sequence();
        reset_sequence();
        @(posedge clk);

        fork
            test_random_load_store();
            // Directed test
            // begin
            //     store_data(1,1,100);
            //     store_data(2,1,200);
            //     load_data(2,1);
            // end
            dummy_dcache();
            monitor();
        join_any

        $display("\nTests passed.\n");

        repeat (5) @(posedge clk);
        $stop();
    end
    
    // Task to send random load/store requests to store buffer
    int i;
    task test_random_load_store();
        for (i=0; i<NUM_RAND_TESTS; i++) begin
            if ($urandom() % 2)
                store_data($urandom() % ADDR_RANGE, $urandom(), $urandom());
            else
                load_data($urandom() % ADDR_RANGE, $urandom());
            
            repeat($urandom() % RAND_DELAY + 1) @(posedge clk);
        end
    endtask

    // Task to monitor accuracy of data. Error if loaded data is not equal to stored data.
    //int monitor_mem[int];
    logic [31:0]monitor_mem[0:31];
    task monitor();
        forever begin
            while (!(lsummu2sb_i.req))
                @(posedge clk);
            
            if (lsummu2sb_i.w_en) begin
                monitor_mem[lsummu2sb_i.addr] = lsummu2sb_i.w_data;
            end
            if (!lsummu2sb_i.w_en) begin
                while (!sb2lsummu_o.ack)
                    @(posedge clk);
                if (monitor_mem[lsummu2sb_i.addr] != sb2lsummu_o.r_data) begin
                    $display("\nTest failed: %d.\n",i);
                    #1 $stop();
                end
            end
            @(posedge clk);
        end
    endtask

    // Task to send data to store buffer
    task store_data(int addr, int sel_byte, int w_data);
        lsummu2sb_i.addr = addr;
        lsummu2sb_i.w_data = w_data;
        lsummu2sb_i.sel_byte = sel_byte;
        lsummu2sb_i.w_en = 1;
        lsummu2sb_i.req = 1;

        @(posedge clk);
        while (!(sb2lsummu_o.ack))
            @(posedge clk);
        
        lsummu2sb_i.w_en = 0;
        lsummu2sb_i.req = 0;
    endtask

    // Task to send load data request to store buffer
    task load_data(int addr, int sel_byte);
        lsummu2sb_i.addr = addr;
        lsummu2sb_i.w_data = 'x;
        lsummu2sb_i.sel_byte = sel_byte;
        lsummu2sb_i.w_en = 0;
        lsummu2sb_i.req = 1;

        @(posedge clk)
        while (!(sb2lsummu_o.ack))
            @(posedge clk);
        
        $display("\nr_data = %d\n",sb2lsummu_o.r_data);
        lsummu2sb_i.w_en = 0;
        lsummu2sb_i.req = 0;
    endtask

    // Task to simulate performance of cache
    int dcache[int];
    task dummy_dcache();
        forever begin
            dcache2sb_i.ack = 0;
            while (!sb2dcache_o.req)
                @(posedge clk)

            repeat($urandom() % RAND_DELAY) @(posedge clk);

            if (sb2dcache_o.w_en) begin
                dcache[sb2dcache_o.addr] = sb2dcache_o.w_data;
            end
            else begin
                dcache2sb_i.r_data = dcache[sb2dcache_o.addr];
            end
            dcache2sb_i.ack = 1;
            @(posedge clk);
        end
    endtask

    
    task reset_sequence();
        #7;
        rst_n = 0;
        #25;
        rst_n = 1;
    endtask

    task init_sequence();
        rst_n = 1;
        lsummu2sb_i.w_en = 0;
        lsummu2sb_i.req = 0;
    endtask

endmodule