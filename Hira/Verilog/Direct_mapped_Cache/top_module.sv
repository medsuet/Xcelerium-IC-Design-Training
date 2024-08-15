module top_module (
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] address,
    input  logic [31:0] input_data,
    input  logic        cpu_request_read,
    input  logic        cpu_request_write
);

    // Internal signals
    logic read_enable;
    logic write_enable;
    logic mem_read;
    logic mem_write;
    logic dirty_bit;
    logic main_memory_ack;
    logic flush;
    logic cache_hit;
    logic cache_miss;
    logic flush_done;
    logic [31:0] data;
    logic cache_flush;

    // Instantiate Control Unit
    Control_unit control_inst (
        .clk(clk),
        .rst(rst),
        .cpu_request(cpu_request_read | cpu_request_write),
        .cache_flush(cache_flush),
        .dirty_bit(dirty_bit),
        .main_memory_ack(main_memory_ack),
        .flush(flush),
        .cache_hit(cache_hit),
        .cache_miss(cache_miss),
        .flush_done(flush_done),
        .read_enable(read_enable),
        .write_enable(write_enable),
        .enable_flush(enable_flush),
        .mem_read(mem_read),
        .mem_write(mem_write)
    );

    // Instantiate Data Path
    data_path datapath_inst (
        .clk(clk),
        .rst(rst),
        .enable_read(read_enable),
        .enable_write(write_enable),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .input_data(input_data),
        .cpu_request_write(cpu_request_write),
        .cpu_request_read(cpu_request_read),
        .cache_flush(cache_flush),
        .data(data),
        .dirty_bit(dirty_bit),
        .main_memory_ack(main_memory_ack),
        .flush(flush),
        .cache_hit(cache_hit),
        .cache_miss(cache_miss),
        .flush_done(flush_done)
    );

endmodule
