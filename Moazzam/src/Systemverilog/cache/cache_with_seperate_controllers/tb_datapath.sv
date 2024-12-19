module tb_datapath;

    logic            clk,
    logic            reset,
    // Processor Pinout
    logic            flush_req,
    logic [31:0]     cpu_addr,
    logic [31:0]     cpu_wdata,
    logic [31:0]     cpu_rdata,
    // Cache Controller Pinout
    logic            flush_done,
    logic            flush,
    logic            dirty,
    logic            cache_hit,
    logic            index_sel,
    logic [1:0]      dirty_sel,
    logic [1:0]      valid_sel,
    logic            data_sel,
    logic            rd_en,
    logic            wr_en,
    logic            count_en,
    logic            count_clear,
    logic            reg_flush_en;
    // Memory Pinout
    logic [31:0]     mem_araddr,         // Address Read
    logic [31:0]     mem_rdata,          // Read Data
    logic [31:0]     mem_awaddr,         // Address Write
    logic [31:0]     mem_wdata           // Write Data

cache_datapath DUT(
    .clk(clk),
    .rst(rst),
    .flush_req(flush_req),
    .cpu_addr(cpu_addr),
    .cpu_wdata(cpu_wdata),
    .cpu_rdata(cpu_rdata),
    .flush_done(flush_done),
    .flush(flush),
    .dirty(dirty),
    .cache_hit(cache_hit),
    .index_sel(index_sel),
    .dirty_sel(dirty_sel),
    .valid_sel(valid_sel),
    .data_sel(data_sel),
    .rd_en(rd_en),
    .wr_en(wr_en),
    .count_en(count_en),
    .count_clear(count_clear),
    .reg_flush_en(reg_flush_en),
    .mem_araddr(mem_araddr),
    .mem_rdata(mem_rdata),
    .mem_awaddr(mem_awaddr),
    .mem_wdata(mem_wdata)
);




initial
begin
    clk = 0;
    forever #10 clk = !clk;
end

task reset_sequence();
    begin
        rst             <= #1 0;
        flush_req       <= #1 0;
        cpu_addr        <= #1 0;
        cpu_wdata       <= #1 0;
        index_sel       <= #1 0;
        dirty_sel       <= #1 0;
        valid_sel       <= #1 0;
        data_sel        <= #1 0;
        rd_en           <= #1 0;
        wr_en           <= #1 0;
        count_en        <= #1 0;
        count_clear     <= #1 0;
        reg_flush_en    <= #1 0;
        mem_rdata       <= #1 0;
        repeat (2) @(posedge clk);
        rst             <= #1 1;
    end
endtask

task cache_hit_read(input logic [19:0] tag_in, input logic [9:0] index_in, input logic [1:0] offset_in);
    begin
        while (rd_en)           // Confirm if rd_en is previously not one.
            @(posedge clk);
        rd_en       <= #1 1;
        cpu_addr    <= #1 {tag_in,index_in,offset_in};
        @(posedge clk);
        rd_en       <= #1 0;
        cpu_addr    <= #1 0;
        @(posedge clk);
    end
endtask

task cache_miss_read(input logic [19:0] tag_in, input logic [9:0] index_in, input logic [1:0] offset_in);
    begin
        while (rd_en)           // Confirm if rd_en is previously not one.
            @(posedge clk);
        rd_en       <= #1 1;
        cpu_addr    <= #1 {tag_in,index_in,offset_in};
        @(posedge clk);         // Right now we're assuming that axi_ack signal arrives after 1 clock cycle
        rd_en       <= #1 0;
        cpu_addr    <= #1 0;
        @(posedge clk);
    end
endtask

task cache_hit_write(input logic [19:0] tag_in, input logic [9:0] index_in, input logic [1:0] offset_in);
    begin
        while (wr_en)
            @(posedge clk);
        wr_en       <= #1 1;
        cpu_addr    <= #1 {tag_in,index_in,offset_in};
        @(posedge clk);
        wr_en       <= #1 0;
        cpu_addr    <= #1 0;
        @(posedge clk);
    end
endtask

task cache_miss_write(input logic [19:0] tag_in, input logic [9:0] index_in, input logic [1:0] offset_in);
    begin
        while (wr_en)
            @(posedge clk);
        data_sel    <= #1 1;
        wr_en       <= #1 1;
        cpu_addr    <= #1 {tag_in,index_in,offset_in};
        @(posedge clk);
        data_sel    <= #1 0;
        wr_en       <= #1 0;
        cpu_addr    <= #1 0;
        @(posedge clk);
    end
endtask

task cache_flush();
    begin
        while (flush_req)
            @(posedge clk);
        flush_req       <= #1 1;
        @(posedge clk);
        flush_req       <= #1 0;
    end
endtask

task write_driver();
    begin
        while (simulation_run)
        begin
            @(posedge clk);
            if (wr_en)
                begin
                    if (data_sel)
                        begin
                            dirty_sel <= #1 0;
                            valid_sel <= #1 2'b10;
                        end
                    else
                        begin
                            dirty_sel <= #1 2'b10;
                            valid_sel <= #1 2'b10;
                        end
                end
            else
                begin
                    dirty_sel <= #1 0;
                    valid_sel <= #1 0;
                end
        end
    end
endtask

task flush_driver();
    begin
        while (simulation_run)
        begin
            @(posedge clk);
            if (flush_req)
                reg_flush_en    <= #1 1;
                index_sel       <= #1 1;
            else
                if (flush_done)
                    begin
                        reg_flush_en    <= #1 1;
                        index_sel       <= #1 0;
                    end
                else
                    begin
                        reg_flush_en <= #1 0;
                        if (flush)
                            begin
                                index_sel <= #1 1;
                                if (dirty)
                                    begin
                                        count_en    <= #1 0;
                                        @(posedge clk);
                                        rd_en       <= #1 1;
                                        @(posedge clk);
                                        rd_en       <= #1 0;
                                        dirty_sel   <= #1 2'b01;
                                    end
                                else
                                    begin
                                        dirty_sel   <= #1 0;
                                        count_en    <= #1 1;
                                    end
                            end
                    end
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