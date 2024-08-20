module mem(input logic clk, 
input logic rst, 
input logic arvalid, 
input logic rready, 
output logic arready, 
output logic rvalid, 
input logic [31:0] addr_mem, 
output logic [127:0] r_mem_data, 
input logic [127:0] wr_mem_data, 
input logic wvalid,
input logic awvalid,
input logic bready,
output logic bvalid,
output logic awready,
output logic wready
);
logic [31:0] memory_array [4147:0];
initial begin
        $readmemh("data.mem", memory_array);
    end

always_ff@(posedge clk, negedge rst) begin
    if (~rst) begin
        memory_array[addr_mem]<=0;
        memory_array[addr_mem+4]<=0;
        memory_array[addr_mem+8]<=0;
        memory_array[addr_mem+16]<=0;
        arready<=1;
        awready<=1;
        wready<=1;
        bvalid<=0;
        rvalid<=0;
    end else if (wvalid&awvalid&bready) begin
        memory_array[addr_mem]<=wr_mem_data[31:0];
        memory_array[addr_mem+4]<=wr_mem_data[63:32];
        memory_array[addr_mem+8]<=wr_mem_data[95:64];
        memory_array[addr_mem+12]<=wr_mem_data[127:96];
        bvalid<=1;
        wready<=0;
        awready<=0;
    end else if (arvalid&rready) begin
        r_mem_data<={memory_array[addr_mem+12],memory_array[addr_mem+8],memory_array[addr_mem+4],memory_array[addr_mem]};
        arready<=0;
        awready<=0;
        wready<=1;
        bvalid<=0;
        rvalid<=1;
    end
    else begin
        arready<=1;
        rvalid<=0;
        bvalid<=0;
        wready<=1;
        awready<=1;
    end
end

endmodule



