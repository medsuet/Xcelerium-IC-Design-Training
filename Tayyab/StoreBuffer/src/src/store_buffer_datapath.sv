// Copyright 2024 University of Engineering and Technology Lahore.
// Licensed under the Apache License, Version 2.0, see LICENSE file for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description: Datapath for store buffer
//
// Author: Muhammad Tayyab, UET Lahore
// Date: 7.9.2023

`timescale 1 ns / 100 ps

`ifndef VERILATOR
`include "../../defines/cache_defs.svh"
`include "../../defines/sb_defs.svh"
`else
`include "cache_defs.svh"
`include "sb_defs.svh"
`endif

module store_buffer_datapath (
    input wire                            clk,
    input wire                            rst_n,

    // Interface signals to/from store_buffer_controller
    input logic                           bottom_que_en,
    input logic                           wr_en,
    input logic                           clear_valid,
    input logic                           kill_valid,
    input logic                           read_en,
    input logic                           read_sel,
    output logic                          tq_eq_bq,
    output logic                          is_valid_bq,
    output logic                          addr_not_available,

    // Interface data signals LSU/MMU to/from store buffer 
    input logic  [DCACHE_ADDR_WIDTH-1:0]  lsummu2sb_i_addr,
    input logic  [DCACHE_DATA_WIDTH-1:0]  lsummu2sb_i_w_data,
    input logic  [3:0]                    lsummu2sb_i_sel_byte,
    output logic [DCACHE_DATA_WIDTH-1:0]  sb2lsummu_o_r_data,

    // Interface data signals store buffer to/from dcache
    output logic [DCACHE_ADDR_WIDTH-1:0]  sb2dcache_o_addr,
    output logic [DCACHE_DATA_WIDTH-1:0]  sb2dcache_o_w_data,
    output logic [3:0]                    sb2dcache_o_sel_byte,
    input logic  [DCACHE_DATA_WIDTH-1:0]  dcache2sb_i_r_data

);

    logic [DCACHE_ADDR_WIDTH-1:0]         addr_buffer    [SB_NO_OF_LINES-1:0];    
    logic [DCACHE_DATA_WIDTH-1:0]         data_buffer    [SB_NO_OF_LINES-1:0];
    logic [SB_NO_OF_LINES-1:0]            valid_buffer;                           // Stores (1) if data at each index data_buffer is yet to be evacuated to cache.
    logic [3:0]                           selbyte_buffer [SB_NO_OF_LINES-1:0];

    logic [$clog2(SB_NO_OF_LINES)-1:0]    top_que;            // Points to index of data_buffer where next data from processor will be saved.
    logic [$clog2(SB_NO_OF_LINES)-1:0]    bottom_que;         // Points to index of data_buffer from where data is being evacuated to cache.

    logic [DCACHE_DATA_WIDTH-1:0]         data_buffer_out;    // Output of data_buffer at data_buffer_read_index
    logic [2:0]                           data_buffer_read_index;
    logic [$clog2(SB_NO_OF_LINES)-1:0]    encoded_index;      // Index of data_buffer containing data for lsu's input address
    logic [$clog2(SB_NO_OF_LINES)-1:0]    encoded_index_high; // Highest index of data_buffer containing data for lsu's input address
    logic [$clog2(SB_NO_OF_LINES)-1:0]    encoded_index_low;  // Lowest index of data_buffer containing data for lsu's input address
    logic [SB_NO_OF_LINES-1:0]            addr_availables;    // Index of this array is HIGH if data for lsu's input address if present at corresponding index of data_buffer

    assign tq_eq_bq = top_que == bottom_que;
    assign addr_not_available = addr_availables == 0;

    // top_que, bottom_que counter
    always_ff @(posedge clk) begin
      if (!rst_n) begin
        top_que <= '0;
        bottom_que <= '0;
      end 
      else begin
          top_que <= (wr_en) ? top_que + 1 : top_que;
          bottom_que <= (bottom_que_en) ? bottom_que + 1 : bottom_que;
      end     
    end

    // write to valid buffer
    always_ff @(posedge clk) begin
      if (!rst_n) begin
        valid_buffer <= '0;
      end
      else if (kill_valid) begin
        valid_buffer <= '0;
      end
      else begin
        valid_buffer[bottom_que] <= (clear_valid) ? 1'b0 : valid_buffer[bottom_que];
        valid_buffer[top_que] <= (wr_en) ? 1'b1 : valid_buffer[top_que];
      end
    end

    // write to addr buffer, data buffer, selbyte buffer
    always_ff @(posedge clk) begin
      if (wr_en) begin
        addr_buffer[top_que] <= lsummu2sb_i_addr;
        data_buffer[top_que] <= lsummu2sb_i_w_data;
        selbyte_buffer[top_que] <= lsummu2sb_i_sel_byte;
      end
    end

    // read from valid_buffer, addr buffer, data buffer, selbyte buffer
    always_comb begin
      is_valid_bq = valid_buffer[bottom_que];
      data_buffer_read_index = (read_sel) ? encoded_index : bottom_que;
      data_buffer_out = data_buffer[data_buffer_read_index];
      sb2dcache_o_w_data = data_buffer_out;
      sb2dcache_o_addr = (read_en) ? lsummu2sb_i_addr : addr_buffer[bottom_que];
      sb2dcache_o_sel_byte = (read_en) ? lsummu2sb_i_sel_byte : selbyte_buffer[bottom_que];
      sb2lsummu_o_r_data = (read_sel) ? data_buffer_out : dcache2sb_i_r_data;
    end

    // load request
    genvar j;
    for (j=0; j<SB_NO_OF_LINES; j++) begin
      assign addr_availables[j] = (addr_buffer[j] == lsummu2sb_i_addr) & valid_buffer[j] & (selbyte_buffer[j] == lsummu2sb_i_sel_byte);
    end

    assign encoded_index = (top_que > bottom_que) ? encoded_index_high : encoded_index_low;

    priority_encoder_high_8bit priority_encoder_high_module (
      .in(addr_availables),
      .out(encoded_index_high)
    );

    priority_encoder_low_8bit priority_encoder_low_module (
      .in(addr_availables),
      .out(encoded_index_low)
    );

endmodule
