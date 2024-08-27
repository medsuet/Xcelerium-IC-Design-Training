module AXI_controller_tb;

logic clk, n_rst;

logic start_write;
logic start_read;

logic axi_ready;    // test
//logic [1:0] cpu_request;

// AW
logic aw_valid;
logic aw_ready; // test

// R
logic r_valid;  // test
logic r_ready;

// AR
logic ar_ready; // test
logic ar_valid;

// W
logic w_valid;  // test
logic w_ready;

// B
logic b_valid;  // test
logic b_ready;

AXI_controller  DUT
(   
    .clk(clk),
    .rst(n_rst),

    .w_req(start_write),
    .aw_ready(aw_ready),
    .w_ready(w_ready),
    .b_valid(b_valid),

    .r_req(start_read),
    .ar_ready(ar_ready),
    .r_valid(r_valid),

    .aw_valid(aw_valid),
    .w_valid(w_valid),
    .b_ready(b_ready),
   
    .ar_valid(ar_valid),
    .r_ready(r_ready),

    .ack(axi_ready)
);

initial begin
    clk = 1;
    forever begin
        clk = #20 ~clk;
    end
end

initial begin
    init_signals;
    rst_sequence;

    $display("\n\nTest Starts.\n");

    fork
        cache_write_read_driver;
        mem_awready_driver;
        mem_wready_driver;
        mem_bvalid_driver;
        mem_arready_driver;
        mem_rvalid_driver;
    join_any

    $display("\n\nTest Done.\n");

    @(posedge clk);
    $stop;
end

/* --------- cache write/read request --------- */
// master
task cache_write_read_driver;

    for (int i=0; i < 3; i++) begin
        // read/write request is zero for random delay
        repeat($urandom % 5) @(posedge clk);

        // apply the write request
        start_write = $urandom % 2;
        @(posedge clk);

        // wait for axi_ready if start write is 1
        if (start_write) 
        begin
            while (!axi_ready)
                @(posedge clk);
            start_write = 0;
        end

        // read/write request is zero for random delay
        repeat($urandom % 5) @(posedge clk);

        //apply the read request
        start_read = $urandom % 2;
        @(posedge clk);

        // wait for axi_ready if start read is 1;
        if (start_read)
        begin
            while (!axi_ready)
                @(posedge clk);
            start_read = 0;
        end
    end

endtask

// memory aw ready
task mem_awready_driver;
    while(1) begin
        
        @(posedge clk)
        while (!aw_valid)
            @(posedge clk);

        @(posedge clk);
        aw_ready = 1;

        @(posedge clk);
        aw_ready = 0;
    end
endtask

// memory w ready
task mem_wready_driver;
    while(1) begin
        
        @(posedge clk)
        while (!w_valid)
            @(posedge clk);

        @(posedge clk);
        w_ready = 1;

        @(posedge clk);
        w_ready = 0;
    end
endtask

// memory w ready
task mem_bvalid_driver;
    while(1) begin
        
        @(posedge clk)
        while (!b_ready)
            @(posedge clk);

        @(posedge clk);
        b_valid = 1;

        @(posedge clk);
        b_valid = 0;
    end
endtask

// r valid
task mem_rvalid_driver;
    while (1) begin
        @(posedge clk);
        while (!r_ready)
            @(posedge clk);

        @(posedge clk);
        r_valid = 1;

        @(posedge clk);
        r_valid = 0; 
    end
endtask

// ar ready
task mem_arready_driver;
    while (1) begin
        @(posedge clk);
        while (!ar_valid) 
            @(posedge clk);

        @(posedge clk);
        ar_ready = 1;

        @(posedge clk);
        ar_ready = 0;
    end
endtask

/* ---------- initialize signals ------------ */
task  init_signals;
    start_read = '0; start_write = '0; //axi_ready = '0;
    aw_ready = '0;  //aw_valid = '0;   // AW
    r_valid  = '0;  //r_ready  = '0;   // R
    ar_ready = '0;  //ar_valid = '0;   // AR
    w_ready  = '0;  //w_valid  = '0;   // W
    b_valid  = '0;  //b_ready  = '0;   // B
    n_rst    = 1;
    @(posedge clk); 
endtask

/* ---------- reset sequence ------------ */
task rst_sequence;
    n_rst <= '0;
    @(posedge clk);
    n_rst <= 1;
    @(posedge clk);
endtask

endmodule