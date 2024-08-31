module cache_mem_axi4 #(
parameter ADDR_WIDTH = 32,
parameter BLOCK_SIZE = 128,
parameter WORD_SIZE = 32,
parameter TAG_SIZE = 18,
parameter NUM_LINES = 1024,
parameter INDEX_WIDTH = 10,
parameter BLOCK_OFFSET = 4
) (
    input logic clk, 
    input logic rst,
    input logic cpu_wr_en,
    input logic flush,
    input logic mem_ack,
    input logic cpu_valid,
    input logic axi_AWREADY,
    input logic axi_ARREADY,
    input logic axi_WREADY,
    input logic axi_RVALID,
    input logic axi_BVALID,
    input logic [ADDR_WIDTH-1:0] address,
    input logic [BLOCK_SIZE-1:0] read_data_mem,
    input logic [WORD_SIZE-1:0] write_data_cpu,
    output logic [BLOCK_SIZE-1:0] modf_data_mem,
    output logic [WORD_SIZE-1:0] read_data_cpu,
    output logic [ADDR_WIDTH-1:0] memory_address,
    output logic src_valid,
    output logic axi_AWVALID,
    output logic axi_ARVALID,
    output logic axi_WVALID,
    output logic axi_RREADY,
    output logic axi_BREADY,
    output logic cpu_ready
);

    logic cache_read;
    logic cache_write;
    logic allocate_cache;
    logic wr_bck_cache;
    logic hit;
    logic flush_done;
    logic dirty;
    logic load_addr_en;
    logic mem_wr_en;
    logic zero_dirty;
    logic axi_ready;

    datapath d1(.clk(clk), .rst(rst), .cache_read(cache_read), .cache_write(cache_write), .allocate_cache(allocate_cache), .wr_bck_cache(wr_bck_cache), .load_addr_en(load_addr_en), .flush(flush), .mem_ack(mem_ack), .zero_dirty(zero_dirty), .address(address), .read_data_mem(read_data_mem), .write_data_cpu(write_data_cpu), .modf_data_mem(modf_data_mem), .read_data_cpu(read_data_cpu), .memory_address(memory_address), .hit(hit), .flush_done(flush_done), .dirty(dirty));

    controller c1(.clk(clk), .rst(rst), .hit(hit), .dirty(dirty), .flush(flush), .mem_ack(mem_ack), .flush_done(flush_done), .cpu_valid(cpu_valid), .cpu_wr_en(cpu_wr_en), .cpu_ready(cpu_ready), .mem_wr_en(mem_wr_en), .cache_read(cache_read), .cache_write(cache_write), .allocate_cache(allocate_cache), .load_addr_en(load_addr_en), .zero_dirty(zero_dirty), .src_valid(src_valid), .wr_bck_cache(wr_bck_cache));

    axi4lite_controller axi4lite_1(.clk(clk), .reset(rst), .mem_wr_req(mem_wr_en), .axi_valid(src_valid), .axi_ready(axi_ready), .arready(axi_ARREADY), .rvalid(axi_RVALID), .awready(axi_AWREADY), .wready(axi_WREADY), .bvalid(axi_BVALID), .arvalid(axi_ARVALID), .rready(axi_RREADY), .awvalid(axi_AWVALID), .wvalid(axi_WVALID), .bready(axi_BREADY));
    
endmodule
