module tb_cont_datapath();

logic        clk;
logic        reset;
logic        src_valid;
logic        src_ready;
logic        cpu_req;
logic        flush_req;
logic        req_type;
logic [31:0] cpu_addr;
logic [31:0] cpu_wdata;
logic [31:0] cpu_rdata;
logic [31:0] mem_araddr;
logic [31:0] mem_rdata;
logic [31:0] mem_awaddr;
logic [31:0] mem_wdata;
logic        mem_wr_req;
logic        mem_rd_req;
logic        axi_ack;

int simulation_run;
int j;

cont_datapath_top DUT(
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
    .mem_wr_req(mem_wr_req),
    .mem_rd_req(mem_rd_req),
    .axi_ack(axi_ack)
);

initial
begin
    clk = 0;
    forever #10 clk = !clk;
end

task reset_sequence();
    begin
        reset       <= #1 0;
        src_valid   <= #1 0;
        cpu_req     <= #1 0;
        flush_req   <= #1 0;
        req_type    <= #1 0;
        cpu_addr    <= #1 0;
        cpu_wdata   <= #1 0;
        mem_rdata   <= #1 0;
        axi_ack     <= #1 0;
        repeat (2) @(posedge clk);
        reset       <= #1 1;
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
        while (src_ready)
            @(posedge clk);
        src_valid       <= #1 0;
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
        while (src_ready)
            @(posedge clk);
        src_valid       <= #1 0;
        while (!src_ready)
            @(posedge clk);
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
        while (src_ready)
            @(posedge clk);
        src_valid       <= #1 0;
        while (!src_ready)
            @(posedge clk);
    end
endtask

task mem_driver();
    begin
        while (simulation_run)
        begin
            @(posedge clk);
            if (mem_rd_req)
                begin
                    mem_rdata <= #1 $random;
                    @(posedge clk);
                    axi_ack <= #1 1;
                    @(posedge clk);
                    axi_ack <= #1 0;
                end
            else if (mem_wr_req)
                begin
                    @(posedge clk);
                    axi_ack <= #1 1;
                    @(posedge clk);
                    axi_ack <= #1 0;
                end
            else
                axi_ack <= #1 0;
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
    @(negedge reset);
    simulation_run = 1;
    @(posedge reset);
    @(posedge clk);

    //cache_read(20'd2,10'd1,2'd0);

    //cache_write(20'd2,10'd1,2'd0,32'd3);
    
    for (j=0; j<1024; j++)
    begin
        cache_write(j,j,2'd0,$random);
    end
    
    
    for (j=0; j<1024; j++)
    begin
        cache_write(j+1,j,2'd0,$random);
    end
    

    cache_flush();

    $stop;
    simulation_run = 0;
    $finish;
end

endmodule