module cache 
#(
    parameter BITS              = 32,
    parameter BITS_ADDR         = 32,
    parameter CACHE_SIZE        = 4096,                          //SIZE in bytes
    parameter CACHE_BLOCK_SIZE  = 16,                            //Size in bytes
    parameter CACHE_B_S_BITS    = CACHE_BLOCK_SIZE*8,                            //Size in bits
    parameter CACHE_LINES       = CACHE_SIZE/CACHE_BLOCK_SIZE,
    parameter CACHE_INDEX_BITS  = $clog2(CACHE_LINES),
    parameter CACHE_OFFSET_BITS = ($clog2(CACHE_BLOCK_SIZE)), 
    parameter CACHE_TAG_BITS    = BITS_ADDR-(CACHE_INDEX_BITS + CACHE_OFFSET_BITS)
) 
(
    input logic clk, 
    input logic rst,
    input logic c_wr,
    input logic c_rd,
    input logic c_flash,
    input logic [BITS_ADDR-1:0] c_addr_in,
    input logic [BITS-1:0] c_data_in,

    output logic r_valid,
    output logic w_valid,
    input logic r_resp,
    input logic b_resp,
    input logic [CACHE_B_S_BITS-1 : 0] r_data_mm,

    output logic cache_hit,
    output logic cache_miss,
    output logic flash_done,
    output logic c_ready,
    output logic [BITS-1:0] c_data_out,

    output logic [CACHE_B_S_BITS-1:0] w_data_mm,
    output logic [BITS_ADDR-1:0] ra_addr_mm,
    output logic [BITS_ADDR-1:0] wa_addr_mm
);

//defined space for cache with valid, dirty, and tag
logic [CACHE_LINES-1   : 0] valid                     = '0;                      // 1  x 256
logic [CACHE_LINES-1   : 0] dirty                     = '0;                      // 1  x 256
logic [CACHE_TAG_BITS-1: 0] tag        [CACHE_LINES-1   : 0]='{default : '0};   // 20 x 256
logic [CACHE_B_S_BITS-1: 0] data_cache [CACHE_LINES-1   : 0]='{default : '0};   // 128 x256

logic [CACHE_INDEX_BITS-1: 0] index_addr;
logic [CACHE_TAG_BITS-1  : 0] tag_value;
logic [CACHE_TAG_BITS-1  : 0] tag_addr_v;
logic [CACHE_INDEX_BITS-1: 0] index_value_flash;
logic [BITS_ADDR-1: 0] addr_flash;

logic valid_bit;
logic dirty_bit;
logic c_hit;
logic flash_dirty_bit ;
logic flash_start ;
logic flash_stop = '0;


int i = '0;

cache_controller CON
(
    clk, 
    rst ,
    c_hit ,
    c_rd ,
    c_wr ,
    c_flash ,
    flash_dirty_bit ,
    flash_done ,
    dirty_bit ,
    r_resp ,
    b_resp ,

    cache_hit ,
    cache_miss ,
    c_rd_en ,
    c_wr_en ,
    alo_wr_en,
    r_valid ,
    w_valid ,
    flash_start ,
    flash_stop ,
    c_ready 
);


//check the value to tag, valid, dirty at initial
always_comb 
begin
    // put the value of index and tag on which we want to check data
    index_addr = c_addr_in[(CACHE_INDEX_BITS+CACHE_OFFSET_BITS)-1 : CACHE_OFFSET_BITS];
    tag_addr_v = c_addr_in[BITS-1: (CACHE_INDEX_BITS+CACHE_OFFSET_BITS)];

    valid_bit = valid[index_addr];
    dirty_bit = dirty[index_addr];
    tag_value = tag  [index_addr];

    c_hit = valid_bit & (tag_value == tag_addr_v);

end

always_comb
begin
    // Simple case--> cache hits and send the data to Processor 
    // if CPU_request in read 
    if(c_rd_en)  
    begin
        case (c_addr_in[CACHE_OFFSET_BITS-1:CACHE_OFFSET_BITS-2]) 
            2'd0: c_data_out = data_cache[index_addr][31:0]  ;
            2'd1: c_data_out = data_cache[index_addr][63:32] ;
            2'd2: c_data_out = data_cache[index_addr][95:64] ;
            2'd3: c_data_out = data_cache[index_addr][127:96];
        endcase   
    end
    else
    begin
        c_data_out = '0;
    end

    //it is read from cache if dirty bit is 1 during c_flash
    // write from cache to MM
    if(b_resp & ( (flash_start | c_flash) & !flash_stop) )
    begin
        wa_addr_mm =  addr_flash;
        w_data_mm =  data_cache[index_value_flash];
        dirty[index_value_flash] = '0;
    end
    
    //it is read from cache 
    // write to MM
    else if(b_resp)
    begin
        wa_addr_mm =  c_addr_in;
        w_data_mm  =  data_cache[index_addr];
        dirty[index_addr] = '0;
    end

    else
    begin
        wa_addr_mm = '0;
        w_data_mm  = '0;
    end

    ra_addr_mm = c_addr_in;
    
end

always_ff @(posedge clk or negedge rst) 
begin
    if(!rst | flash_done)
    begin
        i <= 0;
        cache_hit  <= '0;
        cache_miss <= '0;
        valid <= '0;
        dirty <= '0;
        tag   <= '{default : '0}; 
        data_cache <= '{default : '0}; 
    end

    //Case when Cache_hit and Dirty is 0,
    //write processer data into cache 
    else if(c_wr_en)
    begin
        valid[index_addr] <= 1'b1;
        tag  [index_addr] <= c_addr_in[BITS-1: (CACHE_INDEX_BITS+CACHE_OFFSET_BITS)];
        dirty[index_addr] <= 1'b1;  
        case (c_addr_in[3:2])
            2'd0: data_cache[index_addr][31:0]  <= c_data_in;
            2'd1: data_cache[index_addr][63:32] <= c_data_in;
            2'd2: data_cache[index_addr][95:64] <= c_data_in;
            2'd3: data_cache[index_addr][127:96]<= c_data_in;
        endcase   
    end

    // Load in cache from Mem 
    else if(alo_wr_en) 
    begin
        valid[index_addr] <= 1'b1;
        tag  [index_addr] <= c_addr_in[BITS-1: (CACHE_INDEX_BITS+CACHE_OFFSET_BITS)];
        dirty[index_addr] <= 1'b0;
        data_cache[index_addr] <= r_data_mm;
    end

    if(flash_start & !flash_stop )
    begin 
        i <= i+1;
        flash_dirty_bit <= dirty[i];
        index_value_flash <= i;
        addr_flash <= {tag[i], i, {CACHE_OFFSET_BITS{1'b0}} };
        $display("is it start run. flash_dirty_bit=%0d, index_value_flash=%d, addr_flash=%h time=%0t",flash_dirty_bit, index_value_flash,addr_flash, $time);
    end
    else if (c_flash & !flash_stop) 
    begin
        i <= 0;
        flash_dirty_bit <= dirty[i];
        index_value_flash <= i;
        addr_flash <= {tag[i], i, {CACHE_OFFSET_BITS{1'b0}} };
    end

    if(i == (CACHE_LINES)) begin flash_done <= 1'b1; i <= '0; end
    else                     begin flash_done <= '0; end

end
    
endmodule