module cache_mem_axi4_tb #(
parameter ADDR_WIDTH = 32,
parameter BLOCK_SIZE = 128,
parameter WORD_SIZE = 32,
parameter TAG_SIZE = 18,
parameter NUM_LINES = 1024,
parameter INDEX_WIDTH = 10,
parameter BLOCK_OFFSET = 4
)();
    logic clk;
    logic rst;
    logic flush;
    logic cpu_wr_en;
    logic mem_ack;
    logic axi_AWREADY;
    logic axi_ARREADY;
    logic axi_WREADY;
    logic axi_RVALID;
    logic axi_BVALID;
    logic [ADDR_WIDTH-1:0] address;
    logic [BLOCK_SIZE-1:0] read_data_mem;
    logic [WORD_SIZE-1:0] write_data_cpu;
    logic [BLOCK_SIZE-1:0] modf_data_mem;
    logic [WORD_SIZE-1:0] read_data_cpu;
    logic [ADDR_WIDTH-1:0] memory_address;
    logic axi_AWVALID;
    logic axi_ARVALID;
    logic axi_WVALID;
    logic axi_RREADY;
    logic axi_BREADY;
    logic cpu_valid;
    logic cpu_ready;
    
    logic [WORD_SIZE-1:0] mem [0:NUM_LINES-1];  
    logic [WORD_SIZE-1:0] mem_main [0:NUM_LINES-1];  

    logic [15:0] valid_read_count;
    logic [15:0] valid_write_count;
    logic [9:0] invalid_count;

    cache_mem_axi4 dut(
        .clk(clk),
        .rst(rst),
        .cpu_wr_en(cpu_wr_en),
        .flush(flush),
        .mem_ack(mem_ack),
        .cpu_valid(cpu_valid),
        .axi_AWREADY(axi_AWREADY),
        .axi_ARREADY(axi_ARREADY),
        .axi_WREADY(axi_WREADY),
        .axi_RVALID(axi_RVALID),
        .axi_BVALID(axi_BVALID),
        .address(address),
        .read_data_mem(read_data_mem),
        .write_data_cpu(write_data_cpu),
        .modf_data_mem(modf_data_mem),
        .read_data_cpu(read_data_cpu),
        .memory_address(memory_address),
        .src_valid(src_valid),
        .axi_AWVALID(axi_AWVALID),
        .axi_ARVALID(axi_ARVALID),
        .axi_WVALID(axi_WVALID),
        .axi_RREADY(axi_RREADY),
        .axi_BREADY(axi_BREADY),
        .cpu_ready(cpu_ready)
    );

    initial begin
//         $dumpfile("cache_mem_axi4_tb.vcd");
//         $dumpvars(0, cache_mem_axi4_tb);

        $readmemh("hello.hex", mem);
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        forever begin
            memory();
            @(posedge clk);
        end
    end

    initial begin
        // Reset Sequence 
        reset(5);
        // Initial value of signal
        init_sequence();
        // Reading the cache after reset
        cpu(0, 0, 32'hx, 0);
        cpu(0, 0, 32'hx, 4);
        cpu(0, 0, 32'hx, 8);
        cpu(0, 0, 32'hx, 12);
        // Reading the cache with different addr
        cpu(0, 0, 32'hx, 16);
        cpu(0, 0, 32'hx, 20);
        cpu(0, 0, 32'hx, 24);
        cpu(0, 0, 32'hx, 28);
        // Writing cache from cpu data and then Reading 
        cpu(1, 0, 32'h4, 20);
        cpu(0, 0, 32'h4, 20);
        // Reading the cache with different tag but same index to check for dirty bit and then write to the main memory
        cpu(0, 0, 32'hx, 32'hC0000010);
        cpu(0, 0, 32'hx, 32'hC0000014);
        cpu(0, 0, 32'hx, 32'hC0000018);
        cpu(0, 0, 32'hx, 32'hC000001C);
        // Flush the cache
        cpu(0, 1, 32'hx, 32'hC000001C);
        flush <= 0;
        repeat(4) @(posedge clk);

        fork 
            driver();
            monitor();
        join
        $display("Valid Writes = %d Valid Reads = %d", valid_write_count, valid_read_count);
        $finish;
    end

    task init_sequence;
        mem_ack = 0;
        cpu_valid = 0;
        axi_AWREADY = 0;
        axi_ARREADY = 0;
        axi_WREADY = 0;
        axi_RVALID = 0;
        axi_BVALID = 0;
        invalid_count = 0;
        valid_write_count = 0;
        valid_read_count = 0;
    endtask

    task reset(input logic [7:0] a);
        rst = 1;
        #a rst = 0;
        #a rst = 1;
    endtask

    task cpu(input logic operation, input logic fls, input logic [WORD_SIZE-1:0] data_from_cpu, input logic [ADDR_WIDTH-1:0] addr);
        cpu_wr_en <= operation;
        address <= addr;
        write_data_cpu <= data_from_cpu;
        flush <= fls;
        cpu_valid <= 1;
        while (!cpu_ready) @(posedge clk);
        @(posedge clk);
        if (operation) begin
            mem_main[address] = data_from_cpu;
        end else if (dut.hit) begin
            mem_main[address] = read_data_cpu;
        end
        cpu_valid <= 0;
        @(posedge clk);
        while (!cpu_ready) @(posedge clk);
    endtask

    task memory;
        fork
            mem_wr_tsk();
            mem_rd_tsk();
        join_any
    endtask

    task mem_wr_tsk;
        logic [3:0] rand_num;
        logic [WORD_SIZE-1:0] addr;
        rand_num <= $random;
        while(!axi_AWVALID & !axi_WVALID) @(posedge clk);
        repeat(rand_num) @(posedge clk);
        axi_AWREADY <= 1;
        axi_WREADY <= 1;
        addr = {memory_address[WORD_SIZE-1:4], {4{1'b0}}};
        {mem[addr], mem[addr+1], mem[addr+2], mem[addr+3]} = modf_data_mem;
        axi_BVALID <= 1;
        while (!axi_BREADY) @(posedge clk);
        while (!dut.axi_ready) @(posedge clk);
        mem_ack <= dut.axi_ready; 
        @(posedge clk);
        mem_ack <= dut.axi_ready;
    endtask

    task mem_rd_tsk;
        logic [3:0] rand_num;
        rand_num = $random;
        while(!axi_ARVALID) @(posedge clk);
        repeat(rand_num) @(posedge clk);
        axi_ARREADY <= 1;
        axi_RVALID <= 1;
        read_data_mem = {mem[memory_address], mem[memory_address+1], mem[memory_address+2], mem[memory_address+3]};
        while (!axi_RREADY) @(posedge clk); 
        while (!dut.axi_ready) @(posedge clk);
        mem_ack <= dut.axi_ready;
        @(posedge clk);
        if (!cpu_wr_en) mem_main[memory_address] = read_data_cpu;
        mem_ack <= dut.axi_ready;
        axi_ARREADY <= 0;
        axi_RVALID <= 0;
    endtask

    task driver;
        logic operation;
        logic fls;
        logic [WORD_SIZE-1:0] data_from_cpu;
        logic [ADDR_WIDTH-1:0] addr;
        logic [5:0] addr_rand;
        
        for (int i=0; i<10000; i++) begin
            operation = $random;
            fls = 0;
            data_from_cpu = $random;
            addr_rand = $random;
            addr = {{26{1'b0}}, addr_rand};
            cpu(operation, fls, data_from_cpu, addr);
        end
    endtask

     task monitor;
         for (int j=0; j<10000; j++) begin
             while (!cpu_valid & !cpu_ready) @(posedge clk);
             repeat(2) @(posedge clk);
             if (mem_main[memory_address] == write_data_cpu) begin
                 valid_write_count++;
             end else if (!dut.hit) begin
                 while (!mem_ack) @(posedge clk);
                 @(posedge clk);
                 if (mem_main[memory_address] == read_data_cpu) begin
                     valid_read_count++;
                 end else begin
//                       $display("mem: %h cpur: %h cpuw: %h addr: %h addr_tsk: %h cpu_req: %h cpu_req_tsk; %h", mem_main[memory_address], read_data_cpu, write_data_cpu, memory_address, cpu.addr, cpu_wr_en, cpu.operation);
                      invalid_count++;
                 end
             end else if (dut.hit) begin
                 if (mem_main[memory_address] == read_data_cpu) begin
                     valid_read_count++;
                 end else begin
//                       $display("mem: %h cpur: %h cpuw: %h addr: %h addr_tsk: %h cpu_req: %h cpu_req_tsk; %h", mem_main[memory_address], read_data_cpu, write_data_cpu, memory_address, cpu.addr, cpu_wr_en, cpu.operation);
                     invalid_count++;
                 end
             end
        end
    endtask
endmodule
