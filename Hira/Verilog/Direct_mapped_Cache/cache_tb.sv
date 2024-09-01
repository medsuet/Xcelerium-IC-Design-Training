`include "defs.svh"

module cache_tb;
    logic clk;
    logic rst;
    logic flush;
    logic [31:0] wr_data;
    logic [31:0] r_data;
    logic [6:0] opcode;
    logic [31:0] addr;
    logic dest_ready;
    logic src_ready;
    logic dest_valid;
    logic src_valid;
    logic done=0;
    logic [31:0] data_in_cache;
    logic d_clear,tag_en,arvalid,rvalid,rready,arready,awvalid;
    logic wvalid,awready,wready,bvalid,bready,rd_mem_req,wr_mem_req,wr_rd_mem_req,ready_mem;
    int mem_array[integer];
    logic [31:0] address;
    logic [31:0] read_data;

    top_cache dut (
        .clk(clk),
        .rst(rst),
        .flush(flush),
        .wr_data(wr_data),
        .r_data(r_data),
        .opcode(opcode),
        .addr(addr),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready)
    );
    axi_ctrl dut_axi (
        .clk(clk),
        .rst(rst),
        .d_clear(d_clear),
        .tag_en(tag_en),
        .en_line(en_line),
        .arvalid(arvalid),
        .rvalid(rvalid),
        .arready(arready),
        .rready(rready),
        .wvalid(wvalid),
        .bvalid(bvalid),
        .wready(wready),
        .bready(bready),
        .awvalid(awvalid),
        .awready(awready), 
        .ready_mem(ready_mem),
        .rd_mem_req(rd_mem_req),
        .wr_mem_req(wr_mem_req),
        .wr_rd_mem_req(wr_rd_mem_rq),
        .en_valid(en_valid)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
    int i;
    logic [31:0] memory_array [4163:0];
    $readmemh("C:/Users/HP/Desktop/Cache-AXI/data.mem", memory_array);
    for (i = 0; i < 4000; i++) begin
      mem_array[i * 4] = memory_array[i * 4]; 
    end
    end

    initial begin
        src_valid <= 0;
        dest_ready <= 0;
        opcode <= 0;
        flush <= 0;
        addr <= 0;
        wr_data <= 0;
        dut.sep <= 0;
        
        rst = 0;
        #100;
        rst = 1;
        @(posedge clk);
        
        fork
            driver_src();
            monitor_src();
        join
        fork
            test_for_read_mem();
            rd_mem_driver();
            monitor();
        join
        fork
            test_for_write_mem();
            wr_mem_driver();
            monitor();

        join

        $stop;
    end

    task read_cache(logic [31:0] addr_rd);
    begin
        src_valid <= 1;
        opcode <= `OPCODE_L;
        addr <= addr_rd;
        while (!src_ready) begin
            @(posedge clk);
        end
        @(posedge clk);
        src_valid <= 0;
        while (!dest_valid) begin
            @(posedge clk);
        end
        @(posedge clk);
        dest_ready<=1;
        @(posedge clk);
        dest_ready<=0;
    end
    endtask
        

    task write_cache(logic [31:0] addr_wr, logic [31:0] data_wr);
    begin
        mem_array[addr_wr]=data_wr;
        src_valid<=1;
        opcode<=`OPCODE_S;
        addr<=addr_wr;
        wr_data<=data_wr;
        flush<=0;
        while (!src_ready) begin
            @(posedge clk);
        end
        @(posedge clk);
        src_valid<=0;
        while (!dest_valid) begin
            @(posedge clk);
        end
        dest_ready<=1;
        @(posedge clk);
        dest_ready<=0;
    end
    endtask

    task flush_cache();
    begin
        src_valid<=1;
        opcode<=0;
        flush<=1;
        while (!src_ready) begin
            @(posedge clk);
        end
        @(posedge clk);
        src_valid<=0;
        while (!dest_valid) begin
            @(posedge clk);
        end
        dest_ready<=1;
        @(posedge clk);
        dest_ready<=0;
        done=1;
        flush=0;
    end
    endtask

    task driver_src();
    begin
        
        //=============Write Cache Hit==============
        @(posedge clk);
        write_cache(32'h00000004,32'h32323232);

        //===================Read Cache Hit===================
        @(posedge clk);
        read_cache(32'h00000004);

        //=============Read Cache Miss=============
        @(posedge clk);
        read_cache(32'h00001014);

        //=============Write Cache Miss=============
        @(posedge clk);
        write_cache(32'h00001020,32'ha5321a4f);
        @(posedge clk);
        read_cache(32'h00001020);

        //=============Read Cache Miss with dirty=1=============
        @(posedge clk);
        read_cache(32'h00000020);

        //=============Write Cache Miss with dirty=1=============
        @(posedge clk);
        write_cache(32'h00001000,32'h6a6a6a6a);
        @(posedge clk);
        read_cache(32'h00001000);

        //=============Flushing=============
        flush_cache();
        
    end
    endtask

    task monitor_src();
    begin
        while (!done) begin
            @(posedge clk);
            $display("============================================");
            if (~flush) begin
                while (!src_valid) begin
                    @(posedge clk);
                end
                if (src_valid) begin
                    $display("Valid asserted");

                    if (opcode == `OPCODE_L) begin
                        $display("================================");
                        $display("=                              =");
                        $display("=          Load Request        =");
                        $display("=                              =");
                        $display("================================");
                        $display("Read Operation: addr = %h", addr);
                    end else if (opcode == `OPCODE_S) begin
                        $display("================================");
                        $display("=                              =");
                        $display("=         Store Request        =");
                        $display("=                              =");
                        $display("================================");
                        $display("Write Operation: addr = %h, data = %h", addr, wr_data);
                    end
                end
                @(posedge clk);
                if (dut.cpu_request) begin
                    $display("CPU Request detected");
                end
                if (dut.rd_req) begin
                    $display("Read Request detected");
                end
                if (dut.wr_req) begin 
                    $display("Write Request detected");
                    //if (dut.dirty_ff) @(posedge clk);
                end
                @(posedge clk);
                if (dut.cache_hit) begin 
                    $display("Cache Hit");
                end
                if (dut.cache_miss)
                begin 
                    $display("Cache Miss"); 
                    if (dut.dirty_ff) $display("Dirty bit");
                end

                while (!dest_ready) begin
                    @(posedge clk);
                end
                if (dest_ready) begin
                    $display("Ready asserted, operation completed");
                    $display("Cache Read data: %h", r_data);
                    $display("============================================");
                end
                if (opcode == `OPCODE_L) begin
                    if (r_data == mem_array[addr]) begin
                        $display("Actual Cache Data %h", r_data);
                        $display("Actual Data is %h",mem_array[addr]);
                        $display("======Success======\n\n\n");
                    end else begin
                        $display("Actual Cache Data %h", r_data);
                        $display("Actual Data is %h",mem_array[addr]);
                        $display("======Fail======\n\n\n");
                    end
                end
            end else if (flush) begin
                $display("================================");
                $display("=                              =");
                $display("=            FLUSH             =");
                $display("=                              =");
                $display("================================");
                @(posedge clk);
                while (dut.dp.dirty_reg) begin
                    while (!dut.dirty_ff) begin
                        @(posedge clk);
                    end
                    if (dut.dirty_ff) begin
                        $display("Writeback to Memory");
                    end
                    @(posedge clk);
                end
                $display("Dirty Bits %h",dut.dp.dirty_reg);
                while (dut.dp.valid_reg) begin
                    @(posedge clk);
                end
                if (dut.dp.valid_reg==0) begin
                    $display("Valid Bits Clear");
                end
                while (!dest_ready) begin
                    @(posedge clk);
                end
                $display("============================================\n\n\n");
                @(posedge clk);
            end
        end
    end
    endtask
    task test_for_read_mem();
    begin
        @(posedge clk);
        dut.sep<=1;
        src_valid<=1;
        opcode<=`OPCODE_L;
        addr<=32'h00001020;
        while (!src_ready) begin
            @(posedge clk);
        end
        @(posedge clk);
        src_valid<=0;
        while(!dest_valid) begin
            @(posedge clk);
        end
        dest_ready<=1;
        @(posedge clk);
        dest_ready<=0;
        dut.sep<=0;
        
    end
    endtask
    task test_for_write_mem();
    begin
        @(posedge clk); 
        dut.sep<=0;
        @(posedge clk); 
        src_valid<=1;
        opcode<=`OPCODE_S;
        addr<=32'h00001030;
        wr_data<=32'h32323232;
        while (!src_ready) begin
            @(posedge clk);
        end
        @(posedge clk);
        src_valid<=0;
        while(!dest_valid) begin
            @(posedge clk);
        end
        dest_ready<=1;
        @(posedge clk);
        dest_ready<=0;

        @(posedge clk);
        dut.sep<=1;
        src_valid<=1;
        opcode<=`OPCODE_L;
        addr<=32'h00000030;
        while (!src_ready) begin
            @(posedge clk);
        end
        @(posedge clk);
        src_valid<=0;
        while(!dest_valid) begin
            @(posedge clk);
        end
        dest_ready<=1;
        @(posedge clk);
        dest_ready<=0;
        
    end
    endtask
    task rd_mem_driver(); 
    begin
        $display("================================");
        $display("=                              =");
        $display("=         AXI Read Test        =");
        $display("=                              =");
        $display("================================");
        dut.memory.ar_ready<=1;
        while(!dut.memory.arvalid) begin
            @(posedge clk);
        end
        dut.memory.ar_ready<=0;
        @(posedge clk);
        dut.memory.r_valid<=1;
        while(!rready) begin
            @(posedge clk);
        end
        @(posedge clk);
        dut.memory.r_valid<=0;
        dut.sep<=0;
    end
    endtask
    task wr_mem_driver(); 
    begin
        $display("================================");
        $display("=                              =");
        $display("=        AXI Write Test        =");
        $display("=                              =");
        $display("================================");
        while (!dut.sep) begin
            @(posedge clk);
        end
        @(posedge clk);
        dut.memory.aw_ready<=1;
        dut.memory.w_ready<=1;
        while(!dut.memory.wvalid|!dut.memory.awvalid) begin
            @(posedge clk);
        end
        address<=dut.memory.addr_mem;
        dut.memory.aw_ready<=0;
        dut.memory.w_ready<=0;
        @(posedge clk);
        dut.memory.b_valid<=1;
        while(!bready) begin
            @(posedge clk);
        end
        @(posedge clk);
        dut.memory.b_valid<=0;
        rd_mem_driver();
    end
    endtask
    task wr_mem_monitor();
    begin

        while (!dut.sep) begin
            @(posedge clk);
        end
        @(posedge clk);
        while(!dest_ready) begin
            @(posedge clk);
        end
        
    end
    endtask
    task monitor();
    begin
        while (!dut.sep) begin
            @(posedge clk);
        end

        while(!dest_ready) begin
            @(posedge clk);
        end
        if (dest_ready) begin
            if (r_data==mem_array[addr]) begin
                $display("Read data from memory is %h",mem_array[addr]);
                $display(" Cache Data is %h",r_data);
                $display("=======Success======\n\n\n");
            end else begin
                $display("Read data from memory is %h",r_data);
                $display(" Cache Data is %h",mem_array[addr]);
                $display("=======Failure======\n\n\n");
            end
            $display("============================================");
        end
        
    end
    endtask


endmodule
