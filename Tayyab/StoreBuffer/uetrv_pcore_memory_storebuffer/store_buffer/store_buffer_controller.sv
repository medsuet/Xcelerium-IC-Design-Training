// Copyright 2024 University of Engineering and Technology Lahore.
// Licensed under the Apache License, Version 2.0, see LICENSE file for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description: Controller for store buffer
//
// Author: Muhammad Tayyab, UET Lahore
// Date: 7.9.2023

`timescale 1 ns / 100 ps

//`define VERILATOR

`ifndef VERILATOR
`include "../../defines/cache_defs.svh"
`include "../../defines/sb_defs.svh"
`else
`include "cache_defs.svh"
`include "sb_defs.svh"
`endif

module store_buffer_controller (
    input wire                            clk,
    input wire                            rst_n,

    input logic                           dcache_flush_i,
    input logic                           dcache_kill_i,
    output logic                          dcache_flush_o,
    output logic                          dcache_kill_o,

    // Interface signals to/from store_buffer_datapath
    output logic                          bottom_que_en,
    output logic                          wr_en,
    output logic                          clear_valid,
    output logic                          kill_valid,
    output logic                          read_en,
    output logic                          read_sel,
    input logic                           tq_eq_bq,
    input logic                           is_valid_bq,
    input logic                           addr_not_available,

    // Interface control signals LSU/MMU to/from store buffer 
    input logic                           lsummu2sb_i_w_en,
    input logic                           lsummu2sb_i_req,
    output logic                          sb2lsummu_o_ack,

    // Interface control signals store buffer to/from dcache
    output logic                          sb2dcache_o_w_en,
    output logic                          sb2dcache_o_req,
    input logic                           dcache2sb_i_ack
    
);

    type_sb_cachehandler_states_e         sb_cachehandler_ff, sb_cachehandler_next;

    logic                                 cache_write, cache_write_ack, cache_read, cache_read_ack;
    logic                                 sb2lsummu_o_ack_read, sb2lsummu_o_ack_write, sb2lsummu_o_ack_flush;
    logic                                 stall;

    assign stall = tq_eq_bq & is_valid_bq;
    assign sb2lsummu_o_ack = sb2lsummu_o_ack_read || sb2lsummu_o_ack_write || sb2lsummu_o_ack_flush;

    // State machines
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            sb_cachehandler_ff = SB_CACHE_IDLE;
        end
        else begin
            sb_cachehandler_ff = sb_cachehandler_next;
        end
    end

    // Logic for store buffer evacuate
    always_comb begin
        // Defaults
        bottom_que_en = 1'b0;
        clear_valid = 1'b0;
        cache_write = 1'b0;

        if ( !(tq_eq_bq & !is_valid_bq) ) begin
            cache_write = 1;
           
            if (cache_write_ack) begin
                clear_valid = 1;
                bottom_que_en = 1;
            end
        end
        
    end

    // Logic for storing data in buffer
    always_comb begin
        if (lsummu2sb_i_req & lsummu2sb_i_w_en & !stall) begin
            // store incoming data
            wr_en = 1;
            sb2lsummu_o_ack_write = 1;
        end
        else begin
            // dont store incoming data, stall processor
            wr_en = 0;
            sb2lsummu_o_ack_write = 0;
        end
    end
    
    // Logic for load request
    always_comb begin
        // Defaults
        cache_read = 0;
        sb2lsummu_o_ack_read = 0;
        read_sel = 0;

        // check for a load request
        if (lsummu2sb_i_req & !lsummu2sb_i_w_en) begin
            if (!addr_not_available) begin
                // load from store buffer
                read_sel = 1;
                sb2lsummu_o_ack_read = 1;
            end
            else begin
                // load from cache
                cache_read = 1;
                if (cache_read_ack) begin
                    sb2lsummu_o_ack_read = 1; // debug here
                end
            end
        end
    end
    
    // dcache handler
    always_comb begin
        sb_cachehandler_next = SB_CACHE_IDLE;
        cache_read_ack = 0;
        cache_write_ack = 0;
        sb2dcache_o_w_en = 0;
        sb2dcache_o_req = 0;
        dcache_flush_o = 0;
        dcache_kill_o = 0;
        read_en = 0;
        kill_valid = 0;
        sb2lsummu_o_ack_flush = 0;

        case (sb_cachehandler_ff)
            SB_CACHE_IDLE:
            begin
                if (dcache_kill_i) begin
                    sb_cachehandler_next = SB_CACHE_FLUSH;
                    dcache_kill_o = 1;
                end
                else if (dcache_flush_i) begin
                    sb_cachehandler_next = SB_CACHE_FLUSH;
                    dcache_flush_o = 1;
                end
                else if (cache_read) begin
                    sb_cachehandler_next = SB_CACHE_READ;
                    sb2dcache_o_w_en = 0;
                    sb2dcache_o_req = 1;
                    read_en = 1;
                end
                else if (cache_write) begin
                    sb_cachehandler_next = SB_CACHE_WRITE;
                    sb2dcache_o_w_en = 1;
                    sb2dcache_o_req = 1;
                end
                else begin
                    sb_cachehandler_next = SB_CACHE_IDLE;
                end
            end

            SB_CACHE_READ:
            begin
                if (dcache2sb_i_ack) begin
                    cache_read_ack = 1;
                    
                    if (dcache_kill_i) begin
                        sb_cachehandler_next = SB_CACHE_FLUSH;
                        dcache_kill_o = 1;
                    end
                    if (cache_read) begin
                        sb_cachehandler_next = SB_CACHE_READ;
                        sb2dcache_o_w_en = 0;
                        sb2dcache_o_req = 1;
                        read_en = 1;
                    end
                    else if (cache_write) begin
                        sb_cachehandler_next = SB_CACHE_WRITE;
                        sb2dcache_o_w_en = 1;
                        sb2dcache_o_req = 1;
                    end
                    else begin
                        sb_cachehandler_next = SB_CACHE_IDLE;
                    end
                end
                else begin
                    sb_cachehandler_next = SB_CACHE_READ;
                    sb2dcache_o_w_en = 0;
                    sb2dcache_o_req = 1;
                    read_en = 1;
                end
            end

            SB_CACHE_WRITE:
            begin
                if (dcache2sb_i_ack) begin
                    cache_write_ack = 1;

                    if (dcache_kill_i) begin
                        sb_cachehandler_next = SB_CACHE_FLUSH;
                        dcache_kill_o = 1;
                    end
                    if (cache_read) begin
                        sb_cachehandler_next = SB_CACHE_READ;
                        sb2dcache_o_w_en = 0;
                        sb2dcache_o_req = 1;
                        read_en = 1;
                    end
                    else if (cache_write) begin
                        sb_cachehandler_next = SB_CACHE_WRITE;
                        sb2dcache_o_w_en = 1;
                        sb2dcache_o_req = 1;
                    end
                    else begin
                        sb_cachehandler_next = SB_CACHE_IDLE;
                    end
                end
                else begin
                    sb_cachehandler_next = SB_CACHE_WRITE;
                    sb2dcache_o_w_en = 1;
                    sb2dcache_o_req = 1;
                end
            end

            SB_CACHE_FLUSH:
            begin
                if (dcache2sb_i_ack) begin
                    sb_cachehandler_next = SB_CACHE_IDLE;
                    sb2lsummu_o_ack_flush = 1;
                end
                else begin
                    dcache_flush_o = dcache_flush_o;
                    dcache_kill_o = dcache_kill_o;
                end
            end
        endcase
    end



endmodule
