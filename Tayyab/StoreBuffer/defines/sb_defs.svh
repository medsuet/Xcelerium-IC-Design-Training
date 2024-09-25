
`ifndef SB_DEFS
`define SB_DEFS

`define XLEN 32
parameter DCACHE_ADDR_WIDTH  = `XLEN;
parameter DCACHE_DATA_WIDTH  = `XLEN;
parameter DCACHE_LINE_WIDTH  = 128;            // Line width is in bits

// Bus interface from LSU to dcache  
typedef struct packed {                            
    logic [DCACHE_ADDR_WIDTH-1:0]    addr;
    logic [DCACHE_DATA_WIDTH-1:0]    w_data;
    logic [3:0]                      sel_byte;  
    logic                            w_en;  
    logic                            req; 
} type_lsummu2dcache_s;

// Bus interface from dcache to LSU
typedef struct packed {                            
    logic [DCACHE_DATA_WIDTH-1:0]    r_data;
    logic                            ack;   
} type_dcache2lsummu_s;

parameter SB_NO_OF_LINES = 8;

typedef enum logic [1:0] {
    SB_CACHE_IDLE,
    SB_CACHE_READ,
    SB_CACHE_WRITE,
    SB_CACHE_FLUSH
} type_sb_cachehandler_states_e;

`endif