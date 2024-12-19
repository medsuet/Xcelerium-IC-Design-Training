module axi_tb;

    // Clock and reset signals
    logic clk;
    logic rst;

    // Inputs to the DUT (Device Under Test)
    logic rd_mem_req;
    logic wr_mem_req;
    logic wr_rd_mem_req;
    logic rvalid;
    logic wready;
    logic awready;
    logic arvalid;
    logic wvalid;
    logic awvalid;
    logic bvalid;
    logic arready;

    // Outputs from the DUT
    logic rready;
    logic bready;
    logic ready_mem;
    logic d_clear;
    logic tag_en;
    logic en_line;

    // DUT instance
    axi_ctrl uut (
        .clk(clk),
        .rst(rst),
        .rd_mem_req(rd_mem_req),
        .wr_mem_req(wr_mem_req),
        .wr_rd_mem_req(wr_rd_mem_req),
        .rvalid(rvalid),
        .wready(wready),
        .awready(awready),
        .arvalid(arvalid),
        .rready(rready),
        .wvalid(wvalid),
        .awvalid(awvalid),
        .bready(bready),
        .ready_mem(ready_mem),
        .bvalid(bvalid),
        .arready(arready),
        .d_clear(d_clear),
        .tag_en(tag_en),
        .en_line(en_line)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        rd_mem_req = 0;
        wr_mem_req = 0;
        wr_rd_mem_req = 0;
        rvalid = 0;
        wready = 0;
        awready = 0;
        arvalid = 0;
        wvalid = 0;
        awvalid = 0;
        bvalid = 0;
        arready = 0;

        // Apply reset
        rst = 0;
        #100;
        rst = 1;
        @(posedge clk);


        // Test case 1: Write request without read
        wr_mem_req = 1;
        wvalid = 1;
        awvalid = 1;
        repeat(5)@(posedge clk);
        awready = 1;
        wready = 1;
        repeat(5)@(posedge clk);
        bvalid = 1;
        @(posedge clk);
        wr_mem_req = 0;
        bvalid = 0;

        // Test case 2: Write and read combined request
        wr_rd_mem_req = 1;
        wvalid = 1;
        awvalid = 1;
        arvalid = 1;
        awready = 1;
        wready = 1;
        arready = 1;
        #10;
        bvalid = 1;
        #10;
        rvalid = 1;
        #20;
        wr_rd_mem_req = 0;
        rvalid = 0;
        bvalid = 0;

        // Test case 3: Read request only
        rd_mem_req = 1;
        arvalid = 1;
        arready = 1;
        #10;
        rvalid = 1;
        #20;
        rd_mem_req = 0;
        rvalid = 0;

        // End simulation
        #50;
        $stop;
    end
endmodule
