`include "defs.svh"
module cache_ctrl(input logic clk, 
input logic rst, 
input logic src_valid,
input logic cpu_request,
input logic flush_done, 
input logic cache_hit, 
output logic rd_dcache, 
input logic rd_req, 
input logic wr_req, 
output logic wr_dcache, 
input logic cache_miss, 
output logic en, 
input logic valid_ff, 
input logic dirty_ff,
output logic flushing, 
input logic flush, 
input logic ready_mem, 
output logic rd_mem_req,
output logic wr_mem_req, 
output logic wr_rd_mem_req, 
output logic dest_valid,
output logic arvalid,
output logic wvalid,
output logic awvalid,
input logic  bvalid, 
output logic src_ready,
input logic dest_ready,
output logic init
);
typedef enum logic [1:0]{
    IDLE,
    PROCESSREQUEST, 
    WAIT,
    FLUSH
} state_enum;
state_enum current_state, next_state;

always_ff@(posedge clk, negedge rst) begin
    if (~rst) begin
        current_state<=IDLE;
    end else begin
        current_state<=next_state;
    end
end
always_comb begin
    case(current_state) 
    IDLE: begin
        flushing=0;
        en=0;
        wr_mem_req=0;
        rd_mem_req=0;
        wr_rd_mem_req=0;
        wvalid=0;
        awvalid=0;
        arvalid=0;
        rd_dcache=0;
        wr_dcache=0;
        src_ready=1;
        dest_valid=0;
        init=0;
        if (src_valid&&cpu_request) begin //cpu_request 1 when load or store instruction encounters
            next_state=PROCESSREQUEST;
            en=1;
            init=1;
        end else begin
            next_state=IDLE;
        end
        if (src_valid&&flush) begin
            next_state=FLUSH;
            flushing=1;
        end
    end
    PROCESSREQUEST: begin
        en=0;
        src_ready=0;
        flushing=0;
        wr_mem_req=0;
        rd_mem_req=0;
        wr_rd_mem_req=0;
        wvalid=0;
        awvalid=0;
        arvalid=0;
        src_ready=0;
        init=0;
        dest_valid=0;
        if (cache_hit) begin
            dest_valid=1;
            if (dest_ready) begin
                src_ready=1;
                next_state=IDLE;
            end
            else begin
                next_state=PROCESSREQUEST;
            end
            if (rd_req) begin
                rd_dcache=1;
                wr_dcache=0;
            end else if (wr_req) begin
                wr_dcache=1;
                rd_dcache=0;
            end else begin
                rd_dcache=0;
                wr_dcache=0;
            end
        end else if ((cache_miss)&&(~dirty_ff)) begin
            next_state=WAIT;
            rd_mem_req=1;
            arvalid=1;
        end else if ((cache_miss)&&(dirty_ff)) begin
            next_state=WAIT;
            wr_rd_mem_req=1;
            wvalid=1;
            awvalid=1;
        end
    end
    WAIT: begin
        en=0;
        wvalid=0;
        awvalid=0;
        arvalid=0;
        src_ready=0;
        dest_valid=0;
        if (~flush&bvalid) begin
            arvalid=1;
        end
        else begin
            arvalid=0;
        end
        if (ready_mem) begin
            rd_mem_req=0;
            wr_mem_req=0;
            wr_rd_mem_req=0;
            if (flush) begin
                flushing=1;
                next_state=FLUSH;
            end else begin
                next_state=PROCESSREQUEST;
            end
        end else if (~ready_mem) begin
            next_state=WAIT;
        end
    end
    FLUSH: begin
        en=0;
        wr_mem_req=0;
        rd_mem_req=0;
        wr_rd_mem_req=0;
        wvalid=0;
        awvalid=0;
        arvalid=0;
        src_ready=0;
        dest_valid=0;
        if (dirty_ff&~flush_done) begin
            next_state=WAIT;
            flushing=1;
            wr_mem_req=1;
            wvalid=1;
            awvalid=1;
        end else if (~dirty_ff&~flush_done) begin
            next_state=FLUSH;
            flushing=1;
        end else if (flush_done) begin
            flushing=0;
            if (dest_ready) begin
                src_ready=1;
                next_state=IDLE;
            end else begin
                next_state=FLUSH;
            end
            dest_valid=1;
        end
    end
    endcase
end
endmodule