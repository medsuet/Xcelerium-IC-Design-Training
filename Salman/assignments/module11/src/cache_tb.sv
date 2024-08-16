module cache_tb;

    logic clk;
    logic rst;
    logic cpu_req;
    logic req_type;
    logic flush_req;
    logic [31:0] addr;
    logic [127:0] w_data;
    logic [31:0] r_data;
    logic stall;
    logic mem_rd;
    logic mem_wr;
    logic [127:0] mem2cache_data;
    logic main_mem_ack;
    logic [127:0] cache2mem_data;
    logic [31:0]  cache2mem_addr;

    int simulation_run;
    int j;
    logic [127:0] write;

    logic [127:0] mem_wdata;
    logic [31:0] mem_waddr;

cache_top DUT(
    .clk(clk),
    .rst(rst),
    .flush_req(flush_req),
    .cpu_req(cpu_req),
    .req_type(req_type),
    .addr(addr),
    .w_data(w_data),
    .r_data(r_data),
    .stall(stall),
    .mem_rd(mem_rd),
    .mem_wr(mem_wr),
    .mem2cache_data(mem2cache_data),
    .main_mem_ack(main_mem_ack),
    .cache2mem_data(cache2mem_data),
    .cache2mem_addr(cache2mem_addr)
);


initial
begin
    clk = 0;
    forever #10 clk = !clk;
end

task reset_sequence();
    begin
        rst <= #1 0;
        cpu_req         <= #1 0;
        req_type        <= #1 0;
        addr            <= #1 0;
        flush_req       <= #1 0;
        w_data          <= #1 0;
        mem2cache_data  <= #1 0;
        repeat (2) @(posedge clk);
        rst <= #1 1;
    end
endtask

task cache_read(input logic [19:0] tag_in, input logic [7:0] index_in, input logic [3:0] offset_in);
    begin
        while (stall)
            @(posedge clk);
        @(posedge clk);
        cpu_req         <= #1 1;
        req_type        <= #1 0;
        addr            <= #1 {tag_in, index_in, offset_in};
        flush_req       <= #1 0;
        w_data          <= #1 0;
        mem2cache_data  <= #1 0;
        @(posedge clk);
        while (!stall)
            @(posedge clk);
        @(posedge clk);
        cpu_req <= #1 0;
        while (stall)
            @(posedge clk);
    end
endtask

task cache_write(input logic [19:0] tag_in, input logic [7:0] index_in, input logic [3:0] offset_in, input logic [127:0] data_in);
    begin
        while (stall)
            @(posedge clk);
        @(posedge clk);
        cpu_req         <= #1 1;
        req_type        <= #1 1;
        addr            <= #1 {tag_in, index_in, offset_in};
        flush_req       <= #1 0;
        w_data          <= #1 data_in;
        mem2cache_data  <= #1 0;
        @(posedge clk);
        while (!stall)
            @(posedge clk);
        @(posedge clk);
        cpu_req <= #1 0;
        while (stall)
            @(posedge clk);
    end
endtask

task cache_flush();
    begin
        while (stall)
            @(posedge clk);
        @(posedge clk);
        cpu_req         <= #1 0;
        req_type        <= #1 0;
        addr            <= #1 0;
        flush_req       <= #1 1;
        w_data          <= #1 0;
        mem2cache_data  <= #1 0;
        @(posedge clk);
        while (!stall)
            @(posedge clk);
        @(posedge clk);
        flush_req <= #1 0;
        while (stall)
            @(posedge clk);
    end
endtask

task mem_driver();
    begin
        while (simulation_run)
        begin
            @(posedge clk);
            if (mem_rd)
                begin
                    mem2cache_data[31:0]    <= #1 $random;
                    mem2cache_data[63:32]   <= #1 $random;
                    mem2cache_data[95:64]   <= #1 $random;
                    mem2cache_data[127:96]  <= #1 $random;
                    @(posedge clk);
                    main_mem_ack <= #1 1;
                end
            else if (mem_wr)
                begin
                    mem_wdata = cache2mem_data;
                    mem_waddr = cache2mem_addr;
                    @(posedge clk);
                    main_mem_ack <= #1 1;
                end
            else
                main_mem_ack <= #1 0;
        end
    end
endtask


initial
begin
    reset_sequence();
    mem_driver();
end


initial
begin
    @(negedge rst);
    simulation_run = 1;
    @(posedge rst);
    @(posedge clk);

    //cache_read(20'd2,8'd1,4'd0);

    //cache_write(20'd2,8'd1,4'd0,32'd3);
    for (j=0; j<256; j++)
    begin
        write [31:0]    <= #1 $random;
        write [63:32]   <= #1 $random;
        write [95:64]   <= #1 $random;
        write [127:96]  <= #1 $random;
        cache_write(j,j,4'd0,write);
    end

    for (j=0; j<256; j++)
    begin
        write [31:0]    <= #1 $random;
        write [63:32]   <= #1 $random;
        write [95:64]   <= #1 $random;
        write [127:96]  <= #1 $random;
        cache_write(j+1,j,4'd0,write);
    end

    cache_flush();

    $stop;
    simulation_run = 0;
    $finish;
end

endmodule