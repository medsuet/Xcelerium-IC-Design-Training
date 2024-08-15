 /*
    Name: axi4lite_parameters.sv
    Author: Muhammad Tayyab
    Date: 13-8-2024
    Description: AXI4Lite bus definations and parameters
*/


package axi4lite_parameters;
    // Define DATA_BUSWIDTH and ADDRESS_BUSWIDTH
    parameter DATA_BUSWIDTH = 32;
    parameter ADDRESS_BUSWIDTH = 32;

    //read_address_channel
    typedef struct {
        logic [(ADDRESS_BUSWIDTH-1):0] araddr;
        logic arcache;
        logic arprot;
        logic arvalid;
    } type_read_address_channel_m2s_s;

    typedef struct {
        logic arready;
    } type_read_address_channel_s2m_s;

    //read_data_channel
    typedef struct {
        logic rready;
    } type_read_data_channel_m2s_s;

    typedef struct {
        logic [(DATA_BUSWIDTH-1):0] rdata;
        logic rresp;
        logic rvalid;
    } type_read_data_channel_s2m_s;

    //write_address_channel
    typedef struct {
        logic [(ADDRESS_BUSWIDTH-1):0] awaddr;
        logic awcache;
        logic awport;
        logic awvalid;
    } type_write_address_channel_m2s_s;

    typedef struct {
        logic awready;
    } type_write_address_channel_s2m_s;

    //write_data_channel
    typedef struct {
        logic [(DATA_BUSWIDTH-1):0] wdata;
        logic wvalid;
        logic [3:0] wstrb;
    } type_write_data_channel_m2s_s;

    typedef struct {
        logic wready;
    } type_write_data_channel_s2m_s;

    //write response channel
    typedef struct {
        logic bready;
    } type_write_response_channel_m2s_s;

    typedef struct {
        logic bresp;
        logic bvalid;
    } type_write_response_channel_s2m_s;

    enum logic [1:0] {OKAY} WRC_BRESP;

    // External use interfaces
    typedef struct {
        logic aclk;
        logic aresetn;
        type_read_address_channel_m2s_s     rac;
        type_read_data_channel_m2s_s        rdc;
        type_write_address_channel_m2s_s    wac;
        type_write_data_channel_m2s_s       wdc;
        type_write_response_channel_m2s_s   wrc;
    } type_axi4lite_master2slave_s;

    typedef struct {
        type_read_address_channel_s2m_s     rac;
        type_read_data_channel_s2m_s        rdc;
        type_write_address_channel_s2m_s    wac;
        type_write_data_channel_s2m_s       wdc;
        type_write_response_channel_s2m_s   wrc;
    } type_axi4lite_slave2master_s;

endpackage
