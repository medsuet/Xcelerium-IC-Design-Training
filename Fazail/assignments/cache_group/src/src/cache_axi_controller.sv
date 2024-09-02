module cache_axi_controller (
    input logic  clk, n_rst,

    // cache Datapath -> cache controller
    input logic       cache_hit,
    input logic       cache_miss,
    input logic       dirty_bit,
    input logic       flush_done,

    // cpu -> cache controller
    input logic       cpu_valid,
    input logic [1:0] cpu_request,
    input logic       flush,

    // cache controller -> cache datapath 
    output logic      change_dirty_bit,
    output logic      read_from_cache,
    output logic      write_from_cpu,
    output logic      flush_en,
    output logic      flush_count_en,
    output logic      cache_ready,
    output logic      write_from_main_mem,

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
    .clk(clk), .reset(n_rst),

    // cache Datapath -> cache controller
    .cache_hit(cache_hit), .cache_miss(cache_miss),
    .dirty_bit(dirty_bit), .flush_done(flush_done),

    // cpu -> cache controller
    .cpu_valid(cpu_valid), .flush(flush),
    .cpu_request(cpu_request),

    // axi controller -> cache controller
    .axi_ready (axi_ready),

    // cache controller -> axi controller
    .read_req(start_read), .write_req(start_write),

    // cache controller -> cache datapath
    .change_dirty_bit(change_dirty_bit),
    .read_from_cache(read_from_cache),
    .write_from_cpu(write_from_cpu),
    .flush_en(flush_en), 
    .flush_count_en(flush_count_en),
    .cache_ready(cache_ready),
    .write_from_main_mem(write_from_main_mem)
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
