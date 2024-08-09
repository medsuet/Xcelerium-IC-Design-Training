module tb_rest_div;
    // Parameter definition with default value
    parameter WIDTH = 16; 
    parameter MAXNUM = 56535; 
    parameter CYCLE = 10; 

    // Inputs
    logic [WIDTH-1:0] dividend;
    logic [WIDTH-1:0] divisor; 
    logic clk;                 
    logic reset;               
    logic src_valid;           
    logic dest_ready;          

    // Outputs
    logic [WIDTH-1:0] quotient; 
    logic [WIDTH-1:0] remainder;
    logic src_ready, dest_valid;

    // Expected outputs for verification
    logic [WIDTH-1:0] expected_quotient;
    logic [WIDTH-1:0] expected_remainder;

    // Instantiate the Unit Under Test (UUT)
    Rest_div #(.WIDTH(WIDTH)) uut (
        .dividend(dividend),
        .divisor(divisor),
        .clk(clk),
        .reset(reset),
        .src_valid(src_valid),
        .dest_ready(dest_ready),
        .dest_valid(dest_valid),
        .src_ready(src_ready),
        .quotient(quotient),
        .remainder(remainder)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #(CYCLE / 2) clk = ~clk; 
    end

    // Dump file for waveform
    initial begin
        $dumpfile("Rest_div.vcd");
        $dumpvars(0,tb_rest_div);
    end

    // Task for reset sequence
    task reset_sequence;
        begin
            @(posedge clk);
            reset = 0;           // Assert reset signal
            repeat(20) @(posedge clk); 
            reset = 1;           // Deassert reset signal
        end
    endtask

    // Task to initialize the signals
    task init_sequence;
        begin
            dividend = 0;        
            divisor = 0;  
            src_valid = 0; 
            dest_ready = 0; 
            reset = 1;      
        end
    endtask

    // Task for driving inputs
    task drive_inputs(input logic [WIDTH-1:0] input1, input logic [WIDTH-1:0] input2);
        begin
            dividend = input1;
            divisor = input2; 
            src_valid = 1;    

            @(posedge clk);
            while (!src_ready) @(posedge clk);  // Wait for src_ready signal
            src_valid = 0;          

            while (!dest_valid) @(posedge clk);  // Wait for dest_valid signal
            dest_ready = 1;        
            
            @(posedge clk);
            dest_ready = 0;        
        end
    endtask

    // Task for monitoring outputs
    task monitor_outputs;
        begin
            @(posedge dest_ready) expected_quotient = dividend / divisor; 
            expected_remainder = dividend % divisor;
            @(posedge clk);
            if ((expected_quotient == quotient) && (expected_remainder == remainder)) 
            begin
                $display("Pass: dividend = %0d, divisor = %0d, Q = %0d, Expected_Q = %0d, R = %0d, Expected_R = %0d", dividend, divisor, quotient, expected_quotient, remainder, expected_remainder);
            end 
            else 
            begin
                $display("Fail: dividend = %0d, divisor = %0d, Q = %0d, Expected_Q = %0d, R = %0d, Expected_R = %0d", dividend, divisor, quotient, expected_quotient, remainder, expected_remainder);
            end
        end
    endtask

    // Task to pass inputs and monitor outputs
    task pass_inputs(input logic [WIDTH-1:0] input1, input logic [WIDTH-1:0] input2);
        begin
            fork
                drive_inputs(input1, input2);  // Drive inputs and perform handshake
                monitor_outputs();       // Monitor the outputs
            join
            
        end
    endtask

    // Stimulus process
    initial begin
        // Initialize signals
        init_sequence();
        // Apply reset  
        reset_sequence(); 
        fork
            begin
                // Directed tests
                pass_inputs(0, 1000);   
                pass_inputs(MAXNUM, 1); 
                pass_inputs(32767, 1);  
                pass_inputs(1, MAXNUM);  

                // Random Testing with delays
                for (int i = 0; i < 500; i++) begin
                    dividend = $random  % MAXNUM; 
                    divisor = $random % MAXNUM;   
                    if (divisor == '0) begin
                        divisor += 1;   
                    end
                    pass_inputs(dividend, divisor); 
                end
            end
        join
        $finish;  // End simulation
    end
endmodule
