module tb_cache;

logic 			clk;
logic 			n_rst;

logic [31:0] 	cpu_addr;
logic [31:0]	cpu_data;

logic 			cpu_req;
logic 			cpu_rw;
logic 			flush;
logic 			flush_done;

logic [31:0] 	data_read;
logic [19:0] 	tag_read;

logic [31:0] 	mem_data_write;
logic [31:0] 	mem_data_read;
logic [31:0]	mem_addr;

logic 			mem_rw;
logic 			main_mem_ack;

logic 			cache_ready;
logic			cache_wr_en;

logic [31:0] 	data_field [0:65536];

// associative array
int 	ass_arr [int];

initial begin
	clk = 1;
	forever clk = #5 ~clk;
end

cache dut (
	.clk 		(clk),
	.n_rst 		(n_rst),

	.cpu_addr 	(cpu_addr),
	.cpu_data   (cpu_data),

	.cpu_req  	(cpu_req),
	.cpu_rw  	(cpu_rw),
	.cpu_flush 	(flush),

	.data_read 	(data_read),
	.tag_read  	(tag_read),

	.mem_rw 		(mem_rw),
	.main_mem_ack	(main_mem_ack),
	.mem_data_read	(mem_data_read),
	.mem_data_write	(mem_data_write),
	.mem_addr		(mem_addr),
	.cache_ready	(cache_ready),
	.cache_wr_en	(cache_wr_en),
	.flush_done		(flush_done)
);

initial begin
	$readmemh ("/home/fazail/Documents/Xcelerium/hands-on/cache/cache_2/src/mem/main_mem.txt", data_field);
end

initial begin
	init_signals;
	reset_seq;

	$display("**************************");
	$display("*     Directed Tests     *");
	$display("**************************\n");

	$display("Cache Read Cases\n");
	cache_read(32'h00000004);
	cache_read(32'h00000008);
	cache_read(32'h00000004);
	cache_read(32'h00000008);

	$display("\nCache Write Cases\n");
	cache_write(32'h00000000,32'hDEADBEEF);
	cache_write(32'h00000000,32'hBEEFDEAD);
	
	cache_write(32'h00001000,32'hDEAFD00D);
	cache_write(32'h00001000,32'hDEAFD00D);

	cache_write(32'h0000F00C,32'h01234567);
	cache_write(32'h0000200C,32'hD000000D);

	$display("\nCache Flush\n");
	fork
		cache_flush;
		mma;
	join_any

	$display("\n");

	/*fork
		cpu_read_driver;
		read_mem_ack;
	join_any

	fork
		cpu_write_driver;
		write_mem_ack;
	join_any*/

	@(posedge clk);
	$stop;
end

task cache_write (
	input logic [31:0]addr, 
	input logic [31:0]data
);
	@(posedge clk);
	cpu_addr <= addr; cpu_data <= data;
	@(posedge clk);
	cpu_req <= 1; cpu_rw <= 1;
	repeat(2) @(posedge clk);
	if (cache_ready) begin
		$display("Write Hit  | Addr = 0x%h", cpu_addr);
		cpu_req <= '0; 	cpu_rw <= '0;
	end
	else begin
		mem_data_read = data_field[mem_addr];
		$display("Write Miss | Addr = 0x%h", cpu_addr);
		if (mem_rw) begin
			@(posedge clk);
			data_field [mem_addr] = mem_data_write;
			main_mem_ack <= 1;	
			@(posedge clk);
			main_mem_ack <= '0;
		end
		@(posedge clk);
		main_mem_ack <= 1;	
			@(posedge clk);
			main_mem_ack <= '0;
		@(posedge clk);
		while (!cache_ready)
			@(posedge clk);
		cpu_req <= '0; cpu_rw <= '0;
	end
endtask

task cache_read (input logic [31:0]addr);
	@(posedge clk);
	cpu_addr <= addr;
	@(posedge clk);
	cpu_req <= 1;	cpu_rw <= '0;
	repeat(2) @(posedge clk);
	if (cache_ready) begin
		$display("Read Hit  | Addr = 0x%h", cpu_addr);
		cpu_req <= '0; 	cpu_rw <= '0;
	end
	else begin
		mem_data_read = data_field[mem_addr];
		@(posedge clk);
		$display("Read Miss | Addr = 0x%h", cpu_addr);
		main_mem_ack <= 1;
		@(posedge clk);
		main_mem_ack <= '0;
		@(posedge clk);
		while (!cache_ready)
			@(posedge clk);
		cpu_req <= '0; cpu_rw <= '0;
	end
endtask

task cache_flush;
	@(posedge clk);
	flush = 1;
	@(posedge clk);
	while (!cache_ready) begin
		@(posedge clk);
	end
	flush = 0; 
endtask

task mma;
	while(1) begin
		@(posedge clk);
		while (!mem_rw) 
			@(posedge clk);
		main_mem_ack <= 1;
		@(posedge clk);
		main_mem_ack <= '0;
	end
endtask

task cpu_write_driver;
	@(posedge clk);
	cpu_addr <= 32'h00000004; cpu_data <= 32'hDEADBEEF;
	@(posedge clk);
	cpu_req <= 1; 
	cpu_rw  <= 1;		// 1: write request
	@(posedge clk);
	while (!cache_ready) begin
		@(posedge clk);
	end
	cpu_req <= 0;
	cpu_rw <= 0;
	@(posedge clk);
endtask

task cpu_read_driver;
	@(posedge clk);
	cpu_addr <= 32'h00000004;
	@(posedge clk);
	cpu_req <= 1; 
	cpu_rw <= 0;		// 0: read request
	@(posedge clk);
	while (!cache_ready) begin
		@(posedge clk);
	end
	cpu_addr <= '0;
	cpu_req  <= '0;
	cpu_rw   <= '0;
endtask

task write_mem_ack;
	while (1) begin
		main_mem_ack <= 0;
		@(posedge clk);
		while (!mem_rw)		// writeback
			@(posedge clk);
		main_mem_ack <= 1;
		data_field [mem_addr] = mem_data_write;
		@(posedge clk);		// cache allocate
		main_mem_ack <= 0;
		repeat(1) @(posedge clk);	
		main_mem_ack <= 1;
		@(posedge clk);		// idle
	end
endtask

task read_mem_ack;
	while (1) begin
		@(posedge clk);			// process request state
		main_mem_ack <= 0;
		mem_data_read = data_field[mem_addr];
		@(posedge clk);
		while (!cache_wr_en)
			@(posedge clk);	// cache allocate state
		main_mem_ack <= 1;
	end
endtask

task init_signals;
	n_rst = 1;
	main_mem_ack  = '0; mem_rw   = '0;
	cpu_rw 		  = '0; flush 	 = '0;
	cpu_addr 	  = '0; cpu_req  = '0;
	mem_data_read = '0; cpu_data = '0;
	@(posedge clk);
endtask

task reset_seq;
	n_rst <= 0;
	@(posedge clk);
	n_rst <= 1;
	@(posedge clk);
endtask


endmodule
