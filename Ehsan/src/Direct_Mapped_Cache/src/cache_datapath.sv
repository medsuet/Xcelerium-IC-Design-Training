parameter ADDRESS = 32;
parameter CPU_READ_DATA = 32;
parameter CPU_WRITE_DATA = 32;
parameter R_DATA = 32;
parameter W_DATA = 32;
parameter CACHE_LINE_SIZE = 32;

parameter CACHE_LINES = 8;
parameter CACHE_TAG_BITS = 27;
parameter CACHE_INDEX_BITS = 3;
parameter CACHE_BLOCK_OFFSET = 2;

module cache_datapath (
    
    input    logic   clk_i,
    input    logic   rst_i,

    // Interface Between CPU And Cache Memory
    input    logic   [ADDRESS-1:0]         cpu_address_i,
    input    logic   [CPU_WRITE_DATA-1:0]  cpu_write_data_i,
    output   logic   [CPU_READ_DATA-1:0]   cpu_read_data_o,    
    
    // Interface Between Cache Memory And Main Memory
    input    logic   [R_DATA-1:0]          r_data_i,
    output   logic   [ADDRESS-1:0]         ar_address_o,
    output   logic   [ADDRESS-1:0]         aw_address_o,
    output   logic   [W_DATA-1:0]          w_data_o, 
    
    // Interface Between Datapath And Controller
    input    logic   cpu_write_en_i,          //CPU Write To Cache
    input    logic   write_from_main_mem_i,   //For Writing Data Comming From Main Mem
    input    logic   change_dirty_bit_i,      //For Changing Dirtybit
    input    logic   flush_en_i,              //For Flushing
    input    logic   flush_counter_en_i,      //For Flushing
    output   logic   cache_hit_o,             //Cache Hit  (To Controller)
    output   logic   dirty_bit_o,             //Dirty Bit  (To Controller)
    output   logic   flush_done_o             //Flushing Complete Signal
);

typedef struct packed {
  logic [CPU_READ_DATA-1:0]  data;
  logic [CACHE_TAG_BITS-1:0] tag;
  logic                      valid_bit;
  logic                      dirty_bit;
} cache_line;

cache_line cache [CACHE_LINES-1:0];             // cache lines

logic [CACHE_LINES-1:0]         flush_counter;  // flush_counter for flushing (start from 0)
logic [CACHE_LINES-1:0]         counter;        // flush_counter for flushing (start from 1)
logic [CACHE_LINES-1:0]         adder;          // adder for flushing

logic [CACHE_TAG_BITS-1:0]      tag;            // tag bits
logic [CACHE_INDEX_BITS-1:0]    index;          // index bits
logic [CACHE_BLOCK_OFFSET-1:0]  block_offset;   // block offset

//============================== Cache Decoder ===============================//

assign  tag          = cpu_address_i[CACHE_TAG_BITS-1:CACHE_INDEX_BITS];
assign  index        = cpu_address_i[CACHE_INDEX_BITS-1:CACHE_BLOCK_OFFSET];
assign  block_offset = cpu_address_i[CACHE_BLOCK_OFFSET-1:0];

//=========================== Checking Hit Or Miss ===========================//

always_comb begin
    if (cache[index].tag == tag && cache[index].valid_bit == 1) begin    
        cache_hit_o  = 1;
    end
    else begin
        cache_hit_o  = 0;
    end
end

//================== Dirty Bit From Datapath To Controller ===================//

assign dirty_bit_o = (flush_en_i == 1) ? cache[flush_counter].dirty_bit : cache[index].dirty_bit;

//============================ Asynchronous Read =============================//
 
assign cpu_read_data_o = cache[index].data;
assign ar_address_o    = cpu_address_i; 
assign aw_address_o    = {cache[index].tag, index, block_offset};
assign w_data_o        = (flush_en_i == 1) ? cache[flush_counter].data : cache[index].data; 

//============================ Synchronous Write =============================//

always_ff @(posedge clk_i or negedge rst_i) begin
    if (!rst_i) begin
        for (int i = 0; i < CACHE_LINES; i++) begin
            cache[i].valid_bit <= 0;
            cache[i].dirty_bit <= 0;
            cache[i].tag       <= 1;
            cache[i].data      <= 1;
        end
    end

    // Writing Data From CPU To Cache
    else if (cpu_write_en_i == 1) begin
        cache[index].valid_bit <= 1;
        cache[index].dirty_bit <= 1;
        cache[index].data      <= cpu_write_data_i;  
    end 

    // Writing Data From Main Mem To Cache
    else if (write_from_main_mem_i == 1) begin                         
        cache[index].valid_bit <= 1;
        cache[index].dirty_bit <= 0;
        cache[index].data      <= r_data_i;
        cache[index].tag       <= tag; 
    end

end

//================================ Flushing ==================================//

always_ff @( posedge clk_i or negedge rst_i ) begin
    if (!rst_i) begin
        flush_counter <= 0;              
        counter <= 0;  
    end
    else if (flush_en_i) begin
        if (cache[flush_counter].dirty_bit == 0) begin
            cache[flush_counter].valid_bit <= 0;
        end
        else if (cache[flush_counter].dirty_bit == 1) begin
            cache[flush_counter].valid_bit <= cache[flush_counter].valid_bit;
        end

        if (change_dirty_bit_i) begin
            cache[flush_counter].dirty_bit = 0;
        end
        else if (!change_dirty_bit_i) begin
            cache[flush_counter].dirty_bit <= cache[flush_counter].dirty_bit; 
        end

        if (flush_counter_en_i) begin
            flush_counter <= counter;         //starts from 0
            counter <= adder;                 //starts from 1
        end
        else if (!flush_counter_en_i) begin
            flush_counter <= flush_counter;
            counter <= counter;
        end
    end 
    else if (!flush_en_i) begin
        flush_counter <= 0;
        counter <= 0;
    end
end

//========================== Adder For Flushing ==============================//

assign adder = counter + 1;

//======================= Comparator For Flushing ============================//

assign flush_done_o = (flush_counter == 4) ? 1 : 0;

endmodule