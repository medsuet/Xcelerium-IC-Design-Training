`include "cache_defs.svh"

module cache_controller(
    input logic clk,
    input logic rst,
    input logic main_mem_ack,
    input wire type_controller_in controller_i,
    output type_controller_out controller_o,
    output logic stall
    //output type_controller2mem controller2mem_o,
    //output type_controller2cache controller2cache_o,
);
    
type_cache_states c_state, n_state;

always_ff @(posedge clk or negedge rst)
begin
    if (!rst)
        c_state <= #1 IDLE;
    else
        c_state <= #1 n_state;
end

always_comb 
begin
    case (c_state)
        IDLE:               begin
                                if (controller_i.cpu_req)
                                    n_state = PROCESS_REQUEST;
                                else if (controller_i.flush)
                                    n_state = FLUSH;
                                else
                                    n_state = IDLE;
                            end
        PROCESS_REQUEST:    begin
                                if (controller_i.cache_hit)
                                    n_state = IDLE;
                                else if (controller_i.dirty)
                                    n_state = WRITEBACK;
                                else
                                    n_state = CACHE_ALLOCATE;
                            end
        CACHE_ALLOCATE:     begin
                                if (main_mem_ack)
                                    n_state = PROCESS_REQUEST;
                                else
                                    n_state = CACHE_ALLOCATE;
                            end
        WRITEBACK:          begin
                                if (main_mem_ack)
                                    begin
                                        if (controller_i.flush)
                                            n_state = FLUSH;
                                        else
                                            n_state = CACHE_ALLOCATE;
                                    end
                                else
                                    n_state = WRITEBACK;
                            end
        FLUSH:              begin
                                if (controller_i.flush_done)
                                    n_state = IDLE;
                                else
                                    begin
                                        if (controller_i.dirty)
                                            n_state = WRITEBACK;
                                        else
                                            n_state = FLUSH;
                                    end
                            end
    endcase
end

always_comb
begin
        case (c_state)
        IDLE:               begin
                                controller_o.wr_en       = 0;
                                controller_o.rd_en       = 0;
                                controller_o.mem_wr      = 0;
                                controller_o.mem_rd      = 0;
                                controller_o.cache_clean = 0;
                                if (controller_i.cpu_req)
                                    stall = 1;
                                else
                                    stall = 0;
                            end
        PROCESS_REQUEST:    begin
                                if (controller_i.cache_hit)
                                    begin
                                        if (controller_i.req_type)       // Write request
                                            begin
                                                controller_o.wr_en       = 1;
                                                controller_o.rd_en       = 0;
                                                controller_o.mem_wr      = 0;
                                                controller_o.mem_rd      = 0;
                                                controller_o.cache_clean = 0;
                                            end
                                        else                // Read request
                                            begin
                                                controller_o.wr_en       = 0;
                                                controller_o.rd_en       = 1;
                                                controller_o.mem_wr      = 0;
                                                controller_o.mem_rd      = 0;
                                                controller_o.cache_clean = 0;
                                            end
                                    end
                                else
                                    begin
                                        if (controller_i.dirty)
                                            begin
                                                controller_o.wr_en       = 0;
                                                controller_o.rd_en       = 0;
                                                controller_o.mem_wr      = 1;
                                                controller_o.mem_rd      = 0;
                                                controller_o.cache_clean = 0;
                                            end
                                        else
                                            begin
                                                controller_o.wr_en       = 0;
                                                controller_o.rd_en       = 0;
                                                controller_o.mem_wr      = 0;
                                                controller_o.mem_rd      = 1;
                                                controller_o.cache_clean = 0;
                                            end
                                    end
                                stall = 1;
                            end
        CACHE_ALLOCATE:     begin
                                if (main_mem_ack)
                                    begin
                                        controller_o.wr_en       = 0;
                                        controller_o.rd_en       = 0;
                                        controller_o.mem_wr      = 0;
                                        controller_o.mem_rd      = 0;
                                        controller_o.cache_clean = 0;
                                    end
                                else
                                    begin
                                        controller_o.wr_en       = 0;
                                        controller_o.rd_en       = 0;
                                        controller_o.mem_wr      = 0;
                                        controller_o.mem_rd      = 1;
                                        controller_o.cache_clean = 0;
                                    end
                                stall = 1;
                            end
        WRITEBACK:          begin
                                if (main_mem_ack)
                                    begin
                                        if (controller_i.flush)
                                            begin
                                                controller_o.wr_en       = 0;
                                                controller_o.rd_en       = 0;
                                                controller_o.mem_wr      = 0;
                                                controller_o.mem_rd      = 0;
                                                controller_o.cache_clean = 1;
                                            end
                                        else
                                            begin
                                                controller_o.wr_en       = 0;
                                                controller_o.rd_en       = 0;
                                                controller_o.mem_wr      = 0;
                                                controller_o.mem_rd      = 1;
                                                controller_o.cache_clean = 0;
                                            end
                                    end
                                    else
                                    begin
                                        controller_o.wr_en       = 0;
                                        controller_o.rd_en       = 0;
                                        controller_o.mem_wr      = 1;
                                        controller_o.mem_rd      = 0;
                                        controller_o.cache_clean = 0;
                                    end
                                    stall = 1;
                            end
        FLUSH:              begin
                                if (controller_i.flush_done)
                                    begin
                                        controller_o.wr_en       = 0;
                                        controller_o.rd_en       = 0;
                                        controller_o.mem_wr      = 0;
                                        controller_o.mem_rd      = 0;
                                        controller_o.cache_clean = 0;
                                    end
                                else
                                    begin
                                        if (controller_i.dirty)
                                            begin
                                                controller_o.wr_en       = 0;
                                                controller_o.rd_en       = 0;
                                                controller_o.mem_wr      = 1;
                                                controller_o.mem_rd      = 0;
                                                controller_o.cache_clean = 0;
                                            end
                                        else
                                            begin
                                                controller_o.wr_en       = 0;
                                                controller_o.rd_en       = 0;
                                                controller_o.mem_wr      = 0;
                                                controller_o.mem_rd      = 0;
                                                controller_o.cache_clean = 1;
                                            end
                                    end
                                stall = 1;
                            end
    endcase
end

endmodule