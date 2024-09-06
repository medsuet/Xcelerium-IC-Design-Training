
`include "../param/sb_defs.svh"

module store_buffer (
    input wire                         clk,
    input wire                         rst_n,
    
    input wire                         dmem_sel_i,
    input wire                         dcache_flush_i,
    input wire                         dcache_kill_i,

    output wire                        dmem_sel_o,
    output wire                        dcache_flush_o,
    output wire                        dcache_kill_o,

    // LSU/MMU to store buffer interface
    input type_lsummu2dcache_s         lsummu2sb_i,
    output type_dcache2lsummu_s        sb2lsummu_o,

    // store buffer to data cache interface
    input type_dcache2lsummu_s         dcache2sb_i,
    output type_lsummu2dcache_s        sb2dcache_o
);
 
    logic bottom_que_en;
    logic wr_en;
    logic clear_valid;
    logic kill_valid;
    logic read_en;
    logic read_sel;
    logic tq_eq_bq;
    logic is_valid_bq;
    logic addr_not_available;

    assign dmem_sel_o = dmem_sel_i;

    store_buffer_datapath store_buffer_datapath_module (
        .clk                           (clk),
        .rst_n                         (rst_n),

        // Interface signals to/from store_buffer_controller
        .bottom_que_en                 (bottom_que_en),
        .wr_en                         (wr_en),
        .clear_valid                   (clear_valid),
        .kill_valid                    (kill_valid),
        .read_en                       (read_en),
        .read_sel                      (read_sel),
        .tq_eq_bq                      (tq_eq_bq),
        .is_valid_bq                   (is_valid_bq),
        .addr_not_available            (addr_not_available),

        // Interface data signals LSU/MMU to/from store buffer 
        .lsummu2sb_i_addr              (lsummu2sb_i.addr),
        .lsummu2sb_i_w_data            (lsummu2sb_i.w_data),
        .lsummu2sb_i_sel_byte          (lsummu2sb_i.sel_byte),
        .sb2lsummu_o_r_data            (sb2lsummu_o.r_data),

        // Interface data signals store buffer to/from dcache
        .sb2dcache_o_addr              (sb2dcache_o.addr),
        .sb2dcache_o_w_data            (sb2dcache_o.w_data),
        .sb2dcache_o_sel_byte          (sb2dcache_o.sel_byte),
        .dcache2sb_i_r_data            (dcache2sb_i.r_data)
    );

    store_buffer_controller store_buffer_controller_module (
        .clk                           (clk),
        .rst_n                         (rst_n),

        .dcache_flush_i                (dcache_flush_i),
        .dcache_kill_i                 (dcache_kill_i),
        .dcache_flush_o                (dcache_flush_o),
        .dcache_kill_o                 (dcache_kill_o),

        // Interface signals to/from store_buffer_controller
        .bottom_que_en                 (bottom_que_en),
        .wr_en                         (wr_en),
        .clear_valid                   (clear_valid),
        .kill_valid                    (kill_valid),
        .read_en                       (read_en),
        .read_sel                      (read_sel),
        .tq_eq_bq                      (tq_eq_bq),
        .is_valid_bq                   (is_valid_bq),
        .addr_not_available            (addr_not_available),

        // Interface control signals LSU/MMU to/from store buffer 
        .lsummu2sb_i_w_en              (lsummu2sb_i.w_en),
        .lsummu2sb_i_req               (lsummu2sb_i.req),
        .sb2lsummu_o_ack               (sb2lsummu_o.ack),

        // Interface control signals store buffer to/from dcache
        .sb2dcache_o_w_en              (sb2dcache_o.w_en),
        .sb2dcache_o_req               (sb2dcache_o.req),
        .dcache2sb_i_ack               (dcache2sb_i.ack)
    );

    






endmodule