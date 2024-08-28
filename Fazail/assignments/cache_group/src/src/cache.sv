module cache (
	input  logic 			clk,
	input  logic 			rst,
	
	input  logic 			flush_en,
	
	input  logic 			aw_ready,
	input  logic 			w_ready,
	input  logic 			b_valid, 
	input  logic 			ar_ready, 
	input  logic 			r_valid,
    input  logic [127:0]	r_data,
    
	input  logic 			proc_valid,
    input  logic [1 :0]		cpu_request,
    input  logic [31:0]		cpu_data,
    input  logic [31:0]		cpu_addr,
    
    output logic  			aw_valid, 
    output logic  			w_valid,
    output logic  			b_ready,
    output logic  			ar_valid,
    output logic  			r_ready,
    
    output logic  			cache_ready,
    output logic [31:0]		data_out,
    output logic [31:0]		aw_data,
    output logic [31:0]		ar_addr,
    output logic [31:0]		aw_addr,
    output logic [127:0]	w_data
);

logic 	counter_en;
logic 	cache_en;
logic 	mem_en;
logic 	flush;
logic 	flush_done;
logic 	hit;
logic 	dirty_bit;

logic   axi_ready;		// mem_ack
logic   read_req,write_req;
logic   change_dirty_bit,read_from_cache;
logic   write_from_cpu,flush_count_en;
logic   write_from_main_mem;  

assign flush = (cpu_request == 2'b10) ? 1 : 0;

cache_datapath cache_datapath (

    .clk(clk),  .reset(rst),

    .counter_en  (flush_count_en),
    .cpu_address (cpu_addr),
    .cpu_data_in (cpu_data),       
    .cache_en    (write_from_cpu),
    .mem_en      (write_from_main_mem), 
    //.flush       (flush_en),
    .flush       (flush),
    .R_data      (r_data),
    .AW_addr     (aw_addr),
    .AR_addr     (ar_addr),
    .w_data      (w_data),
    .cpu_data_out(data_out),
    .flush_done  (flush_done),
    .hit         (hit),
    .dirty_bit   (dirty_bit)

);

cache_axi_controller  cache_axi_controller (
    .clk(clk), .n_rst(rst),

    .cache_hit          (hit), 
    .cache_miss         (~hit),
    .dirty_bit          (dirty_bit), 
    .flush_done         (flush_done),

    .cpu_valid          (proc_valid), 
    .cpu_request        (cpu_request),
    .flush              (flush), 

    .change_dirty_bit   (change_dirty_bit),
    .read_from_cache    (read_from_cache), 
    .write_from_cpu     (write_from_cpu),
    .flush_en           (flush_en), 
    .flush_count_en     (flush_count_en),
    .cache_ready        (cache_ready), 
    .write_from_main_mem(write_from_main_mem),
    
    .aw_ready   (aw_ready),    .w_ready    (w_ready),
    .b_valid    (b_valid),     .ar_ready   (ar_ready),
    .r_valid    (r_valid),

    .aw_valid   (aw_valid),    .w_valid    (w_valid),
    .b_ready    (b_ready),     .ar_valid   (ar_valid),
    .r_ready    (r_ready),

    .axi_ready(axi_ready)
);

endmodule
