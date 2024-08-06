module adder_tb();

    reg clk, reset;
    reg data;
    wire out;

    logic [3:0] value;

    // Instantiate the adder module
    adder DUT(
        .clk(clk),
        .reset(reset),
        .data(data),
        .out(out)
    );

    // Clock Generator
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Test Sequence
    initial begin
        // Initialize signals
        initialize_signals();
        // Apply input values from 0 to 15
        repeat (16) begin
            // Apply reset before each input
            reset_sequence();        
            apply_input(value);
            value = value + 1;
        end
        
        // Observe the output
        repeat (20) @(posedge clk);
        $finish;
    end

    task initialize_signals;
        begin
            reset = 1'b1; 
            //data = 1'b0;
            value = 4'b0;
        end
    endtask

    task reset_sequence;
        begin
            
            reset = 1'b0;   // Apply reset
            #1;
            reset = 1'b1;   // Release reset
        
        end
    endtask

    task apply_input(input [3:0] value);
        begin
            data = value[0];
            @(posedge clk);
            data = value[1];
            @(posedge clk);
            data = value[2];
            @(posedge clk);
            data = value[3];
            @(posedge clk);
        end
    endtask

endmodule
