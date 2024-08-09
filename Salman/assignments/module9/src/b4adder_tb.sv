module b4adder_tb();
    logic CLK;
    logic RESET;
    logic bit_in;
    logic bit_out;

    logic [3:0] input_num;
    logic [3:0] compare_num;
    logic [3:0] output_num;
    int i;
    
    
    b4adder_controller DUT(
        .CLK(CLK),
        .RESET(RESET),
        .bit_in(bit_in),
        .bit_out(bit_out)
    );
    
    // Clock Generator
    initial begin
        CLK = 1;
        forever #10 CLK = ~CLK;
    end


    initial 
    begin
        for (i=0; i<16; i++)
        begin
            input_num = i;
            send_and_check_bits(input_num);
            @(posedge CLK);

            compare_num = input_num + 1;
            
            if (compare_num == output_num)
            begin
                $display("Output Matched; input_num=%d; output_num=%d",input_num,output_num);
            end
        end
    end

    task send_and_check_bits(input [3:0] input_num);
        begin
            RESET <= #1 0;
            @(posedge CLK);
            RESET <= #1 1;
            bit_in <= #1 input_num[0];
            @(posedge CLK);
            output_num[0] = bit_out; 
            bit_in <= #1 input_num[1];
            @(posedge CLK);
            output_num[1] = bit_out; 
            bit_in <= #1 input_num[2];
            @(posedge CLK);
            output_num[2] = bit_out; 
            bit_in <= #1 input_num[3];
            @(posedge CLK);
            output_num[3] = bit_out;
        end
    endtask
endmodule
