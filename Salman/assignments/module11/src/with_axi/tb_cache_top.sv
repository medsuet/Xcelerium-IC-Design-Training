module tb_cache_top();

logic        clk;
logic        reset;
// Processor - Controller pinout
logic        src_valid;
logic        src_ready;
logic        cpu_req;
logic        flush_req;
logic        req_type;
// Processor - Cache pinout
logic [31:0] cpu_addr;
logic [31:0] cpu_wdata;
logic [31:0] cpu_rdata;
// Memory - Cache pinout
logic [31:0] mem_araddr;
logic [31:0] mem_rdata;
logic [31:0] mem_awaddr;
logic [31:0] mem_wdata;
// Memory - AXI Controller pinout
logic        mem_wready;
logic        mem_bresp;
logic        mem_bvalid;
logic        mem_awready;
logic        mem_rresp;
logic        mem_rvalid;
logic        mem_arready;
logic        axi_arvalid;
logic        axi_rready;
logic        axi_awvalid;
logic        axi_wvalid;
logic        axi_bready;

cache_top DUT(
.clk(clk),
.reset(reset),
.src_valid(src_valid),
.src_ready(src_ready),
.cpu_req(cpu_req),
.flush_req(flush_req),
.req_type(req_type),
.cpu_addr(cpu_addr),
.cpu_wdata(cpu_wdata),
.cpu_rdata(cpu_rdata),
.mem_araddr(mem_araddr),
.mem_rdata(mem_rdata),
.mem_awaddr(mem_awaddr),
.mem_wdata(mem_wdata),
.mem_wready(mem_wready),
.mem_bresp(mem_bresp),
.mem_bvalid(mem_bvalid),
.mem_awready(mem_awready),
.mem_rresp(mem_rresp),
.mem_rvalid(mem_rvalid),
.mem_arready(mem_arready),
.axi_arvalid(axi_arvalid),
.axi_rready(axi_rready),
.axi_awvalid(axi_awvalid),
.axi_wvalid(axi_wvalid),
.axi_bready(axi_bready)
);

int main_memory [int];              // Associative array for main memory
int ref_memory [int];               // Associative array as reference memory
int simulation_run;
int j;

initial
begin
    clk = 0;
    forever #10 clk = !clk;
end

task reset_sequence();
    begin
        reset       <= #1 0;
        repeat (2) @(posedge clk);
        reset       <= #1 1;
    end
endtask

task init_sequence();
    begin
        reset       <= #1 1;
        src_valid   <= #1 0;
        cpu_req     <= #1 0;
        flush_req   <= #1 0;
        req_type    <= #1 0;
        cpu_addr    <= #1 0;
        cpu_wdata   <= #1 0;
        mem_rdata   <= #1 0;
        mem_wready  <= #1 0; 
        mem_bresp   <= #1 0;
        mem_bvalid  <= #1 0;
        mem_awready <= #1 0;
        mem_rresp   <= #1 0;
        mem_rvalid  <= #1 0;
        mem_arready <= #1 0;
        @(posedge clk);
    end
endtask

task cache_read(input logic [19:0] tag_in, input logic [9:0] index_in, input logic [1:0] offset_in);
    begin
        src_valid       <= #1 1;
        cpu_req         <= #1 1;
        req_type        <= #1 0;
        cpu_addr        <= #1 {tag_in, index_in, offset_in};
        cpu_wdata       <= #1 0;
        flush_req       <= #1 0;
        while (!src_ready)
            @(posedge clk);
        @(posedge clk);
        src_valid       <= #1 0;
        while (src_ready)
            @(posedge clk);
        while (!src_ready)
            @(posedge clk);
    end
endtask

task cache_write(input logic [19:0] tag_in, input logic [9:0] index_in, input logic [1:0] offset_in, input logic [31:0] data_in);
    begin
        src_valid       <= #1 1;
        cpu_req         <= #1 1;
        req_type        <= #1 1;
        cpu_addr        <= #1 {tag_in, index_in, offset_in};
        cpu_wdata       <= #1 data_in;
        flush_req       <= #1 0;
        while (!src_ready)
            @(posedge clk);
        @(posedge clk);
        src_valid       <= #1 0;
        while (src_ready)
            @(posedge clk);
        while (!src_ready)
            @(posedge clk);
        // Send cache read request after cache write
        cache_read(tag_in,index_in,offset_in);
    end
endtask

task cache_flush();
    begin
        src_valid       <= #1 1;
        cpu_req         <= #1 0;
        req_type        <= #1 0;
        cpu_addr        <= #1 0;
        cpu_wdata       <= #1 0;
        flush_req       <= #1 1;
        while (!src_ready)
            @(posedge clk);
        @(posedge clk);
        src_valid       <= #1 0;
        while (src_ready)
            @(posedge clk);
        while (!src_ready)
            @(posedge clk);
        flush_req       <= #1 0;
    end
endtask

task random_test(int count);
    int i;
    logic [2:0]     num;
    logic [19:0]    random_tag;
    logic [9:0]     random_index;
    logic [1:0]     random_offset;
    logic [31:0]     random_data;
    begin
        for (i=1; i<=count; i++)
            begin
                //while (!src_ready)
                //    @(posedge clk);
                @(posedge clk);
                num = $random();
                //$display(" -------------------------------------------");
                //$display(" ------    Running Test Number %2d    ------",i);
                $write("Test Number %1d | ",i);
                //$display(" -------------------------------------------");
                // Randon tag,index,offset,data
                random_tag      = $random();
                random_index    = $random();
                random_offset   = $random();
                random_data     = $random();
                if (num == 1)
                    begin
                        cache_flush();
                    end
                else if (num%2)
                    begin
                        cache_read(random_tag,random_index,random_offset);
                    end
                else
                    begin
                        cache_write(random_tag,random_index,random_offset,random_data);
                    end
            end
        while (!src_ready)
            @(posedge clk);
        @(posedge clk);
        $display(" -------------------------------------------");
        $display(" ------      All tests complete!      ------");
        $display(" -------------------------------------------");
    end
endtask

task read_driver();
    logic [2:0]     random_delay;
    logic [31:0]    cache2mem_addr;
    begin
        while (simulation_run)
        begin
            // Wait for axi_arvalid - Memory Read operation
            while (!axi_arvalid)
                @(posedge clk);

            // Assert arready after random delay
            random_delay = $random;
            repeat (random_delay) @(posedge clk);
            mem_arready <= #1 1;

            // Store address during handshake
            @(negedge clk);
            cache2mem_addr = mem_araddr;
            @(posedge clk);
            mem_arready <= #1 0;

            // Confirm if rready is asserted by controller
            while (!axi_rready)
                @(posedge clk);

            // Assert rdata and rvalid after random delay
            random_delay = $random;
            repeat (random_delay) @(posedge clk);

            // Confirm if the address key in memory exists, otherwise create one
            if (!main_memory.exists(cache2mem_addr))
                begin
                    main_memory[cache2mem_addr] = $random;
                end

            // Read the data
            mem_rdata   <= #1 main_memory[cache2mem_addr];
            mem_rvalid  <= #1 1;

            // Deassert rvalid as handshake occurs
            @(posedge clk);
            mem_rvalid  <= #1 0;
            mem_rdata   <= #1 0; 
        end
    end
endtask

task write_driver();
    logic [2:0]     random_delay;
    logic [31:0]    cache2mem_addr;
    logic [31:0]    cache2mem_data;
    begin
        while (simulation_run)
        begin
            // Wait for axi_awvalid - Memory Write operation
            while (!axi_awvalid)
                @(posedge clk);
            
            // Assert awready after random delay
            random_delay = $random;
            repeat (random_delay) @(posedge clk);
            mem_awready <= #1 1;

            // Store address during handshake
            @(negedge clk);
            cache2mem_addr = mem_awaddr;
            @(posedge clk);
            mem_awready <= #1 0;

            // Confirm if controller asserted wvalid
            while (!axi_wvalid)
                @(posedge clk);

            // Assert wready and store data in memory after random delay
            random_delay = $random;
            repeat (random_delay) @(posedge clk);
            mem_wready <= #1 1;

            // Store data during handshake
            @(negedge clk);
            cache2mem_data = mem_wdata;

            // Deassert wready after handshake occurs
            @(posedge clk);
            mem_wready <= #1 0;

            // Confirm if controller asserted bready
            while (!axi_bready)
            @(posedge clk);
                    
            // Store in main_memory and assert bresp after after random delay
            random_delay = $random;
            repeat (random_delay) @(posedge clk);
            main_memory[cache2mem_addr] = cache2mem_data;
            mem_bresp <= #1 1;

            // Assert bvalid
            @(posedge clk);
            mem_bvalid <= #1 1;

            // Deassert bvalid
            @(posedge clk);
            mem_bvalid <= #1 0;
        end
    end
endtask

task monitor();
    logic [9:0]     monitor_cpu_index           ;
    logic [19:0]    monitor_cpu_tag             ;
    logic [31:0]    monitor_cpu_wdata           ;
    logic [31:0]    monitor_cache_rdata         ;
    logic [31:0]    monitor_cache_wdata         ;
    logic [31:0]    monitor_mem_rdata           ;
    logic [31:0]    monitor_mem_wdata           ;
    logic [31:0]    monitor_mem_araddr          ;
    logic [31:0]    monitor_mem_awaddr          ;
    begin
        while (simulation_run)
        begin
            while (!(src_ready & src_valid))
                @(posedge clk);
            // ---------------------------------
            // ----- IN CASE OF  FLUSH REQ -----
            // ---------------------------------
            // FLUSH request can only be tested by verifying its completion only
            // Since every memory region is invisible in case of flush
            // We will empty the reference memory only in that case
            if (flush_req)
                begin
                    foreach(ref_memory[key])
                        ref_memory[key] = 0;
                    @(posedge clk);
                    // Wait for flush request to complete
                    while (!src_ready)
                        @(posedge clk);
                    $display("Succesfull | Cache Flush | Flushed the whole cache memory!");
                end
            // ---------------------------------
            // ----- IN CASE OF CACHE READ -----
            // ---------------------------------
            else if (!req_type)
                begin
                    monitor_cpu_tag     = cpu_addr[31:12];
                    monitor_cpu_index   = cpu_addr[11:2];
                    @(posedge clk);
                    // Wait for Cache Read operation to complete.
                    while (!src_ready)
                        begin
                            monitor_cache_rdata = cpu_rdata;        // Keep storing prev cycle's cpu_rdata value
                            @(posedge clk);
                            // In case of Cache Allocate
                            if (axi_arvalid)
                                begin
                                    // Wait for Cache Allocate to complete
                                    monitor_mem_araddr = mem_araddr;
                                    while (!(axi_rready & mem_rvalid))
                                        @(posedge clk);
                                    // Once cache allocate is complete, data from main_memory will be stored in Cache Memory
                                    // Store the same data in reference memory for further checks
                                    ref_memory[monitor_cpu_index] = main_memory[monitor_mem_araddr];
                                end
                        end
                    // Once Cache Read operation is complete, compare cpu_rdata with reference memory.
                    if (ref_memory[monitor_cpu_index] != monitor_cache_rdata)
                        begin
                            $display("Error | Cache Read | INDEX = %d | TAG = %d | CPU_RDATA = %d | REF_MEMORY DATA = %1d",monitor_cpu_index, monitor_cpu_tag, monitor_cache_rdata,ref_memory[monitor_cpu_index]);
                            $error();
                            $stop();
                        end
                    $display("Succesfull | Cache Read  | CPU_RDATA = %1d",monitor_cache_rdata);
                end
            // ----------------------------------
            // ----- IN CASE OF CACHE WRITE -----
            // ----------------------------------
            // Read routine for same cache index will be sent after each Cache Write Routine
            // This routine will ensure success of Cache Write w/o exiting DUT Boundary
            else if (req_type)
                begin
                    monitor_cpu_tag     = cpu_addr[31:12];
                    monitor_cpu_index   = cpu_addr[11:2];
                    monitor_cpu_wdata   = cpu_wdata;
                    @(posedge clk);
                    // Wait for Cache Write operation to complete.
                    while (!(src_ready & src_valid))
                        begin
                            @(posedge clk);
                        end
                    ref_memory[monitor_cpu_index] = monitor_cpu_wdata;
                    // Wait for next Cache Ready operation to complete
                    @(posedge clk);
                    while (!src_ready)
                        begin
                            monitor_cache_rdata = cpu_rdata;        // Keep storing prev cycle's cpu_rdata
                            @(posedge clk);
                        end
                    if (ref_memory[monitor_cpu_index] != monitor_cache_rdata)
                        begin
                            $display("Error | Cache Write | INDEX = %d | TAG = %d | CPU_WDATA = %d | CPU_RDATA = %1d",monitor_cpu_index,monitor_cpu_tag,monitor_cpu_wdata,monitor_cache_rdata);
                            $error();
                            $stop();
                        end
                    $display("Succesfull | Cache Write | CPU_WDATA = %1d",monitor_cpu_wdata);
                end
            else
                begin
                    $display("Illegal Instruction | Ending Simulation...");
                    $error();
                    $stop();
                end
        end
    end
endtask;

initial
begin
    init_sequence();
    reset_sequence();
    fork
        read_driver();
        write_driver();
        monitor();
    join
end


initial
begin
    @(negedge reset);
    simulation_run = 1;
    @(posedge reset);
    @(posedge clk);

    // ------------------------------------------
    // ------------- DIRECTED TESTS -------------
    // ------------------------------------------
    
    cache_read(20'd2,10'd1,2'd0);

    cache_write(20'd2,10'd1,2'd0,32'd3);
    
    // Test for Cache Allocate
    for (j=0; j<1024; j++)
    begin
        cache_write(j,j,2'd0,$random);
    end
    
    
    // Test for Writeback Stage - Uncomment previous loop before using this.
    for (j=0; j<1024; j++)
    begin
        cache_write(j+1,j,2'd0,$random);
    end
    
    
    
    // Reading whole cache - Cache Hit test
    for (j=0; j<1024; j++)
    begin
        cache_read(j+1,j,2'd0);
    end
    
    
    
    cache_flush();
    
    
    // ------------------------------------------
    // -------------- RANDOM TESTS --------------
    // ------------------------------------------
    @(posedge clk);
    random_test(100000);

    repeat (10) @(posedge clk);
    simulation_run = 0;
    $stop;
    $finish;
end


endmodule