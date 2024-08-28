module cache (
	input  logic 		clk,
	input  logic 		n_rst,

	// cpu --> cache
	input  logic [31:0] cpu_addr,
	input  logic [31:0] cpu_data,	//

	input  logic 		cpu_req,
	input  logic 		cpu_rw,
	input  logic 		cpu_flush,

	// mem --> cache 
	input  logic 		main_mem_ack,
	input  logic [31:0] mem_data_read, 
	
	// cache --> mem
	output logic 		mem_rw,
	output logic [31:0] mem_data_write,
	output logic [31:0] mem_addr,

	// cache --> tb
	output logic [31:0] data_read,
	output logic [19:0] tag_read,
	output logic 		cache_ready,
	output logic 		cache_wr_en,
	output logic 		flush_done
);

//logic cache_wr_en;
logic cpu_wr_req;
logic cache_hit; 
logic dirty_bit;

logic flush;
logic flush_count_en;
//logic flush_done;
logic flush_req;


//logic mem_wr_req;

assign data_read = mem_data_write;

cache_datapath cache_datapath (
	.clk  			(clk),
	.n_rst 			(n_rst),

	.cpu_addr		(cpu_addr),
	.cpu_data		(cpu_data),

	.cache_data_o	(mem_data_write),

	.mem_data		(mem_data_read),
	.mem_rw			(mem_rw),
	.mem_addr		(mem_addr),

	.cache_wr_en 	(cache_wr_en),
	.cpu_wr_req	 	(cpu_wr_req),

	.flush(flush),
	.flush_count_en(flush_count_en),
	.flush_done(flush_done),
	.flush_req(flush_req),

	.tag_read		(tag_read),
	.dirty_bit		(dirty_bit),
	.cache_hit		(cache_hit)
);

cache_controller cache_controller (
	.clk			(clk),
	.n_rst			(n_rst),

	.cpu_req		(cpu_req),
	.cpu_rw			(cpu_rw),
	.cpu_wr_req		(cpu_wr_req),
	.cpu_flush		(cpu_flush),			

	.main_mem_ack	(main_mem_ack),
	//.mem_wr_req		(mem_wr_req),
	.mem_rw			(mem_rw),

	.flush(flush),
	.flush_count_en(flush_count_en),
	.flush_done(flush_done),
	.flush_req(flush_req),

	.dirty_bit		(dirty_bit),
	.cache_hit		(cache_hit),

	.cache_wr_en	(cache_wr_en),
	.cache_ready	(cache_ready)
);

endmodule
