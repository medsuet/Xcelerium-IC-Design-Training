
`ifndef SB_DEFS
`define SB_DEFS

parameter SB_NO_OF_LINES = 8;

typedef enum logic [1:0] {
    SB_CACHE_IDLE,
    SB_CACHE_READ,
    SB_CACHE_WRITE,
    SB_CACHE_FLUSH
} type_sb_cachehandler_states_e;

`endif