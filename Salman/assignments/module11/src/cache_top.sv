`include "cache_defs.svh"

module cache_top(
    input logic clk,
    input logic rst,
    input logic cpu_req,
    input logic req_type,
    input logic flush_req,
    input logic [31:0] addr,
    input logic [127:0] w_data,
    output logic [31:0] r_data,
    output logic stall,
    output logic mem_rd,
    output logic mem_wr,
    input logic [127:0] mem2cache_data,
    input logic main_mem_ack,
    output logic [127:0] cache2mem_data,
    output logic [31:0]  cache2mem_addr
);

type_controller_out controller_out;
type_mem2cache memory2cache;
type_cache2mem cache2memory;
type_controller_in controller_in;

assign memory2cache.data = mem2cache_data;

//logic [31:0] r_data;
logic dirty,flush_done,cache_hit, flush;

cache_datapath datapath(
    .clk(clk),
    .rst(rst),
    .flush_req(flush_req),
    .addr(addr),
    .w_data(w_data),
    .stall(stall),
    .cache_i(controller_out),
    .mem2cache(memory2cache),
    .cache2mem(cache2memory),
    .r_data(r_data),
    .dirty(dirty),
    .flush_done(flush_done),
    .cache_hit(cache_hit),
    .flush(flush)
);

    assign controller_in.cpu_req     = cpu_req;
    assign controller_in.req_type    = req_type;
    assign controller_in.flush_req   = flush_req;
    assign controller_in.flush       = flush;
    assign controller_in.dirty       = dirty;
    assign controller_in.flush_done  = flush_done;
    assign controller_in.cache_hit   = cache_hit;

    assign mem_rd = controller_out.mem_rd;
    assign mem_wr = controller_out.mem_wr;

    assign cache2mem_data = cache2memory.data;
    assign cache2mem_addr = cache2memory.addr;

cache_controller controller(
    .clk(clk),
    .rst(rst),
    .main_mem_ack(main_mem_ack),
    .controller_i(controller_in),
    .controller_o(controller_out),
    .stall(stall)
);

endmodule