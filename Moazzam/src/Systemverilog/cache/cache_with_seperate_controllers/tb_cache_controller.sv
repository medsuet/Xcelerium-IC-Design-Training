module tb_cache_controller();

    // Testbench signals
    logic clk;
    logic rst;
    logic cpu_request;
    logic src_valid;
    logic req_type;
    logic cache_hit;
    logic dirty;
    logic axi_ack;
    logic flush;
    logic flush_done;
    logic flush_req;

    // Outputs from DUT
    logic src_ready;
    logic [1:0] dirty_sel;
    logic [1:0] valid_sel;
    logic rd_en;
    logic wr_en;
    logic mem_wr_req;
    logic index_sel;
    logic mem_rd_req;
    logic [1:0] data_sel;
    logic count_en;
    logic count_clear;
    logic reg_flush_en;

    // Instantiate the DUT (Device Under Test)
    cache_controller uut (
        .clk(clk),
        .rst(rst),
        .cpu_request(cpu_request),
        .src_valid(src_valid),
        .req_type(req_type),
        .cache_hit(cache_hit),
        .dirty(dirty),
        .axi_ack(axi_ack),
        .flush(flush),
        .flush_done(flush_done),
        .flush_req(flush_req),
        .src_ready(src_ready),
        .dirty_sel(dirty_sel),
        .valid_sel(valid_sel),
        .rd_en(rd_en),
        .wr_en(wr_en),
        .mem_wr_req(mem_wr_req),
        .index_sel(index_sel),
        .mem_rd_req(mem_rd_req),
        .data_sel(data_sel),
        .count_en(count_en),
        .count_clear(count_clear),
        .reg_flush_en(reg_flush_en)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Reset task
    task reset_dut();
        begin
            rst <= #1 0;
            @(posedge clk); 
            rst <= # 1 1;
            //@(posedge clk); 
        end
    endtask
    //task driver
    task driver(
        input logic cpu_request_in,
        input logic src_valid_in,
        input logic req_type_in,
        input logic cache_hit_in,
        input logic dirty_in,
        input logic axi_ack_in,
        input logic flush_in,
        input logic flush_done_in,
        input logic flush_req_in
    );
        begin
            cpu_request <= cpu_request_in;
            src_valid   <= src_valid_in;
            req_type    <= req_type_in;
            cache_hit   <= cache_hit_in;
            dirty       <= dirty_in;
            axi_ack     <= axi_ack_in;
            flush       <= flush_in;
            flush_done  <= flush_done_in;
            flush_req   <= flush_req_in;
            @(posedge clk);                  // wait for a clock cycle
        end
    endtask

    // task monitor
    task monitor();
        begin
            @(posedge clk);
            $display("Time: %0t, src_ready: %b, dirty_sel: %b, valid_sel: %b, rd_en: %b, wr_en: %b, mem_wr_req: %b, index_sel: %b, mem_rd_req: %b, data_sel: %b, count_en: %b, count_clear: %b, reg_flush_en: %b",
                    $time, src_ready, dirty_sel, valid_sel, rd_en, wr_en, mem_wr_req, index_sel, mem_rd_req, data_sel, count_en, count_clear, reg_flush_en);
        end
    endtask

    //calling_tasks
    initial
    begin
        reset_dut();
        fork
            begin
                // Test 1: Simple cache request hit
                driver(1, 1, 1, 1, 0, 0, 0, 0, 0);
                monitor();
                // Test 2: Cache miss and clean block
                driver(1, 1, 0, 0, 0, 1, 0, 0, 0);
                monitor();
                //Test 3: memeory read operation
                driver(1, 1, 0, 0, 0, 1, 0, 0, 0);
                monitor();
                // Test 4: Cache miss and dirty block writeback needed
                driver(1, 1, 0, 0, 1, 1, 0, 0, 0);
                monitor();
                // Test 5: Flush request
                driver(0, 1, 0, 0, 0, 0, 0, 1, 1);
                monitor();
                //Test 6: check to enable_count
                driver(0, 1, 0, 0, 0, 0, 0, 0, 1);
                monitor();
                $finish;
            end
        join
    end
endmodule
















 //   end
//endmodule
    //task driver(
    //    input logic cpu_request_in,
    //    input logic src_valid_in,
    //    input logic req_type_in,
    //    input logic cache_hit_in,
    //    input logic dirty_in,
    //    input logic axi_ack_in,
    //    input logic flush_in,
    //    input logic flush_done_in,
    //    input logic flush_req_in
    //);
        //begin
        //    cpu_request <= cpu_request_in;
        //    src_valid   <= src_valid_in;
        //    req_type    <= req_type_in;
        //    cache_hit   <= cache_hit_in;
        //    dirty       <= dirty_in;
        //    axi_ack     <= axi_ack_in;
        //    flush       <= flush_in;
        //    flush_done  <= flush_done_in;
        //    flush_req   <= flush_req_in;
        //    @(posedge clk); // Wait for a clock cycle
        //end
    //endtask

    // Monitor to observe DUT outputs
    //task monitor();
    //    begin
    //        @(posedge clk);
    //        $display("Time: %0t, src_ready: %b, dirty_sel: %b, valid_sel: %b, rd_en: %b, wr_en: %b, mem_wr_req: %b, index_sel: %b, mem_rd_req: %b, data_sel: %b, count_en: %b, count_clear: %b, reg_flush_en: %b",
    //                 $time, src_ready, dirty_sel, valid_sel, rd_en, wr_en, mem_wr_req, index_sel, mem_rd_req, data_sel, count_en, count_clear, reg_flush_en);
    //    end
    //endtask

    // Test sequence
    //initial begin
    //    reset_dut();
//
    //    // Test 1: Simple cache request hit
    //    driver(1, 1, 1, 1, 0, 0, 0, 0, 0);
    //    monitor();
//
    //    // Test 2: Cache miss and clean block
    //    driver(1, 1, 0, 0, 0, 1, 0, 0, 0);
    //    monitor();
//
    //    // Test 3: Cache miss and dirty block (writeback needed)
    //    driver(1, 1, 0, 0, 1, 1, 0, 0, 0);
    //    monitor();
//
    //    // Test 4: Flush request
    //    driver(0, 1, 0, 0, 0, 0, 0, 1, 1);
    //    monitor();
//
    //    //Test 5: check to enable_count
    //    driver(0, 1, 0, 0, 0, 0, 0, 0, 1);
    //    monitor();
//
    //    $finish;
    //end
//endmodule
