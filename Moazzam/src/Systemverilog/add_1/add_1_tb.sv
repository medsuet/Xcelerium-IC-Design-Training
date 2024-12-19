module add_1_tb();

logic clk;
logic reset;
logic in;
logic out;
logic [3:0] input_n;
logic [3:0] output_n;
logic [3:0] compare_num;

add_1 UUT 
(
    .clk(clk),
    .reset(reset),
    .in(in),
    .out(out) 
);

initial
begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial
begin
    reset <= 1;
    //input_n = 0;
    @(posedge clk);
    //for_1_4bits_n(input_n);
//
    //input_n = 13;
    //for_1_4bits_n(input_n);
//
    //input_n = 15;
    //for_1_4bits_n(input_n);
    for(int i=0; i<16; i++)
    begin
        input_n = i;
        for_1_4bits_n(input_n);

        compare_num = input_n + 1;

        if( output_n == (compare_num))    $display("Addition OK");
        else                        $display("Addition error");
    end

    $stop;
end

task for_1_4bits_n(input [3:0] input_n);
begin
    reset <= 0;
    in <= input_n[0];
    @(posedge clk);
    output_n[0] = out;
    in <= input_n[1];
    
    @(posedge clk);
    output_n[1] = out;
    in <= input_n[2];
    
    @(posedge clk);
    output_n[2] = out;
    in <= input_n[3];
    
    @(posedge clk);
    output_n[3] = out;
    reset <= 1;
    repeat(2)@(posedge clk);
end
endtask

endmodule