module tb;

    logic clk, rst, src_valid, src_ready, dest_valid, dest_ready;
    logic signed [15:0] multiplicand, multiplier;
    logic signed [31:0] product, exp_product;

    sequential_multiplier uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready),
        .product(product)
    );

    //clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; 
    end

    //generating wavefile
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end


    task drive_inputs(input logic signed [15:0] input_1, input logic signed [15:0] input_2);
        begin
        multiplicand = input_1;
        multiplier = input_2;
        src_valid = 1;
        @(posedge clk);
        src_valid = 0;
        while (dest_valid == 0) begin
            @(posedge clk);
        end 
        @(posedge clk);
        dest_ready = 1;
        @(posedge clk);
        dest_ready = 0;
        end

    endtask 

    task monitor_outputs;
        begin
            exp_product = multiplicand * multiplier;
            if(exp_product != product)begin
                $display("Fail");
            end
            else
            begin
                $display("Pass");
            end
        end
    endtask

    task reset_circuit;
        rst = 0;
        #5;
        rst = 1;
    endtask

    initial begin
        reset_circuit;
        dest_ready = 0;
        fork
            for (int i=0; i<200 ;i++ ) begin
                drive_inputs($random ,$random);
                monitor_outputs();    
            end
        join

        $finish;
    end
endmodule

