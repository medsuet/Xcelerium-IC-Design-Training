`include "defs.svh"

module cache_tb;
logic clk;
logic rst;
logic flush;
logic [31:0] wr_data;
logic [31:0] r_data;
logic [6:0] opcode;
logic [31:0] addr;
logic ready;
logic valid;



top_cache dut(
    .clk(clk),
    .rst(rst),
    .flush(flush),
    .wr_data(wr_data),
    .r_data(r_data),
    .opcode(opcode),
    .addr(addr),
    .valid(valid),
    .ready(ready)
);



 task reset();
    rst=0;
    #100;
    rst=1;

 endtask


task monitor_cache_tb();
    /* NOTE: This monitor can be enhanced
             by checks on the addresses, data etc
    */

    //wait for the valid signal to be asserted
    @(posedge valid);

    //Delay for setting of states depending on opcode
    @(posedge clk);
    if (opcode==`OPCODE_L)
        $display("Valid Asserted with Read Request");
    if (opcode==`OPCODE_S)
        $display("Valid Asserted with Write Request");

    $display("    CPU Request: %b", dut.cpu_request);

    //To Ensure the validity of the read and write
    $display("    Read Request: %b | Write Request: %b", dut.rd_req, dut.wr_req);

    /*  
        a delay of single clock cycle as
        Hit is computed after a clock cycle
    */

    @(posedge clk);

    if(dut.cache_hit) begin
        $display("    Cache Hit");
    end else begin
        $display("    Cache Miss, Dirty Bit= %d ",dut.dirty_ff);
    end

    //check ready signals at every clock edge
    while (!ready) begin
        @(posedge clk);
    end

    $display("    Ready= %d", ready);
endtask


task direct_test_case(input logic [6:0] opcode_in,
                       input logic [31:0] addr_in,
                       input logic [31:0] wr_data_in);
        begin
            @(posedge clk);

            valid=1;
            opcode=opcode_in;
            if (opcode==`OPCODE_S) begin
                wr_data=wr_data_in;
            end
            addr=addr_in;
            flush=0;
            @(posedge clk);
            valid=0;
            while (!ready) begin
                @(posedge clk);
            end

            @(posedge clk);
        end
                       
endtask 

// Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    initial begin
        $dumpfile("control.vcd");
        $dumpvars(0,dut);

        fork
            forever monitor_cache_tb();
            begin    
            
                valid=0;
                opcode=0;
                flush=0;
                addr=0;
                wr_data=0;
                //=============Reset=============

                reset();
                /*
                rst=0;
                #100;
                rst=1;
        */

                
                //=============Read Cache hit=============
                direct_test_case(`OPCODE_L,32'h00000004,0);

                
                //=============Write Cache hit ==============
                direct_test_case(`OPCODE_S,32'h00000004,32'ha5321a4f);

                //=============Read Cache miss =============

                direct_test_case(`OPCODE_L,32'h00001014,0);


                //=============Write Cache miss=============
                direct_test_case(`OPCODE_S,32'h00001020,32'ha5321a4f);

                //=============Read Cache Miss with dirty=1=============

                direct_test_case(`OPCODE_L,32'h00000020,0);
                //=============Write Cache Miss with dirty=1=============

                direct_test_case(`OPCODE_S,32'h00001000,32'h6a6a6a6a);

                //=============Flushing=============

                @(posedge clk);
                opcode=0;
                flush=1;
                while (!ready) begin
                    @(posedge clk);
                end


                $finish;
            end 
        join
    end


endmodule
