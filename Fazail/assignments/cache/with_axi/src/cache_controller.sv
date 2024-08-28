module cache_controller (
	input logic clk, n_rst,

	// CPU -> cache_controller
	input logic cpu_req,
	input logic cpu_rw,		// 1:write, 0:read
	input logic cpu_flush,
	
	// cache controller -> cache datapath
	output logic cpu_wr_req,
	output logic flush_req,
	output logic flush,
	
	// axi -> cache_controller
	input logic main_mem_ack,
	
	// cache controller -> mem
	output logic mem_rw,	// 1:write, 0:read

	// cache_datapath -> cache_controller
	input logic dirty_bit,
	input logic cache_hit,

	output logic cache_wr_en,

	input logic flush_done,
	output logic flush_count_en,
	output logic cache_ready,

	// cache_controller -> axi 
	output logic axi_read,
	output logic axi_write
);

typedef enum {
	IDLE, 
	PROCESS_REQ, 
    ALLOCATE, 
	WRITEBACK, 
	FLUSH
} cache_state_e;

cache_state_e c_state, n_state;

always_ff @(posedge clk, negedge n_rst) begin
	if (!n_rst)
		c_state <= IDLE;
	else 
		c_state <= n_state;
end

always_comb begin
	case(c_state)
		IDLE: 
		begin
			if  	(cpu_req)	n_state = PROCESS_REQ;
			else if (cpu_flush) n_state = FLUSH;
			else				n_state = IDLE;
		end

		PROCESS_REQ:
		begin
			if      (cache_hit)		   			n_state = IDLE;
			else if (!cache_hit && !dirty_bit) 	n_state = ALLOCATE;
			else if (!cache_hit && dirty_bit)  	n_state = WRITEBACK;
		end

		ALLOCATE:
		begin
			if (main_mem_ack) 	n_state = PROCESS_REQ;
			else 		  		n_state = ALLOCATE;
		end
		
		WRITEBACK:
		begin
			if (main_mem_ack && !cpu_flush) 	n_state = ALLOCATE;
			else if (main_mem_ack && cpu_flush)	n_state = FLUSH;
			else 		  						n_state = WRITEBACK;
		end

		FLUSH:
		begin
			if (flush_done)						n_state = IDLE;
			else if (dirty_bit && !flush_done)  n_state = WRITEBACK;
			else 								n_state = FLUSH;
		end
	endcase
end

always_comb begin
	case(c_state)
		IDLE:
		begin	
				mem_rw 			= '0;
				cache_wr_en 	= '0;
				cpu_wr_req  	= '0;
				flush 			= '0;
				flush_count_en 	= '0;

				cache_ready 	= 1;

				axi_read		= 0;
				axi_write		= 0;

				if (cpu_flush) begin
					flush_req	= 1;
					cache_ready = '0;
				end
				else if (cpu_req) begin
					flush_req   = '0;
					cache_ready = '0;
				end
				else begin
					flush_req   = 0;
				end
		end

		PROCESS_REQ:
		begin
			cache_ready = 0;
			if (cache_hit) begin
				cache_ready = 1;
				if (cpu_rw) begin
					cache_wr_en = 1;
					cpu_wr_req  = 1;
				end
				else begin
					cache_wr_en = '0;
					cpu_wr_req  = '0;
				end
			end
			else if (!cache_hit && !dirty_bit) begin
				mem_rw 		= 0;
				cache_wr_en = 1;
				axi_read    = 1;
				axi_write	= 0;
			end
			else if (!cache_hit && dirty_bit) begin
				mem_rw 		= 1;
				cache_wr_en = '0;
				axi_write   = 1;
				axi_read	= '0;
			end
			else begin
				mem_rw 		= '0;
				cache_wr_en = '0;
				axi_write   = '0;
				axi_read	= '0;
			end
		end

		ALLOCATE:
		begin
			mem_rw 		= '0;
			cpu_wr_req  = '0;
			cache_ready = 0;
			if (main_mem_ack) begin
				cache_wr_en = 0;
				axi_read	= 1;
			end
			else begin
				cache_wr_en = 1;
				axi_read	= 1;
			end 
		end

		WRITEBACK:
		begin
			cpu_wr_req  = '0;
			cache_wr_en = '0;
			cache_ready = '0;
			if (main_mem_ack && !cpu_flush) begin
				mem_rw 		= 0;
				axi_write	= 0;
				axi_read	= 1;
			end
			if (main_mem_ack && cpu_flush) begin
				mem_rw 		= 0;
				axi_write	= 0;
				axi_read	= 0;
			end
			else begin
				mem_rw		= 1;
				axi_write	= 1;
				axi_read	= 0;
			end
		end

		FLUSH:
		begin
			flush_req   = 0;
			cache_ready = 0;
			if (flush_done) begin
				flush_count_en = 0;
				flush  		   = 0;
				cache_ready    = 1;
				axi_write	   = 0;
			end
			else if (cpu_flush && !dirty_bit) begin
				flush_count_en 	= 1;
				flush  			= 0;
				mem_rw 			= 0;
				axi_write		= 0;
			end
			else if (cpu_flush && dirty_bit) begin
				flush_count_en 	= 0;
				flush  			= 1;
				mem_rw		 	= 1;
				axi_write 		= 1;
			end
		end
	endcase
end

endmodule
