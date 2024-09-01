`include "defs.svh"
module cache_controller(input logic clk, rst, valid, input logic bvalid, input logic cpu_request,
input logic flush_done, input logic cache_hit, output logic rd_dcache, input logic rd_req, wr_req, 
output logic wr_dcache, input logic cache_miss, output logic en, input logic valid_ff, dirty_ff,
output logic flushing, input logic flush, output logic d_clear, tag_en, en_line
, input logic arready,input logic  rvalid, input logic wready, input logic awready, 
output logic arvalid, output logic rready, output logic wvalid, output logic awvalid, output logic bready
, output logic ready, output logic init);
typedef enum logic [2:0]{
    IDLE,
    PROCESSREQUEST, 
    CACHEALLOCATE,
    WRITEBACK,
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
        wr_dcache=0;
        rd_dcache=0;
        arvalid=0;
        rready=0;
        flushing=0;
        d_clear=0;
        en_line=0;
        tag_en=0;
        wvalid=0;
        awvalid=0;
        bready=0;
        ready=0;
        init=0;
        if (valid&&cpu_request) begin //cpu_request 1 when load or store instruction encounters
            next_state=PROCESSREQUEST;
            en=1;
            init=1;
        end else begin
            en=0;
            next_state=IDLE;
        end
        if (flush) begin
            en=0;
            next_state=FLUSH;
            flushing=1;
        end
    end
    PROCESSREQUEST: begin
        en=0;
        en_line=0;
        tag_en=0;
        wvalid=0;
        awvalid=0;
        bready=0;
        arvalid=0;
        rready=0;
        ready=0;
        init=0;
        if (cache_hit) begin
            next_state=IDLE;
            ready=1;
            if (rd_req) begin
                rd_dcache=1;
                wr_dcache=0;
            end else if (wr_req) begin
                wr_dcache=1;
                rd_dcache=0;
        end
        end else if ((cache_miss)&&(~dirty_ff)&&(arready)) begin
            next_state=CACHEALLOCATE;
            arvalid=1;
            rready=1;
        end else if ((cache_miss)&&(~dirty_ff)&&(~arready)) begin
            next_state=PROCESSREQUEST;
            arvalid=1;
            rready=1;
        end else if ((cache_miss)&&(dirty_ff)&&(wready&awready)) begin
            arvalid=0;
            rready=0;
            wvalid=1;
            awvalid=1;
            bready=1;
            next_state=WRITEBACK;
        end else if ((cache_miss)&&(dirty_ff)&&~(wready&awready)) begin
            arvalid=0;
            rready=0;
            wvalid=1;
            awvalid=1;
            bready=1;
            next_state=PROCESSREQUEST;
        end

    end
    CACHEALLOCATE: begin
        en=0;
        d_clear=0;
        en_line=0;
        tag_en=0;
        arvalid=0;
        rready=0;
        wvalid=0;
        awvalid=0;
        bready=0;
        ready=0;
        if (~rvalid) begin
            next_state=CACHEALLOCATE;
        end else if (rvalid) begin
            next_state=PROCESSREQUEST;
            en_line = 1;
            tag_en=1 ;
        end
    end
    WRITEBACK: begin
        en=0;
        arvalid=0;
        rready=0;
        wvalid=0;
        awvalid=0;
        bready=0;
        ready=0;
        if (~bvalid) begin
            next_state=WRITEBACK;
        end else if (bvalid&~flush&arready) begin
            next_state=CACHEALLOCATE;
            d_clear=1;
            arvalid=1;
            rready=1;
        end else if (bvalid&~flush&~arready) begin
            next_state=WRITEBACK;
            d_clear=1;
            arvalid=1;
            rready=1;
        end else if (bvalid&flush) begin
            next_state=FLUSH;
            flushing=1;
            d_clear=0;
        end
    end
    FLUSH: begin
        en=0;
        wvalid=0;
        awvalid=0;
        bready=0;
        ready=0;
        if (dirty_ff&~flush_done&&(wready&awready)) begin
            next_state=WRITEBACK;
            flushing=1;
            wvalid=1;
            awvalid=1;
            bready=1;
        end else if (dirty_ff&~flush_done&&~(wready&awready)) begin
            next_state=FLUSH;
            flushing=1;
            wvalid=1;
            awvalid=1;
            bready=1;
        end else if (~dirty_ff&~flush_done) begin
            next_state=FLUSH;
            flushing=1;
        end else if (flush_done) begin
            flushing=0;
            next_state=IDLE;
            ready=1;
        end
    end
    endcase
end
endmodule