module cache_axi_controller (
    input logic  clk, n_rst,

    // cache Datapath -> cache controller
    input logic       cache_hit,
    input logic       dirty_bit,
    input logic       flush_done,

    // cpu -> cache controller
    input logic       cpu_rw,
    input logic       cpu_req,
    input logic       cpu_flush,

    // cache controller -> cache datapath 
    output logic      cpu_wr_req,
    output logic      flush_req,
    output logic      flush,
    output logic      mem_rw,
    output logic      cache_wr_en,
    output logic      cache_ready,
    output logic      flush_count_en,

    // testbench -> axi4 
    input logic aw_ready,
    input logic w_ready,
    input logic b_valid,
    input logic ar_ready,
    input logic r_valid,

    // axi4 -> testbench
    output logic aw_valid,
    output logic w_valid,
    output logic b_ready,
    output logic ar_valid,
    output logic r_ready,

    // axi controller -> cache controller
    output logic axi_ready
);

// cache controller -> axi controller
logic      start_write;
logic      start_read;

cache_controller cache_controller (
    .clk(clk), .n_rst(n_rst),

    // CPU -> cache_controller
    .cpu_req(cpu_req),  .cpu_rw(cpu_rw),
    .cpu_flush(cpu_flush),

    // cache controller -> cache datapath
    .cpu_wr_req(cpu_wr_req), .flush_req(flush_req),
    .flush(flush),

    // axi -> cache_controller
    .main_mem_ack(axi_ready),

    // cache_controller -> mem
    .mem_rw(mem_rw),

    // cache_datapath -> cache_controller
    .dirty_bit(dirty_bit), .cache_hit(cache_hit),
    .cache_wr_en(cache_wr_en),

    .flush_done(flush_done), .flush_count_en(flush_count_en),
    .cache_ready(cache_ready),

    // cache_controller -> axi
    .axi_read(start_read), .axi_write(start_write)
);

axi4 axi4 (
    .clk(clk), .reset(n_rst),

    // cache controller -> axi4
    .start_read (start_read), .start_write(start_write),

    // testbench -> axi4
    .aw_ready(aw_ready), .w_ready(w_ready),
    .b_valid(b_valid), .ar_ready(ar_ready),
    .r_valid(r_valid),

    // axi4 -> testbench
    .aw_valid(aw_valid), .w_valid(w_valid),
    .b_ready(b_ready), .ar_valid(ar_valid),
    .r_ready(r_ready),

    // axi4 -> cache controller
    .axi_ready (axi_ready)
);
    
endmodule
