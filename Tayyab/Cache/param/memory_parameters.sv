/*
    Name: memory_parameters.sv
    Author: Muhammad Tayyab
    Date: 12-8-2024
    Description: 
*/

package memory_parameters;
    // Control parameters
    parameter MEMORY_SIZE = 256;
    parameter DATA_BUSWIDTH = 32;
    parameter ADDRESS_BUSWIDTH = 32;

    // Define states
    typedef enum logic [2:0] { SIDLE, SREAD, SWRITE } type_memory_states_e;

    typedef struct {
        logic wr_en;
    } type_mem_controller2datapath_s;

    typedef struct {
        logic wdata_done;
        logic rdata_done;
    } type_mem_datapath2controller_s;

endpackage
