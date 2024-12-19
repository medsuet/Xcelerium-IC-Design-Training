module cont_datapath_top(
    input  logic        clk,
    input  logic        reset,
    // Controller pinout
    input  logic        src_valid,
    output logic        src_ready,
    input  logic        cpu_req,
    input  logic        flush_req,
    input  logic        req_type,
    // Cache pinout
    input  logic [31:0] cpu_addr,
    input  logic [31:0] cpu_wdata,
    output logic [31:0] cpu_rdata,
    // Memory pinout
    output logic [31:0] mem_araddr,
    input  logic [31:0] mem_rdata,
    output logic [31:0] mem_awaddr,
    output logic [31:0] mem_wdata,
    // AXI pinout
    output logic        mem_wr_req,
    output logic        mem_rd_req,
    input  logic        axi_ack
);

// Controller <> Cache pinout
logic       flush_done;
logic       flush;
logic       dirty;
logic       cache_hit;
logic       index_sel;
logic [1:0] dirty_sel;
logic [1:0] valid_sel;
logic       data_sel;
logic       rd_en;
logic       wr_en;
logic       count_en;
logic       count_clear;
logic       valid_clear;

// Controller
cache_controller controller(
    .clk(clk),
    .rst(reset),
    .cpu_request(cpu_req),
    .src_valid(src_valid),
    .req_type(req_type),
    .cache_hit(cache_hit),
    .dirty(dirty),
    .axi_ack(axi_ack),
    .flush(flush),
    .flush_done(flush_done),
    .flush_req(flush_req),
    .src_ready(src_ready),
    .dirty_sel(dirty_sel),
    .valid_sel(valid_sel),
    .rd_en(rd_en),
    .wr_en(wr_en),
    .mem_wr_req(mem_wr_req),
    .index_sel(index_sel),
    .mem_rd_req(mem_rd_req),
    .data_sel(data_sel),
    .count_en(count_en),
    .count_clear(count_clear),
    .reg_flush_en(reg_flush_en),
    .valid_clear(valid_clear)
    );


// Datapath
cache_datapath datapath(
    .clk(clk),
    .reset(reset),
    // Processor Pinout
    .flush_req(flush_req),
    .cpu_addr(cpu_addr),
    .cpu_wdata(cpu_wdata),
    .cpu_rdata(cpu_rdata),
    // Cache Controller Pinout
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
    .valid_clear(valid_clear),
    // Memory Pinout
    .mem_araddr(mem_araddr),
    .mem_rdata(mem_rdata),
    .mem_awaddr(mem_awaddr),
    .mem_wdata(mem_wdata)
);

endmodule