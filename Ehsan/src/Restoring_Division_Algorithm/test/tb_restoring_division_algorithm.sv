module tb;

    logic clk, rst, src_valid, src_ready, dest_valid, dest_ready;
    logic [15:0] divisor, dividend;
    logic [15:0] remainder, quotient, exp_remainder, exp_quotient;

    restoring_division_top uut (
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready),
        .divisor(divisor),
        .dividend(dividend),
        .remainder(remainder),
        .quotient(quotient)
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

    //driving inputs
    task drive_inputs(input logic signed [15:0] input_1, input logic signed [15:0] input_2);
        begin
        dividend = input_1;
        divisor = input_2;
        src_valid = 1;
        @(posedge clk);
        src_valid = 0;
        while (dest_valid == 0) begin
            @(posedge clk);
        end 
        dest_ready = 1;
        @(posedge clk);
        dest_ready = 0;
        @(posedge clk);
        end

    endtask 

    //monitoring outputs
    task monitor_outputs;
        begin
            @(posedge dest_ready);
            exp_remainder = int'(dividend % divisor);
            exp_quotient = int'(dividend / divisor);

            if(exp_remainder != remainder && exp_quotient != quotient)begin
                $display("Fail");
            end
            else if (exp_remainder == remainder && exp_quotient == quotient)begin
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

        //directed tests
        fork
            drive_inputs(65234 ,32770);
            monitor_outputs();    
        join

        //random testing
        for (int i=1; i<100;i++ ) begin
            fork
                drive_inputs($random ,$random);
                monitor_outputs();    
            join
        end

        $finish;
    end
endmodule

