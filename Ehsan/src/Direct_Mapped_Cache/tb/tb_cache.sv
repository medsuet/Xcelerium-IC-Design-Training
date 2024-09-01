parameter ADDRESS = 32;
parameter CPU_READ_DATA = 32;
parameter CPU_WRITE_DATA = 32;
parameter R_DATA = 32;
parameter W_DATA = 32;

module tb_cache;

logic [31:0] input_address, input_data;
int number_of_tests;
int test_passed = 0;
int test_failed = 0;
//=================== Declearing Input And Outputs For UUT ===================//

    logic                        clk;
    logic                        rst;
    logic                        cpu_valid_req;
    logic                        cache_ready;
    logic  [1:0]                 cpu_req;
    logic  [ADDRESS-1:0]         cpu_address;
    logic  [CPU_WRITE_DATA-1:0]  cpu_write_data;
    logic  [CPU_READ_DATA-1:0]   cpu_read_data;
    logic                        ar_valid;
    logic  [ADDRESS-1:0]         ar_address;
    logic                        ar_ready;
    logic                        r_valid;
    logic  [R_DATA-1:0]          r_data;
    logic                        r_ready;
    logic                        aw_valid;
    logic  [ADDRESS-1:0]         aw_address;
    logic                        aw_ready;
    logic                        w_valid;
    logic  [W_DATA-1:0]          w_data;
    logic                        w_ready;
    logic                        b_valid;
    logic                        b_response;
    logic                        b_ready; 
    
//=============== Declearing Main Memory And Reference Memory ================//

    int main_memory [int];
    int reference_memory [int];

//=========================== Module Instantiation ===========================//

    cache_top cache_dut (
        .clk(clk),
        .rst(rst),
        .cpu_valid_req(cpu_valid_req),
        .cache_ready(cache_ready),
        .cpu_request(cpu_req),              
        .cpu_address(cpu_address),
        .cpu_write_data(cpu_write_data),
        .cpu_read_data(cpu_read_data),
        .ar_valid(ar_valid),
        .ar_address(ar_address),
        .ar_ready(ar_ready),
        .r_valid(r_valid),
        .r_data(r_data),
        .r_ready(r_ready),
        .aw_valid(aw_valid),
        .aw_address(aw_address),
        .aw_ready(aw_ready),
        .w_valid(w_valid),
        .w_data(w_data),
        .w_ready(w_ready),
        .b_valid(b_valid),
        .b_response(b_response),
        .b_ready(b_ready)
    );

//============================= Clock Generation =============================//

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

//============================== Reset Sequence ==============================//

    task reset_circuit;
            rst = 0;
            #10;
            rst = 1;
    endtask

//========================== Initialize The Signals ==========================//

    task init_sequence;
        cpu_valid_req = 0;
        cpu_req = 0;
        cpu_address = 0;
        cpu_write_data = 0;
        ar_ready = 1;
        r_valid = 0;        
        aw_ready = 1;
        w_ready = 1;
        r_data = 0;
        b_valid = 0;
        b_response = 0;
    endtask

//============================ Read Channel Of Axi ===========================//

    task read_channel_driver;
        forever begin
            logic [31:0] local_addr;
            int unsigned random_delay;

            // Read Address Channel    
            ar_ready = 1;
            @(posedge clk);   
            while(!ar_valid)
                @(posedge clk);
            ar_ready = 0;
            // Random Delay
            random_delay = $random % 10;
            repeat(random_delay) @(posedge clk);
            local_addr = ar_address;        
            @(posedge clk);
            ar_ready = 1;

            // Check If Entry Exit
            if (!main_memory.exists(local_addr)) begin
                main_memory[local_addr] = 1;
            end

            // Read Data Channel
            r_valid = 1;
            r_data = main_memory[local_addr];
            @(posedge clk);
            while(!r_ready)
                @(posedge clk);
            r_valid = 0;
        end
    endtask

//=========================== Write Channel Of Axi ===========================//

    task write_channel_driver;
        forever begin
            logic [31:0] local_addr;
            int unsigned random_delay; 
            logic [31:0] local_data;
            begin

                // Write Address Channel
                aw_ready = 1;
                w_ready = 0;
                @(posedge clk);
                while(!aw_valid)
                    @(posedge clk);
                @(posedge clk);
                aw_ready = 0;
                local_addr = aw_address;
                // Random Delay
                random_delay = $random % 10;
                repeat(random_delay) @(posedge clk);
                aw_ready = 1;

                // Write Data Channel
                w_ready = 1;
                @(posedge clk);
                while(!w_valid)
                    @(posedge clk);
                w_ready = 0;
                local_data <= w_data;
                repeat(random_delay) @(posedge clk);
                main_memory[local_addr] = local_data;
                w_ready = 1;

                // Write Response Channel
                b_valid = 1;
                @(posedge clk);
                while(!b_ready) begin
                    @(posedge clk);
                end
                @(posedge clk);
                b_valid = 0;
            end
        end
    endtask

//============================== Driving Inputs ==============================//

    task drive_inputs(
        input logic        cpu_valid_i,
        input logic [1:0]  cpu_req_i,
        input logic [31:0] cpu_address_i,
        input logic [31:0] cpu_write_data_i
    );
        begin
            @(posedge clk);
            cpu_valid_req  = cpu_valid_i;  
            cpu_req        = cpu_req_i;
            cpu_address    = cpu_address_i;
            cpu_write_data = cpu_write_data_i;
            @(posedge clk);
            while (!cache_ready) begin
                @(posedge clk);
            end
            @(posedge clk);
            cpu_valid_req = 0; 
            while (!cache_ready) begin
                @(posedge clk);
            end 
        end
    endtask

//============================ Monitoring Outputs ============================//

    task monitor;
        logic [31:0] m_addr;
        forever begin
            m_addr = cpu_address;
            while (cpu_req != 2'b01) begin
                @(posedge clk);
            end
            reference_memory[m_addr] = cpu_write_data;            
            while (cpu_req != 2'b00) begin
                @(posedge clk);
            end
            while (!cache_ready) begin
                @(posedge clk);
            end        

            if (cpu_read_data == reference_memory[m_addr]) begin
                test_passed++;
            end 
            else begin
                $display("Incorrect ","cpu_address %h",m_addr," cpu_read_data %h",cpu_read_data," reference_memory %h",reference_memory[m_addr[3:0]]);
                test_failed++;
            end 
        end
    endtask

    initial begin
        init_sequence;
        reset_circuit;
        @(posedge clk);

        fork
            read_channel_driver;
            write_channel_driver;
            monitor;
        join_none

        $display("Testing Write And Read");
        // Testing Write And Read
        number_of_tests = 1000;
        for (int j=0; j<number_of_tests ;j++) begin
            input_address = $random;
            input_data    = $random;
            drive_inputs(1, 1, input_address, input_data);   // Write Operation
            @(posedge clk);
            drive_inputs(1, 0, input_address, 0);            // Read Operation
            @(posedge clk);
        end
        $display("No. of tests: %0d  Test Passed: %0d  Test Failed: %0d", number_of_tests, test_passed, test_failed);

        $display("Testing Flush");
        // Flushing
        drive_inputs(1, 2, 0, 0);
        @(posedge clk);
        
        // Again Flushong To Check All Dirty Bits Are 0
        drive_inputs(1, 2, 0, 0);
        @(posedge clk);
        $display("Testing Done");
        $finish;
    end
endmodule

