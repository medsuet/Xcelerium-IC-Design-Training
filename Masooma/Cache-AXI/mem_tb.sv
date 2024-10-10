module tb_mem;

    // Testbench signals
    logic clk;
    logic rst;
    logic rd_mem;
    logic mem_ack;
    logic [31:0] addr_mem;
    logic [127:0] r_mem_data;
    logic [127:0] wr_mem_data;
    logic wr_mem;

    // Instantiate the memory module
    mem uut (
        .clk(clk),
        .rst(rst),
        .rd_mem(rd_mem),
        .mem_ack(mem_ack),
        .addr_mem(addr_mem),
        .r_mem_data(r_mem_data),
        .wr_mem_data(wr_mem_data),
        .wr_mem(wr_mem)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 10 ns clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        rd_mem = 0;
        wr_mem = 0;
        addr_mem = 32'h0;
        wr_mem_data = 128'h0;
        
        // Reset the module
        #10 rst = 1;
        #10 rst = 0;
        #10 rst = 1;
        
        // Write data to memory
        addr_mem = 32'h4;
        wr_mem_data = 128'h1234567890ABCDEF;
        wr_mem = 1;
        #10 wr_mem = 0;

        // Read data from memory
        rd_mem = 1;
        #10 rd_mem = 0;

        // Wait for acknowledgment
        #10;
        if (mem_ack) begin
            $display("Memory acknowledgment received.");
            if (r_mem_data == wr_mem_data) begin
                $display("Data read from memory is correct.");
            end else begin
                $display("Data read from memory is incorrect. Expected: %h, Got: %h", wr_mem_data, r_mem_data);
            end
        end else begin
            $display("Memory acknowledgment not received.");
        end
        
        // End the simulation
        $stop;
    end

endmodule

