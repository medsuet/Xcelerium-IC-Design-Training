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
    input    logic                  ar_ready,
    input    logic                  r_valid,
    input    logic                  aw_ready,
    input    logic                  w_ready,
    input    logic                  b_valid,
    input    logic                  b_response,
    input    logic   [R_DATA-1:0]   r_data,
    output   logic   [ADDRESS-1:0]  ar_address,
    output   logic   [ADDRESS-1:0]  aw_address,
    output   logic   [W_DATA-1:0]   w_data,
    output   logic                  ar_valid,
    output   logic                  r_ready,
    output   logic                  aw_valid,
    output   logic                  w_valid,
    output   logic                  b_ready
);

//======================= Declearing Internal Signals ========================//

logic cache_hit, dirty_bit, cpu_write_en; 
logic read_from_main_mem, flush_done, flush_en, flush_counter_en, change_dirty_bit;
logic start_write, start_read, axi_ack;

//=========================== Module Instantiation ===========================//

cache_controller cache_controller (
    .clk(clk),
    .reset(rst),

    // Interface Between Cache Controller And CPU 
    .cpu_valid(cpu_valid_req),
    .cpu_request(cpu_request),
    .cache_ready(cache_ready),

    // Interface Between Cache Controller And AXI4 Controller
    .read_req(start_read),
    .write_req(start_write),
    .axi_ack(axi_ack),

    // Interface Between Cache Controller And Datapath 
    .cache_hit(cache_hit),
    .dirty_bit(dirty_bit),
    .change_dirty_bit(change_dirty_bit),
    .write_from_main_mem(write_from_main_mem),
    .write_from_cpu(cpu_write_en),
    .flush_en(flush_en), 
    .flush_done(flush_done),
    .flush_count_en(flush_counter_en)
);

//=========================== Module Instantiation ===========================//

cache_datapath cache_datapath (
    .clk_i(clk),
    .rst_i(rst),

    // Interface Between Datapath And CPU
    .cpu_address_i(cpu_address),
    .cpu_read_data_o(cpu_read_data),
    .cpu_write_data_i(cpu_write_data),

    // Interface Between Datapath And Main Memory
    .ar_address_o(ar_address),
    .r_data_i(r_data),
    .aw_address_o(aw_address),
    .w_data_o(w_data),

    // Interface Between Datapath And Controller
    .cache_hit_o(cache_hit),
    .dirty_bit_o(dirty_bit),
    .cpu_write_en_i(cpu_write_en),
    .change_dirty_bit_i(change_dirty_bit),
    .write_from_main_mem_i(write_from_main_mem),

    .flush_en_i(flush_en),             
    .flush_counter_en_i(flush_counter_en),
    .flush_done_o(flush_done)    
);

//=========================== Module Instantiation ===========================//

axi4_controller axi4_controller (
    .clk(clk),
    .reset(rst),

    // Interface Between AXI4 Controller And Main Memory
    .start_write(start_write),
    .start_read(start_read),
    .axi_ack(axi_ack),

    // Interface Between AXI4 Controller And Cache Memory
    .aw_ready(aw_ready),
    .w_ready(w_ready),
    .b_valid(b_valid),
    .ar_ready(ar_ready),
    .r_valid(r_valid),
    .aw_valid(aw_valid),
    .w_valid(w_valid),
    .b_ready(b_ready),
    .ar_valid(ar_valid),
    .r_ready(r_ready)
);

endmodule
