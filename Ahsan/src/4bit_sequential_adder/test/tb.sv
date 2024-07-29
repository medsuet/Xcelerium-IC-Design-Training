
module tb_Sequential4BitAdder;
    reg clk;
    reg reset;
    reg in;
    wire out;

    Sequential4BitAdder uut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );

    // Clock generation
    initial 
    begin
        clk = 1;
        forever #5 clk = ~clk; 
    end

    initial 
    begin
        $dumpfile("tb.vcd");
        $dumpvars(0);
    end

    // Task to apply test vectors
    task apply_test_vector;
        input [3:0] test_vector; // 4-bit input vector
        integer i;
        for (i = 0; i < 4; i = i + 1) begin
                in = test_vector[i];
                @(posedge clk);
        end
        
    endtask

    initial begin
        reset = 1;
        in = 0;
        @(posedge clk);
        reset = 0;

        // Apply test vector: adding 1 to 4-bit numbers
        apply_test_vector(4'b0000);
        apply_test_vector(4'b1000);
        apply_test_vector(4'b0100);
        apply_test_vector(4'b1100);
        apply_test_vector(4'b0010);
        apply_test_vector(4'b1010);
        apply_test_vector(4'b0110);
        apply_test_vector(4'b1110);
        apply_test_vector(4'b0001);
        apply_test_vector(4'b1001);
        apply_test_vector(4'b0101);
        apply_test_vector(4'b1101);
        apply_test_vector(4'b0011);        
        $finish;
    end     
endmodule
