module cache_datapath #(
	WIDTH 	  	= 32,
	TAG_WIDTH 	= 20,
	INDEX_WIDTH = 10,
	OFFSET_BITS = 2,
	DEPTH 	    = 4
)(
	input logic 					clk,
	input logic 					n_rst,

	// CPU -> cache
	input logic  [WIDTH-1:0]  		cpu_addr,
	input logic  [WIDTH-1:0]  		cpu_data,

	output logic [WIDTH-1:0] 		cache_data_o,
	
	// mem -> cache
	input logic  [WIDTH-1:0]  		mem_data, // mem data
	input logic						mem_rw,
	
	output logic [WIDTH-1:0] 		mem_addr,

	// controller -> cache
	input logic 					cache_wr_en,
	input logic 					cpu_wr_req,

	input logic 					flush_req,
	input logic 					flush_count_en,
	input logic 					flush,

	output logic					flush_done, 

	output logic [TAG_WIDTH-1:0] 	tag_read,
	output logic 					dirty_bit,
	output logic 					cache_hit
);

logic [DEPTH-1:0]		valid ;
logic 					dirty [0:DEPTH-1];
logic [TAG_WIDTH-1:0] 	tag   [0:DEPTH-1];
logic [WIDTH-1:0] 		data  [0:DEPTH-1];

logic [INDEX_WIDTH-1:0] index,wr_index,i;
logic [OFFSET_BITS-1:0] offset;

assign index = cpu_addr [11:2];
assign offset = cpu_addr [1:0];

// asynchronously read data, dirty and tag
assign tag_read  = cpu_addr[WIDTH-1:12];

always_ff @(posedge clk, negedge n_rst) begin
	if (!n_rst) begin
		cache_data_o <= '0;
		valid 		 <= '0;
		for (int i=0; i<DEPTH; i++) begin
			dirty[i] <= '0;
		end
	end

	// write into cache
	else if (cache_wr_en) begin
		// write from memory
		tag  [index] <= cpu_addr[WIDTH-1:12];
		valid[index] <= 1;

		// write from cpu
		if (cpu_wr_req) begin
			data [index] <= cpu_data;
			dirty[index] <= 1;
		end
		else begin
			data [index] <= mem_data;
			dirty[index] <= dirty[index];
		end
	end

	// write from cache to memory
	else if (mem_rw) begin
		dirty [wr_index] <= 0;
		valid [wr_index] <= valid [index];
		cache_data_o  	 <= data[index];		
	end

	else begin
		dirty[index] <= dirty[index];
		valid[index] <= valid[index];
	end
end

// hit or miss 
always_comb begin
	if  ((tag[index] == cpu_addr[WIDTH-1:12]) && valid[index])
		cache_hit = 1'b1;
	else 
		cache_hit =1'b0;
end

// flush 
always_ff @(posedge clk) begin
	if (flush_req) begin
		dirty <= dirty;
		valid <= 0;
	end
	else if (flush_count_en) begin
		i <= i + 1;
	end
	else if (flush) begin
		i <= i;
	end
	else begin
		i <= '0;
	end
end

always_comb begin
	if (flush_count_en | flush) begin
		dirty_bit = dirty [i] ? 1 : '0;
		wr_index = i;
	end
	else begin
		dirty_bit = dirty[index] ? 1'b1 : '0;
		wr_index = index;
	end
end
assign flush_done = (i == DEPTH) ? 1 : 0;
assign mem_addr   = mem_rw ? {tag[index] , cpu_addr[11:0]}:cpu_addr;

endmodule
