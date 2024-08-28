module tb_cache_axi;

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

// testbench -> axi4 
logic 			aw_ready;
logic 			w_ready;
logic 			b_valid;
logic 			ar_ready;
logic 			r_valid;

// axi4 -> testbench
logic 			aw_valid;
logic 			w_valid;
logic 			b_ready;
logic 			ar_valid;
logic 			r_ready;

// axi controller -> cache controller
logic 			axi_ready;

// associative array
int			  	ass_arr [int];

initial begin
	clk = 1;
	forever clk = #5 ~clk;
end

cache dut (
	.clk 			(clk),
	.n_rst 			(n_rst),
	
	.cpu_addr 		(cpu_addr),
	.cpu_data   	(cpu_data),
	
	.cpu_req  		(cpu_req),
	.cpu_rw  		(cpu_rw),
	.cpu_flush 		(flush),
	
	.data_read 		(data_read),
	.tag_read  		(tag_read),

	.mem_rw 		(mem_rw),
	.main_mem_ack	(main_mem_ack),
	.mem_data_read	(mem_data_read),
	.mem_data_write	(mem_data_write),
	.mem_addr		(mem_addr),
	.cache_ready	(cache_ready),
	.cache_wr_en	(cache_wr_en),
	.flush_done		(flush_done),

	.aw_ready		(aw_ready),
	.w_ready		(w_ready),
	.b_valid		(b_valid),
	.ar_ready		(ar_ready),
	.r_valid		(r_valid),

	.aw_valid		(aw_valid),
	.w_valid		(w_valid),
	.b_ready		(b_ready),
	.ar_valid		(ar_valid),
	.r_ready		(r_ready),

	.axi_ready		(axi_ready)
);

initial begin
	//$readmemh ("/home/fazail/Documents/Xcelerium/hands-on/cache/cache_2/src/mem/main_mem.txt", data_field);
	for (int i=0; i<=65536; i++) begin
		data_field [i] = $random;
	end
end

initial begin
	init_signals;
	reset_seq;

	$display("**************************");
	$display("*          Tests         *");
	$display("**************************\n");

	$display("Cache Read Cases\n");

	fork
		cpu_driver;
		mem_aw_ready;
		mem_w_ready;
		mem_b_valid;
		mem_ar_ready;
		mem_r_valid;
		monitor;
	join_any
	$display("Reference Model = %p",ass_arr);
	@(posedge clk);
	$stop;
end

task monitor;
	logic [31:0] m_addr,m_data;
	
	while (1) begin
		@(posedge cpu_req);
		m_addr <= cpu_addr;	
		while (!cache_ready)
			@(posedge clk);

		if (cpu_rw)
			m_data <= cpu_data;
		else 
			m_data <= mem_data_read;
		
		if (ass_arr[m_addr[11:2]] == m_data)
			$display("Pass");
		else 
			$display("Not Pass");
	end
endtask

task cpu_driver;
	logic [9:0] adr;
	logic [3:0] t_addr;
	for (int i = 0; i < 4; i++) begin
		for (int j = 0; j < 4; j++) begin
			adr = i; t_addr = $random;
			cpu_addr = {'0 ,t_addr,adr, 2'b00}; cpu_data <= $random;
			@(posedge clk);
			cpu_req <= 1; cpu_rw <= $random;
			@(posedge clk);
			while (!cache_ready)
				@(posedge clk);
			cache_ref_model (cpu_rw,cpu_addr, cpu_data, mem_data_read);
			cpu_req <= 0;// cpu_rw <= 0;
			@(posedge clk);
		end	
	end
endtask

task cache_read (
	input logic [31:0]addr);
	cpu_addr <= addr;
	@(posedge clk);
	cpu_req <= 1; 
	cpu_rw <= 0;	// 0 : read request
	@(posedge clk);
	while(!cache_ready)
		@(posedge clk);
	cpu_req <= 0;
	cpu_rw <= 0;
	@(posedge clk);
endtask

task cache_write (
	input logic [31:0]addr,
	input logic [31:0]data);
	cpu_data <= data;
	cpu_addr <= addr;
	@(posedge clk);
	cpu_req <= 1; 
	cpu_rw 	<= 1;	// 0 : read request
	@(posedge clk);
	while(!cache_ready)
		@(posedge clk);
	cpu_req <= 0;
	cpu_rw 	<= 0;
	@(posedge clk);
endtask

task mem_aw_ready;
	while (1) begin
		@(posedge clk);
		aw_ready <= 1;
		@(posedge clk);
		while (!aw_valid)
			@(posedge clk);
		aw_ready <= '0;
	end
endtask

task mem_w_ready;
	while(1) begin
		@(posedge clk);

		w_valid <= 1;
		@(posedge clk);
		while (!w_ready)
			@(posedge clk);
		w_valid <= '0;
	end
endtask

task mem_b_valid;
	while (1) begin
		@(posedge clk);
		b_valid <= 1;
		@(posedge clk);
		while (!b_ready)
			@(posedge clk);
		b_valid <= '0;
	end
endtask

task mem_ar_ready;
	while (1) begin
		@(posedge clk);
		ar_ready <= 1;
		@(posedge clk);
		while (!ar_valid)
			@(posedge clk);
		ar_ready <= '0;
	end
endtask

task mem_r_valid;
	while (1) begin
		@(posedge clk);
		r_valid <= 1;
		mem_data_read = data_field[mem_addr];
		//ass_arr [cpu_addr[11:2]] = mem_data_read;
		@(posedge clk);
		while (!r_ready)
			@(posedge clk);
		r_valid <= '0;
	end
endtask

function cache_ref_model(
	input logic cpu_rw,
	input logic [31:0] cpu_addr,
	input logic [31:0] cpu_data,
	input logic [31:0] mem_data_read);

	if (cpu_rw) begin
			ass_arr [cpu_addr[11:2]] = cpu_data;
	end else begin
			ass_arr [cpu_addr[11:2]] = mem_data_read;
	end
endfunction

task init_signals;
	n_rst = 1;

	main_mem_ack  = '0; mem_rw   = '0;
	cpu_rw 		  = '0; flush 	 = '0;
	cpu_addr 	  = '0; cpu_req  = '0;
	mem_data_read = '0; cpu_data = '0;

	aw_ready	= 1; 
	w_ready 	= 1; 
	b_valid 	= 1; 
	ar_ready	= 1; 
	r_valid 	= 1; 

	@(posedge clk);
endtask

task reset_seq;
	n_rst <= 0;
	@(posedge clk);
	n_rst <= 1;
	@(posedge clk);
endtask


endmodule
