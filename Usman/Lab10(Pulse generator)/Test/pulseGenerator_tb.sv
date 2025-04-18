module pulseGenerator_tb;
  
    logic clk;
    logic reset;
    logic in;
    logic  out;

    // Instantiate the Mealy Machine
    pulseGenerator uut (
        .clk(clk),
        .reset(reset),
        .in(in),
        .out(out)
    );

    // Clock generation
  initial begin
    clk =1;
    forever #10 clk = ~clk;
  end
    initial begin
   
        reset = 1;
        #5;
        reset = 0;
        

 
        in = 0; 
        @(posedge clk); in = 0; 
        @(posedge clk); in = 0; 
        @(posedge clk); in = 1; 
        @(posedge clk); in = 1; 
        @(posedge clk); in = 0; 
        @(posedge clk); in = 1; 
        @(posedge clk); in = 1; 
        @(posedge clk); in = 1; 
        @(posedge clk); in = 0; 
        @(posedge clk); in = 1; 
        @(posedge clk); in = 1;
        @(posedge clk); in = 0; 
        @(posedge clk); 
         $stop();
          end

    always@(posedge clk) begin
        
        $display("in = %b, out = %b",in,out);
    end
endmodule

