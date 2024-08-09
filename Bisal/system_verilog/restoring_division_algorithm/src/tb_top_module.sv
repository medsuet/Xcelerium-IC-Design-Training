module tb_top_module;
    logic clk;
    logic reset;
    logic signed [31:0] Q;
    logic signed [31:0] M;
    logic src_valid;
    logic dst_ready;
    logic dst_valid;
    logic src_ready;
    logic [31:0] Quotient;
    logic [31:0] Remainder;

    Top_Module uut (
        .clk(clk),
        .reset(reset),
        .src_valid(src_valid),
        .dst_ready(dst_ready),
        .Q(Q),
        .M(M),
        .Quotient(Quotient),
        .Remainder(Remainder),
        .src_ready(src_ready),
        .dst_valid(dst_valid)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // RESET SEQUENCE
        reset = 1;
        dst_ready = 0;
        src_valid = 0;
        Q = 32'h0000;
        M = 32'h0000; 
        @(posedge clk);
        reset = 0;

        Q=12;
        M=2;
        src_valid = 1;
        @(posedge clk);
        while (!src_ready) begin
            @(posedge clk);
        end
        src_valid = 0;

        dst_ready = 1;
        while (!dst_valid) begin
            @(posedge clk);
        end
        dst_ready = 0;

        $display("Monitor: Q = %d, M = %d, Quotient = %d, Remainder=%d", Q, M, Quotient,Remainder);
        repeat(2) @(posedge clk);

        $stop;
    end

endmodule