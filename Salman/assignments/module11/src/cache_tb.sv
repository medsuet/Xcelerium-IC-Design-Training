module cache_tb;

    logic clk;
    logic rst;
    logic cpu_req;
    logic req_type;
    logic flush;
    logic [31:0] addr;
    logic [31:0] w_data;
    logic [31:0] r_data;
    logic stall;
    logic mem_rd;
    logic [127:0] mem2cache_data;
    logic main_mem_ack;

    int simulation_run;
    int j;

cache_top DUT(
    .clk(clk),
    .rst(rst),
    .cpu_req(cpu_req),
    .req_type(req_type),
    .flush(flush),
    .addr(addr),
    .w_data(w_data),
    .r_data(r_data),
    .stall(stall),
    .mem_rd(mem_rd),
    .mem2cache_data(mem2cache_data),
    .main_mem_ack(main_mem_ack)
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
        flush           <= #1 0;
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
        flush           <= #1 0;
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

task cache_write(input logic [19:0] tag_in, input logic [7:0] index_in, input logic [3:0] offset_in, input logic [31:0] data_in);
    begin
        while (stall)
            @(posedge clk);
        @(posedge clk);
        cpu_req         <= #1 1;
        req_type        <= #1 1;
        addr            <= #1 {tag_in, index_in, offset_in};
        flush           <= #1 0;
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

task mem_driver();
    begin
        while (simulation_run)
        begin
            @(posedge clk);
            if (mem_rd)
                begin
                    mem2cache_data <= #1 $random;
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
        cache_write(j,j,4'd0,$random);
    end

    $stop;
    simulation_run = 0;
    $finish;
end

endmodule