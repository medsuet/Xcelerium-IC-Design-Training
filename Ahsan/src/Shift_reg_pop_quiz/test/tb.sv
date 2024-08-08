module tb;
     logic clk;
     logic rst;
     logic D;
     logic A;


// clock generation
initial 
begin
    clk = 1;
    forever #5 clk = ~clk; 
end

shift_reg sr(.clk(clk),.rst(rst),.D(D),.A(A));

initial 
begin
// initialize signals
    rst =  0;D = 1;
    @(posedge clk);
    rst = #1 1;D = #1 1;
    @(posedge clk);
    D=#1 0;
    repeat(2)@(posedge clk);
    D=#1 1;
    repeat(2)@(posedge clk);
    D=#1 0;
    repeat(6)@(posedge clk);

// Finish simulation
    $finish;
end
initial 
begin
        $dumpfile("SR.vcd");
        $dumpvars(0);
end


   

endmodule