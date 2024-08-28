parameter ADDRESS = 32;
parameter CPU_READ_DATA = 32;
parameter CPU_WRITE_DATA = 32;
parameter R_DATA = 32;
parameter W_DATA = 32;

module tb_cache;
    logic                        clk;
    logic                        rst;
    logic                        cpu_valid_req;
    logic                        cache_ready;
    logic  [1:0]                 cpu_req;
    logic  [ADDRESS-1:0]         cpu_address;
    logic  [CPU_WRITE_DATA-1:0]  cpu_write_data;
    logic  [CPU_READ_DATA-1:0]   cpu_read_data;
    logic                        AR_VALID;
    logic  [ADDRESS-1:0]         AR_ADDRESS;
    logic                        AR_READY;
    logic                        R_VALID;
    logic  [R_DATA-1:0]          R_DATA;
    logic                        R_READY;
    logic                        AW_VALID;
    logic  [ADDRESS-1:0]         AW_ADDRESS;
    logic                        AW_READY;
    logic                        W_VALID;
    logic  [W_DATA-1:0]          W_DATA;
    logic                        W_READY;
    logic                        B_VALID;
    logic                        B_RESPONSE;
    logic                        B_READY; 
    
    // Main Memory
    logic [31:0] memory [0:15];
    logic [31:0] dummy_memory [0:15];

    cache_top cache_dut (
        .clk(clk),
        .rst(rst),
        .cpu_valid_req(cpu_valid_req),
        .cache_ready(cache_ready),
        .cpu_request(cpu_req),              
        .cpu_address(cpu_address),
        .cpu_write_data(cpu_write_data),
        .cpu_read_data(cpu_read_data),
        .AR_VALID(AR_VALID),
        .AR_ADDRESS(AR_ADDRESS),
        .AR_READY(AR_READY),
        .R_VALID(R_VALID),
        .R_DATA(R_DATA),
        .R_READY(R_READY),
        .AW_VALID(AW_VALID),
        .AW_ADDRESS(AW_ADDRESS),
        .AW_READY(AW_READY),
        .W_VALID(W_VALID),
        .W_DATA(W_DATA),
        .W_READY(W_READY),
        .B_VALID(B_VALID),
        .B_RESPONSE(B_RESPONSE),
        .B_READY(B_READY)
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    task reset_circuit;
            rst = 0;
            #10;
            rst = 1;
    endtask

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end

    task init_memory;
        memory[0]  = 32'hffff_0000;
        memory[1]  = 32'hffff_0001;
        memory[2]  = 32'hffff_0002;
        memory[3]  = 32'hffff_0003;
        memory[4]  = 32'hffff_0004;
        memory[5]  = 32'hffff_0005;
        memory[6]  = 32'hffff_0006;
        memory[7]  = 32'hffff_0007;
        memory[8]  = 32'hffff_0008;
        memory[9]  = 32'hffff_0009;
        memory[10] = 32'hffff_000A;
        memory[11] = 32'hffff_000B;
        memory[12] = 32'hffff_000C;
        memory[13] = 32'hffff_000D;
        memory[14] = 32'hffff_000E;
        memory[15] = 32'hffff_000F;
    endtask

    task init_dummy_memory;
        dummy_memory[0]  = 32'hffff_0000;
        dummy_memory[1]  = 32'hffff_0001;
        dummy_memory[2]  = 32'hffff_0002;
        dummy_memory[3]  = 32'hffff_0003;
        dummy_memory[4]  = 32'hffff_0004;
        dummy_memory[5]  = 32'hffff_0005;
        dummy_memory[6]  = 32'hffff_0006;
        dummy_memory[7]  = 32'hffff_0007;
        dummy_memory[8]  = 32'hffff_0008;
        dummy_memory[9]  = 32'hffff_0009;
        dummy_memory[10] = 32'hffff_000A;
        dummy_memory[11] = 32'hffff_000B;
        dummy_memory[12] = 32'hffff_000C;
        dummy_memory[13] = 32'hffff_000D;
        dummy_memory[14] = 32'hffff_000E;
        dummy_memory[15] = 32'hffff_000F;
    endtask

    task init_sequence;
        cpu_valid_req = 0;
        cpu_req = 0;
        cpu_address = 0;
        cpu_write_data = 0;
        AR_READY = 1;
        R_VALID = 0;        
        AW_READY = 1;
        W_READY = 0;
        R_DATA = 0;
        B_VALID = 0;
        B_RESPONSE = 0;
    endtask

    task read_channel_driver;
        forever begin
            logic [31:0] local_addr;
            int unsigned random_delay;

            // Read Address Channel    
            AR_READY = 1;
            @(posedge clk);   
            while(!AR_VALID)
                @(posedge clk);
            AR_READY = 0;
            random_delay = $random % 10;
            repeat(random_delay) @(posedge clk);
            local_addr = AR_ADDRESS;        
            @(posedge clk);
            AR_READY = 1;

            // Read Data Channel
            R_VALID = 1;
            R_DATA = memory[local_addr[3:0]];
            @(posedge clk);
            while(!R_READY)
                @(posedge clk);
            R_VALID = 0;
        end
    endtask

    task write_channel_driver;
        forever begin
            logic [31:0] local_addr;
            int unsigned random_delay; 
            logic [31:0] local_data;
            begin

                // Write Address Channel
                AW_READY = 1;
                W_READY = 0;
                @(posedge clk);
                while(!AW_VALID)
                    @(posedge clk);
                @(posedge clk);
                AW_READY = 0;
                local_addr = AW_ADDRESS;
                random_delay = $random % 10;
                repeat(random_delay) @(posedge clk);
                AW_READY = 1;

                // Write Data Channel
                W_READY = 1;
                @(posedge clk);
                while(!W_VALID)
                    @(posedge clk);
                W_READY = 0;
                local_data = W_DATA;
                repeat(random_delay) @(posedge clk);
                memory[AW_ADDRESS[3:0]] = local_data;
                W_READY = 1;

                // Write Response Channel
                B_VALID = 1;
                @(posedge clk);
                while(!B_READY) begin
                    @(posedge clk);
                end
                @(posedge clk);
                B_VALID = 0;
            end
        end
    endtask

    task drive_inputs;
        begin
            for (int i=0; i<10; i++) begin
                cpu_valid_req  = 1;  

                // cpu_req = ($random % 2) ? 2'b01 : 2'b00;
                cpu_req        = 0;
                cpu_address    = $random;
                // cpu_write_data = $random;
                cpu_write_data = 0;

                while (!cache_ready) begin
                    @(posedge clk);
                end
                @(posedge clk);
                cpu_valid_req = 0; 
                while (!cache_ready) begin
                    @(posedge clk);
                end
            end
        end
    endtask

    task automatic monitor;
        forever begin
            while (!cache_ready) begin
                @(posedge clk);
            end
            @(posedge clk);
            while (!cache_ready) begin
                @(posedge clk);
            end
            if (cpu_req == 2'b00) begin
                if (cpu_read_data == memory[cpu_address[3:0]]) begin
                    $display("Correct");
                end 
                else if (cpu_read_data != dummy_memory[cpu_address[3:0]]) begin
                    $display("Incorrect");
                end 
            end
            else if (cpu_req == 2'b01) begin
                if (cpu_write_data == dummy_memory[cpu_address[3:0]]) begin
                    $display("Correct");
                end 
                else if (cpu_write_data != dummy_memory[cpu_address[3:0]]) begin
                    $display("Incorrect");
                end 
            end
        end
    endtask
 
    initial begin
        init_memory;
        init_dummy_memory;
        init_sequence;
        reset_circuit;
        @(posedge clk);

        fork
            drive_inputs;
            read_channel_driver;
            write_channel_driver;
            monitor;
        join_any
        $finish;
    end

endmodule

