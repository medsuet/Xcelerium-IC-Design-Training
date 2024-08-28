parameter ADDRESS = 32;
parameter CPU_READ_DATA = 32;
parameter CPU_WRITE_DATA = 32;
parameter R_DATA = 32;
parameter W_DATA = 32;

module cache_top (
    input    logic            clk,
    input    logic            rst,

    // Interface Between CPU And Cache 
    input    logic   [ADDRESS-1:0]         cpu_address,
    input    logic   [CPU_WRITE_DATA-1:0]  cpu_write_data,
    input    logic   [1:0]                 cpu_request,
    input    logic                         cpu_valid_req,

    output   logic   [CPU_READ_DATA-1:0]   cpu_read_data,   
    output   logic                         cache_ready,       

    // Interface Between Cache And Main Memory (AXI-4 Lite)
    input    logic                  AR_READY,
    input    logic                  R_VALID,
    input    logic                  AW_READY,
    input    logic                  W_READY,
    input    logic                  B_VALID,
    input    logic                  B_RESPONSE,
    input    logic   [R_DATA-1:0]   R_DATA,
    
    output   logic   [ADDRESS-1:0]  AR_ADDRESS,
    output   logic   [ADDRESS-1:0]  AW_ADDRESS,
    output   logic   [W_DATA-1:0]   W_DATA,
    output   logic                  AR_VALID,
    output   logic                  R_READY,
    output   logic                  AW_VALID,
    output   logic                  W_VALID,
    output   logic                  B_READY
);

logic cache_hit, cache_miss, dirty_bit, cpu_write_en; 
logic read_from_main_mem, flush_done, flush_en, flush_counter_en, change_dirty_bit;
logic start_write, start_read, axi_ready;

cache_controller cache_controller (
    .clk(clk),
    .reset(rst),

    // Interface Between CPU And Controller 
    .cpu_valid(cpu_valid_req),
    .cpu_request(cpu_request),
    .cache_ready(cache_ready),

    // Interface Between Cache Controller And AXI4 Controller
    .read_req(start_read),
    .write_req(start_write),
    .axi_ready(axi_ready),

    // Interface Between Datapath And Controller
    .cache_hit(cache_hit),
    .cache_miss(cache_miss),
    .dirty_bit(dirty_bit),
    .change_dirty_bit(change_dirty_bit),
    .write_from_main_mem(write_from_main_mem),
    .write_from_cpu(cpu_write_en),
    .flush_en(flush_en), 
    .flush_done(flush_done),
    .flush_count_en(flush_counter_en)
);

cache_datapath cache_datapath (
    .clk_i(clk),
    .rst_i(rst),

    // Interface Between CPU And Cache Memory
    .cpu_address_i(cpu_address),
    .cpu_read_data_o(cpu_read_data),
    .cpu_write_data_i(cpu_write_data),

    // Interface Between Cache Memory And Main Memory
    .ar_address_o(AR_ADDRESS),
    .r_data_i(R_DATA),
    .aw_address_o(AW_ADDRESS),
    .w_data_o(W_DATA),

    // Interface Between Datapath And Controller
    .cache_hit_o(cache_hit),
    .cache_miss_o(cache_miss),
    .dirty_bit_o(dirty_bit),
    .cpu_write_en_i(cpu_write_en),
    .change_dirty_bit_i(change_dirty_bit),
    .write_from_main_mem_i(write_from_main_mem),

    .flush_en_i(flush_en),             
    .flush_counter_en_i(flush_counter_en),
    .flush_done_o(flush_done)    
);

axi4_controller axi4_controller (
    .clk(clk),
    .reset(rst),

    // Interface Between AXI4 Controller And Main Memory
    .start_write(start_write),
    .start_read(start_read),
    .axi_ready(axi_ready),

    // Interface Between AXI4 Controller And Cache Memory
    .aw_ready(AW_READY),
    .w_ready(W_READY),
    .b_valid(B_VALID),
    .ar_ready(AR_READY),
    .r_valid(R_VALID),
    .aw_valid(AW_VALID),
    .w_valid(W_VALID),
    .b_ready(B_READY),
    .ar_valid(AR_VALID),
    .r_ready(R_READY)
);

endmodule
