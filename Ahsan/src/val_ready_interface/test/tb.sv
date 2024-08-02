
module Seq_Mul_top_tb;

    // Inputs
    logic signed [15:0] Multiplicand;
    logic signed [15:0] Multiplier;
    logic clk;
    logic rst;
    logic src_val;
    logic dest_ready;

    //refernce model output
    logic signed [31:0] exp;

    // Outputs
    logic dest_val;
    logic src_ready;
    logic signed [31:0] Product;

    // Instantiate the Unit Under Test (UUT)
    Seq_Mul_top uut (
        .Multiplicand(Multiplicand),
        .Multiplier(Multiplier),
        .clk(clk),
        .rst(rst),
        .src_ready(src_ready),
        .dest_ready(dest_ready),
        .src_val(src_val),
        .dest_val(dest_val),
        .Product(Product)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; // 10 ns period clock
    end

    // Dump file for waveform
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, Seq_Mul_top_tb);
    end

    // Task for driving inputs
    task drive_inputs(input logic signed [15:0] in1, input logic signed [15:0] in2);
        begin
            Multiplicand = in1;
            Multiplier = in2;
            src_val = 1;
            @(posedge clk);
            src_val = 0;
           while (!dest_val) @(posedge clk);
            @(posedge clk);
            dest_ready = 1;
            @(posedge clk);
            dest_ready = 0;
        end
    endtask

    // Task for monitoring outputs
    task monitor_outputs;
        begin
            @(posedge dest_ready) exp = Multiplicand * Multiplier;
            if(exp != Product)begin
                $display("Fail");
            end
            else
            begin
                $display("pass");
            end
        end
    endtask

    task init_sequence;
        begin
        Multiplicand = 0;
        Multiplier = 0;
        dest_ready =0;
        exp =0;
        rst = 0;
        src_val = 0;
        @(posedge clk);
        rst = 1;  
        end
    endtask


    initial begin
         
        init_sequence();
       fork
        //directed testbench
        drive_inputs(-32767,1); 
        monitor_outputs();
       join

        //Random Testing
        for(int i=0;i<2;i++)begin 
            fork
            drive_inputs($random % 65536,$random % 65536); 
            monitor_outputs();
            join
        end
        $finish;
    end
endmodule