module cache_top(
    input  logic        clk,
    input  logic        reset,
    // Processor - Controller pinout
    input  logic        src_valid,
    output logic        src_ready,
    input  logic        cpu_req,
    input  logic        flush_req,
    input  logic        req_type,
    // Processor - Cache pinout
    input  logic [31:0] cpu_addr,
    input  logic [31:0] cpu_wdata,
    output logic [31:0] cpu_rdata,
    // Memory - Cache pinout
    output logic [31:0] mem_araddr,
    input  logic [31:0] mem_rdata,
    output logic [31:0] mem_awaddr,
    output logic [31:0] mem_wdata,
    // Memory - AXI Controller pinout
    input  logic        mem_wready,
    input  logic        mem_bresp,
    input  logic        mem_bvalid,
    input  logic        mem_awready,
    input  logic        mem_rresp,
    input  logic        mem_rvalid,
    input  logic        mem_arready,
    output logic        axi_arvalid,
    output logic        axi_rready,
    output logic        axi_awvalid,
    output logic        axi_wvalid,
    output logic        axi_bready
);

// Cache Controller <> Cache pinout
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
logic       flush_sel;

// AXI Controller <> Cache Controller pinout
logic mem_rd_req;
logic mem_wr_req;
logic axi_ack;

// AXI Controller
AXI_controller  AXI_CON(
.clk        (clk),
.rst        (reset),
.w_req      (mem_wr_req),
.aw_ready   (mem_awready),
.w_ready    (mem_wready),
.b_valid    (mem_bvalid),
.r_req      (mem_rd_req),
.ar_ready   (mem_arready),
.r_valid    (mem_rvalid),
.aw_valid   (axi_awvalid),
.w_valid    (axi_wvalid),
.b_ready    (axi_bready),
.ar_valid   (axi_arvalid),
.r_ready    (axi_rready),
.ack        (axi_ack)
);


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
    .flush_sel(flush_sel),
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
    .flush_sel(flush_sel),
    .valid_clear(valid_clear),
    // Memory Pinout
    .mem_araddr(mem_araddr),
    .mem_rdata(mem_rdata),
    .mem_awaddr(mem_awaddr),
    .mem_wdata(mem_wdata)
);


endmodule