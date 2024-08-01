module sequential_multiplier_tb();
    logic CLK;
    logic RST;
    logic [15:0] A;
    logic [15:0] B;
    logic src_valid_in;
    logic src_ready_in;
    logic dist_ready_out;
    logic dist_valid_out;
    logic [31:0] PRODUCT;
    int processing;

    // Instantiate the sequential_multiplier
    sequential_multiplier uut(
        .CLK(CLK),
        .RST(RST),
        .A(A),
        .B(B),
        .src_valid_in(src_valid_in),
        .src_ready_in(src_ready_in),
        .dist_ready_out(dist_ready_out),
        .dist_valid_out(dist_valid_out),
        .PRODUCT(PRODUCT)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    task reset();
        begin
        // Initialize signals
        RST <= #1 0;
        @(posedge CLK)
        RST = 1;
        dist_ready_out <= #1 0;
        end
    endtask

    // Task to apply inputs and check output
    task directed_test(input logic [15:0] test_A, input logic [15:0] test_B);
        begin
            A <= #1 test_A;
            B <= #1 test_B;
            src_valid_in <= #1 1;
            @(negedge src_valid_in);
            repeat(16) @(posedge CLK);          //wait for 17 clk cycles 1 extra cyclee need for S2


            repeat(2) @(posedge CLK);
            dist_ready_out <= #1 1;
            @(negedge dist_ready_out);

            @(posedge CLK);
        end
    endtask

    task src_valid_in_result();
        logic src_valid_in_check;
        begin
            while(processing)
            begin
                @(posedge CLK);
                src_valid_in_check = (src_ready_in) & (src_valid_in);
                if(src_valid_in_check)
                begin
                    src_valid_in <= #1 0;   
                end
            end
        end
    endtask



    task dist_ready_out_result();
        logic dist_ready_out_check;
        begin
            while(processing)
            begin
                @(posedge CLK);
                dist_ready_out_check = (dist_ready_out) & (dist_valid_out);
                if(dist_ready_out_check)
                begin
                    dist_ready_out <= #1 0;   
                end
            end
        end
    endtask


    // Test sequence
    initial begin
        reset();
        processing = 1;
        fork
            src_valid_in_result();
            dist_ready_out_result();
            begin
                directed_test(-3,3);
                directed_test(4,5);
                processing = 0;
            end
        join

        $stop;
        // Finish the simulation
        $finish;
    end
endmodule
