module counter_tb;

logic CLK;
logic RESET;
logic [3:0] COUNT;

counter DUT(
    .CLK(CLK),
    .RESET(RESET),
    .COUNT(COUNT)
);


// Clock generation
initial 
begin
    CLK = 0;
    forever #20 CLK = ~CLK;
end

// Initial block for testbench logic
initial 
begin
    RESET <= 1;
    @(posedge CLK); 
    RESET <= #1 0;
    @(posedge CLK);
    RESET <= #1 1;
    repeat(30) begin
        @(posedge CLK);
    end
    $stop;
    $finish;
end

endmodule
