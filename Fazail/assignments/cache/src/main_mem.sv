module main_mem (
	input logic clk, n_rst,
	
	input logic [31:0] addr,
	input logic [31:0] data_write,
	
	output logic [31:0] data_read,

	input logic mem_rw,
	output logic main_mem_ack

);

logic [31:0] data_field [0:7];

initial begin
	$readmemh ("/home/fazail/Documents/Xcelerium/hands-on/cache_2/src/mem/main_mem.txt", data_field);
end

always_ff @(posedge clk, negedge n_rst) begin
	if (mem_rw) begin
		data_field [addr] <= data_write;
		//main_mem_ack <= 0;
	end
	else begin
		data_read <= data_field [addr];
		//main_mem_ack <= 1;
	end
end

endmodule
