/*

###########################== Cache Memory Defines ==###########################

*/
`ifndef CACHE_DEFS
`define CACHE_DEFS
// Cache data address logic
typedef struct packed{
    logic [3:0] offset;
    logic [7:0] index;
    logic [19:0] tag;
    logic valid;
    logic dirty;
} type_cache_address;

// Cache Controller States
typedef enum logic [2:0]{
    IDLE,
    PROCESS_REQUEST,
    CACHE_ALLOCATE,
    WRITEBACK,
    FLUSH
} type_cache_states;

// Cache Controller Inputs
typedef struct packed {
    logic cpu_req;
    logic req_type;
    logic cache_hit;
    logic dirty;
    logic flush;
    logic flush_done;
} type_controller_in;

// Memory to Controller Inputs
typedef struct packed {
    logic s_aready;         // slave address ready
    logic s_rvalid;         // slave data valid
    logic s_wvalid;         // slave write ready
    logic [1:0] s_bvalid;   // slave valid response
} type_mem2controller;


// Cache Controller Outputs
typedef struct packed {
    logic wr_en;
    logic rd_en;
    logic mem_wr;
    logic mem_rd;
    logic cache_clean;
} type_controller_out;

// Cache Controller Outputs
typedef struct packed {
    logic c_avalid;         // address valid
    logic c_rready;         // read ready
    logic c_wvalid;         // write data valid
    logic c_bready;         // ready to recieve mem_ack
} type_controller2cache;

// Cache to Memory
typedef struct packed {
    logic [127:0] data;
    logic [31:0] addr;
} type_cache2mem;

// Memory to Cache
typedef struct packed{
    logic [127:0] data;
} type_mem2cache;

`endif