module top_cache(input logic clk,
            input  logic        rst,
            input  logic        valid,
            input  logic [31:0] addr,
            input  logic [6:0]  opcode,
            input  logic        flush,
            input  logic [31:0] wr_data,

            output logic [31:0] r_data,
            output logic        ready
);


logic cpu_request, cache_hit, rd_dcache, rd_req, wr_req, cache_miss, valid_ff, dirty_ff, en, flushing, flush_done, bvalid;
logic [31:0] addr_mem;
logic d_clear, tag_en, en_line, arvalid, arready, rvalid, rready;
logic awvalid, awready, wvalid, wready, bready;
logic [127:0] r_mem_data, wr_mem_data;
logic rd_mem_req, wr_mem_req, wr_rd_mem_req;
logic init;

cache_init dp(
            .clk(clk),
            .rst(rst),
            .opcode(opcode),
            .addr(addr),
            .cpu_request(cpu_request),
            .cache_hit(cache_hit),
            .rd_req(rd_req),
            
            .wr_req(wr_req),
            .wr_data(wr_data),
            .r_data(r_data),
            .cache_miss(cache_miss),
            .valid_ff(valid_ff),
            .dirty_ff(dirty_ff),
            .en(en),
            .r_mem_data(r_mem_data),
            .wr_mem_data(wr_mem_data),
            .flushing(flushing),
            .flush_done(flush_done),
            .bvalid(bvalid),
            .init(init),
            
            .addr_mem(addr_mem),
            .arvalid(arvalid),
            .rd_dcache(rd_dcache),
            .wr_dcache(wr_dcache),

            .d_clear(d_clear),
            .tag_en(tag_en),
            .en_line(en_line),
            .awvalid(awvalid),
            .wvalid(wvalid)
);


mem memory(
            .clk(clk),
            .rst(rst),
            .arvalid(arvalid),
            .rvalid(rvalid),
            .arready(arready),
            .rready(rready),
            .bvalid(bvalid),
            .addr_mem(addr_mem),
            .r_mem_data(r_mem_data),
            .wr_mem_data(wr_mem_data),

            .wvalid(wvalid),
            .wready(wready),
            .bready(bready),
            .awvalid(awvalid),
            .awready(awready)
);


cache_ctrl ctrl(
            .clk(clk),
            .rst(rst),
            .valid(valid),
            .cpu_request(cpu_request),
            .flush_done(flush_done),
            .cache_hit(cache_hit),
            .rd_dcache(rd_dcache),
            .rd_req(rd_req),
            .wr_req(wr_req), 
            .wr_dcache(wr_dcache),
            .cache_miss(cache_miss),
            .en(en),
            .valid_ff(valid_ff),
            .dirty_ff(dirty_ff),
            .flushing(flushing),
            .flush(flush),
            .ready(ready),
            .rd_mem_req(rd_mem_req),
            .init(init),
            
            .wr_mem_req(wr_mem_req),
            .wr_rd_mem_req(wr_rd_mem_rq),
            .ready_mem(ready_mem),
            .awvalid(awvalid),
            
            .wvalid(wvalid),
            .arvalid(arvalid),
            .bvalid(bvalid)
);


axi_ctrl axi(
            .clk(clk),
            .rst(rst),
            .d_clear(d_clear),
            .tag_en(tag_en),
            .en_line(en_line),
            .arvalid(arvalid),
            .rvalid(rvalid),
            .arready(arready),
            .rready(rready),
            .wvalid(wvalid),
            .bvalid(bvalid),
            .wready(wready),
            .bready(bready),
            .awvalid(awvalid),
            .awready(awready), 
            .ready_mem(ready_mem),
            .rd_mem_req(rd_mem_req),
            .wr_mem_req(wr_mem_req),
            .wr_rd_mem_req(wr_rd_mem_rq)
            
            );
endmodule