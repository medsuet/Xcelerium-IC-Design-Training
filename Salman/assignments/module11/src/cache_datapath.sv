`include "cache_defs.svh"

module cache_datapath(
    input logic clk,
    input logic rst,
    input logic flush,
    input logic [31:0] addr,                // Address from processor
    input logic [31:0] w_data,              // Data from processor
    input wire type_controller_out cache_i,
    input wire type_mem2cache mem2cache,
    output type_cache2mem cache2mem,
    output logic [31:0] r_data,              // Read data from cache
    output logic dirty, flush_done, cache_hit
);
    logic [8:0] i;
    
    logic [127:0] cache_mem [255:0];          // 4 KB Cache Memory
                                            // 16 B Cache line
                                            // 256 index
    logic [19:0] tag_mem [255:0];             // Tag memory

    logic [255:0] reg_valid;              // Valid Bit Register
    logic [255:0] reg_dirty;              // Dirty Bit Register

    // logic [127:0] data_mem [27:0];       // 4 GB Data Memory

    type_cache_address cache;

    logic dirty_bit;                        // Dirty bit in case of flushing
    logic [7:0] wr_index;                   // Index bit for Writeback vs Flush

    assign cache.offset = addr[3:0];
    assign cache.index = addr[11:4];
    assign cache.tag = addr[31:12];
    assign cache.valid = reg_valid[cache.index];
    assign cache.dirty = reg_dirty[cache.index];

    //type_controller_in cache2controller;

    //assign cache2controller.cpu_req = cpu_req;
    //assign cache2controller.req_type = req_type;
    //assign cache2controller.flush = flush;
    assign dirty = dirty_bit;
    assign flush_done = (i == 256);
    assign cache_hit = ((cache.valid == 1) && (cache.tag == tag_mem[cache.index]));

    always_ff @(posedge clk or negedge rst)
    begin
        if (!rst)
            begin
                reg_valid <= #1 0;
                reg_dirty <= #1 0;
            end
        else
            begin
                if (cache_i.wr_en)
                    begin
                        reg_dirty[cache.index] <= #1 1;
                        reg_valid <= reg_valid;
                    end
                else if (cache_i.rd_en)
                    begin
                        reg_dirty <= #1 reg_dirty;
                        reg_valid <= #1 reg_valid;
                    end
                else if (cache_i.mem_wr)
                    begin
                        reg_dirty[wr_index] <= #1 0;
                        reg_valid <= #1 reg_valid;
                    end
                else if (cache_i.mem_rd)
                    begin
                        reg_dirty[cache.index] <= #1 0;
                        reg_valid[cache.index] <= #1 1;
                    end
            end
    end

    always_ff @(posedge clk)
    begin
        if (cache_i.wr_en)                      // Write to cache memory
        begin
            case (cache.offset[3:2])
                2'd0: cache_mem[cache.index][31:0]   <= #1 w_data;
                2'd1: cache_mem[cache.index][63:32]  <= #1 w_data;
                2'd2: cache_mem[cache.index][95:64]  <= #1 w_data;
                2'd3: cache_mem[cache.index][127:96] <= #1 w_data;
            endcase
            //reg_dirty[cache.index] <= #1 1;
        end
    end

    always_comb
    begin
        if (cache_i.rd_en)                      // Read from cache memory
        begin
            case (cache.offset[3:2])
                2'd0: r_data = cache_mem[cache.index][31:0];
                2'd1: r_data = cache_mem[cache.index][63:32];
                2'd2: r_data = cache_mem[cache.index][95:64];
                2'd3: r_data = cache_mem[cache.index][127:96];
            endcase
        end
    end


    always_ff @(posedge clk)
    begin
        if (cache_i.mem_wr)                     // Write cache line to data memory
        begin
            cache2mem.data[31:0]   <= #1 cache_mem[wr_index][31:0];
            cache2mem.data[63:32]  <= #1 cache_mem[wr_index][63:32];
            cache2mem.data[95:64]  <= #1 cache_mem[wr_index][95:64];
            cache2mem.data[127:96] <= #1 cache_mem[wr_index][127:96];
            cache2mem.addr         <= #1 {cache.tag,wr_index,4'b0};
            //reg_dirty[wr_index]    <= #1 0;
        end
    end

    always_ff @(posedge clk)
    begin
        if (cache_i.mem_rd)                     // Read a line from data memory
        begin
            cache_mem[cache.index][31:0]   = mem2cache.data[31:0]  ;
            cache_mem[cache.index][63:32]  = mem2cache.data[63:32] ;
            cache_mem[cache.index][95:64]  = mem2cache.data[95:64] ;
            cache_mem[cache.index][127:96] = mem2cache.data[127:96];
            //reg_valid[cache.index]         <= #1 1;
            tag_mem[cache.index]           = cache.tag;
        end
    end

    always_ff @(posedge clk)
    begin
        if (cache_i.cache_clean)                // Flush the cache
        begin
            wr_index  <= #1 i;
            dirty_bit <= #1 reg_dirty[i];
            i <= #1 i + 1;
        end
        else if (flush)                         // Waiting for mem_ack
        begin
            wr_index  <= #1 i-1;
            dirty_bit <= #1 reg_dirty[i-1];
            i <= #1 i;
        end
        else                                    // Not flusing
        begin
            wr_index <= #1 cache.index;
            dirty_bit <= #1 cache.dirty;
            i <= #1 0;
        end
    end

endmodule