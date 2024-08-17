/*
    Name: cache_parameters.sv
    Author: Muhammad Tayyab
    Date: 12-8-2024
    Description: 
*/

package cache_parameters;
    // Control parameters
    parameter DATA_BUSWIDTH = 32;
    parameter ADDRESS_BUSWIDTH = 32;

    parameter OFFSET_WIDTH = 0;
    parameter INDEX_WIDTH = 12;
    parameter TAG_WIDTH = 20;

    // Other paramters
    parameter LINE_SIZE = 2**OFFSET_WIDTH;
    parameter NUM_LINES = 2**INDEX_WIDTH;
    parameter CACHE_SIZE = LINE_SIZE * NUM_LINES;

    // Enums
    typedef enum logic[3:0] 
    {
        IDLE, WAIT, PROCESS_REQUEST, HANDSHAKE_MEM_READ, MEM_READ, HANDSHAKE_WRITE_BACK, ADDRESS_HANDSHAKE_WRITE_BACK, DATA_HANDSHAKE_WRITE_BACK, WRITE_BACK, FLUSH
    } type_cache_states_e;

    enum logic
    {
        PROCESSOR_WRITE, MEMORY_WRITE
    } WRSEL_e;

    enum logic[1:0] 
    {
        OPNONE, OPREAD, OPWRITE, OPFLUSH
    } PROCESSOR_OPERATIONS_e;

    // Structs
    typedef struct packed {
        logic [(TAG_WIDTH-1):0] tag;
        logic [(INDEX_WIDTH-1):0] index;
        //logic [(OFFSET_WIDTH-1):0] offset;
    } type_address_ps;

    typedef struct {
        logic tag_match;
        logic is_valid;
        logic is_dirty;
        logic cache_flush_done;
    } type_cache_datapath2controller_s;

    typedef struct {
        logic wr_sel;
        logic wr_en;
        logic set_valid;
        logic set_dirty;
        logic cache_index_counter_wr;
        logic cache_index_counter_clear;
        logic cache_flush;
    } type_cache_controller2datapath_s;

    typedef struct {
        logic [1:0] operation;
        type_address_ps address;
        logic [(DATA_BUSWIDTH-1):0] w_data;
        logic valid;
        logic ready;
    } type_processor2cache_s;

    typedef struct {
        logic valid;
        logic ready;
        logic [(DATA_BUSWIDTH-1):0] r_data;
    } type_cache2processor_s;

endpackage
