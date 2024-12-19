module cache_tb;

parameter BITS              = 32;
parameter BITS_ADDR         = 32;
parameter CACHE_SIZE        = 4096;                          //SIZE in bytes
parameter CACHE_BLOCK_SIZE  = 16;                            //Size in bytes
parameter CACHE_B_S_BITS    = CACHE_BLOCK_SIZE*8;                            //Size in bits
parameter CACHE_LINES       = CACHE_SIZE/CACHE_BLOCK_SIZE;

logic clk;
logic rst;
logic c_wr;
logic c_rd;
logic c_flash;
logic [BITS_ADDR-1:0] c_addr_in;
logic [BITS-1:0] c_data_in;
logic r_valid;
logic w_valid;
logic r_resp;
logic b_resp;
logic [CACHE_B_S_BITS-1 : 0] r_data_mm;

logic cache_hit;
logic cache_miss;
logic flash_done;
logic c_ready;
logic [BITS-1:0] c_data_out;
logic [CACHE_B_S_BITS-1:0] w_data_mm;
logic [BITS_ADDR-1:0] ra_addr_mm;
logic [BITS_ADDR-1:0] wa_addr_mm;

logic [CACHE_B_S_BITS-1:0] mm [15:0]; //keep it small
logic [CACHE_B_S_BITS-1:0] mm_data; 
logic alo;
logic [BITS_ADDR-1:0] addr;
logic [BITS:0] data_in;
int j;

cache DUT
(
    clk, 
    rst,
    c_wr,
    c_rd,
    c_flash,
    c_addr_in,
    c_data_in,

    r_valid,
    w_valid,
    r_resp,
    b_resp,
    r_data_mm,

    cache_hit,
    cache_miss,
    flash_done,
    c_ready,
    c_data_out,

    w_data_mm,
    ra_addr_mm,
    wa_addr_mm
);

initial 
begin
    $readmemh("output.txt",mm);
end

initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial
begin
    rst_seq();
    cache_allocate();
end


initial
begin
    @(posedge rst);
    /*
    alo <= 1;
    @(posedge clk);
    addr = 8'b0001_10_00;
    read_cache(addr);
    alo <= 0;
    $display("the value of alo is %0d", alo);
    @(posedge clk);
    alo <= 1;
    $display("the value of alo is %0d", alo);
    @(posedge clk);
    addr = 8'b0001_10_10;
    read_cache(addr);
    alo <= 0;

    @(posedge clk);
    addr =  8'b0001_10_11;
    data_in = 32'h1234_1234;
    write_cache(addr,data_in);
    @(posedge clk);

    alo <= 1;
    @(posedge clk);
    addr = 8'b01111011;
    data_in = 32'habcd_fabc;
    write_cache(addr,data_in);
    alo <= 0;
    @(posedge clk);

    @(posedge clk);
    addr =  8'b0011_00_11;
    data_in = 32'h1234_1234;
    write_cache(addr,data_in);
    @(posedge clk);

    alo <= 1;
    @(posedge clk);
    addr = 8'b0101_00_11;
    data_in = 32'habcd_fabc;
    write_cache(addr,data_in);
    alo <= 0;
    */
    alo <= 0;
    repeat(2)@(posedge clk);
    

    for(j=0 ; j<(CACHE_LINES*4); j=j+4)
    begin
        addr = j;
        data_in = $random;
        mm_data = mm[j%4];
        write_cache(addr,data_in,mm_data);
    end

    repeat(2)@(posedge clk);

    for(j=0 ; j<(CACHE_LINES*4); j=j+4)
    begin
        addr = j;
        data_in = $random;
        mm_data = mm[j%15];
        write_cache(addr,data_in,mm_data);
    end
    repeat(2)@(posedge clk);

    alo <= 1;
    //flash_cache();
    repeat(5)@(posedge clk);

end


task rst_seq();
    rst         = 0;
    c_rd          = 0;
    c_wr          = 0;
    c_flash       = 0;
    r_valid  = 0;
    w_valid   = 0;
    c_addr_in     = 0;
    c_data_in   = 0;
    r_data_mm   = 0;
    repeat(5)@(posedge clk);
    rst <= 1;
    @(posedge clk);
endtask

task cache_allocate();
    @(posedge clk);
    while (1)
    begin
        @(posedge clk);
        //$display("is it run.00000000.,r_valid = %0d, w_valid = %0d,.. %0t",r_valid,w_valid ,$time);
        if(r_valid  )
        begin
            //$display("is it run.11111111111111111... %0t",$time);
            //r_data_mm = mm[1];
            @(posedge clk);
            r_resp <= 1;
        end
        else if(w_valid )
        begin
            //$display("is it run..22222222222... %0t",$time);
            @(posedge clk);
            b_resp <= 1;
        end
        else
        begin
            b_resp <= 0;
            r_resp <= 0;
        end
        if(alo) 
        begin
            $stop;
        end
    end
endtask
/*
task cache_writeback();
    @(posedge clk);
    while (alo)
    begin
        $display("the data for wb is @# time: %0t", $time);
        @(posedge clk);
        if(wb_en | 1'b0)
        begin
            $display("the addr for wb is %0h @ time: %0t",addr_wb_c2mm, $time);
            $display("the data for wb is %0h @ time: %0t",data_wb_c2mm, $time);
            @(posedge clk);
            w_valid <= 1;
            
        end
        else
        $display("the data for wb is @ time: %0t", $time);
            w_valid <= 0;
    end
endtask
*/
//task cache_wb();
//    @(posedge clk);
//    while (alo)
//    begin
//        @(posedge clk);
//        if(wb_en)
//        begin
//            r_data_mm <= 128'hd6d9de20_a4d11968_fc703140_f513b64f;
//            @(posedge clk);
//            w_valid <= 1;
//            
//        end
//        else
//            w_valid <= 0;
//    end
//endtask

//task read_cache(input logic [BITS_ADDR-1:0] addr);
//    c_rd <= 1;
//    c_addr_in <= addr;
//    $display("the value of time in r2 is %0t", $time);
//    @(posedge clk);
//    //$display("the value of time in r2 is %0t", $time);
//    //while(stall) @(posedge clk);
//    //$display("the value of time in r3 is %0t", $time);
//    @(posedge cache_hit);
//    $display("the value of time in hit is %0t", $time);
//    @(posedge clk);
//    $display("the value of time in rd0 is %0t", $time);
//    c_rd <= 0;
//endtask

task write_cache(input logic [BITS_ADDR-1:0] addr,input logic [BITS-1:0]data_in,
                input logic [CACHE_B_S_BITS-1:0] mm_data);
    c_wr <= 1;
    c_addr_in <= addr;
    c_data_in <= data_in;

    @(posedge clk);
    r_data_mm <= mm_data;

    //while(stall) @(posedge clk);
    @(posedge cache_hit);
    @(posedge clk);
    c_wr <= 0;
endtask

//task flash_cache();
//    @(posedge clk);
//    c_flash <= 1;
//    @(posedge clk);
//    c_flash <= 0;
//    @(posedge flash_done);
//endtask

endmodule