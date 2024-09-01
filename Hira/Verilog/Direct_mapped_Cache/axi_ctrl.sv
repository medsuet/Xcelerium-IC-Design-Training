module axi_ctrl(input logic clk, input logic rst, input logic rd_mem_req, input logic wr_mem_req, 
input logic wr_rd_mem_req, input logic  rvalid, input logic wready, input logic awready, 
input logic arvalid, output logic rready, input logic wvalid, input logic awvalid, output logic bready
, output logic ready_mem, input logic bvalid, input logic arready, output logic d_clear,
output logic tag_en, en_line, en_valid);
typedef enum logic [2:0]{
    IDLE,
    WAITWRITE, 
    RESPWRITE,
    WAITREAD,
    RESPREAD
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
        ready_mem=0;
        bready=1;
        rready=1;
        en_line = 0;
        tag_en=0;
        d_clear=0;
        en_valid=0;
        if (((~wr_mem_req|~wr_rd_mem_req)&(~wvalid|~awvalid))&((~rd_mem_req)&(~arvalid))) begin
            next_state=IDLE;
        end else if ((wr_mem_req|wr_rd_mem_req)&(wvalid&awvalid)) begin
            if (wready&awready) begin
                next_state=RESPWRITE;
            end else begin
                next_state=WAITWRITE;
            end

        end else if ((rd_mem_req)&(arvalid)) begin
            if (arready) begin
                next_state=RESPREAD;
            end else begin
                next_state=WAITREAD;
            end
        end
    end
    WAITWRITE: begin
        en_line = 0;
        tag_en=0;
        bready=0;
        d_clear=0;
        en_valid=0;
        if (awready&wready) begin
            next_state=RESPWRITE;
        end else begin
            next_state=WAITREAD;
        end
    end
    RESPWRITE: begin
        en_line = 0;
        tag_en=0;
        bready=0;
        d_clear=0;
        en_valid=0;
        if (wr_rd_mem_req&bvalid) begin
            if (arready) begin
                next_state=RESPREAD;
            end else begin
                next_state=WAITREAD;
            end
        end else if (~wr_rd_mem_req&bvalid) begin
            next_state=IDLE;
            ready_mem=1;
        end else if (~bvalid) begin
            next_state=RESPWRITE;
        end
        if (bvalid) begin
            d_clear=1;
        end else begin
            d_clear=0;
        end
    end
    WAITREAD: begin
        en_line = 0;
        tag_en=0;
        rready=0;
        d_clear=0;
        en_valid=0;
        if (arready) begin
            next_state=RESPREAD;
        end else begin
            next_state=WAITREAD;
        end
    end
    RESPREAD: begin
        en_line = 0;
        tag_en=0;
        rready=0;
        d_clear=0;
        en_valid=0;
        if (rvalid) begin
            next_state=IDLE;
            ready_mem=1;
            en_line = 1;
            tag_en=1;
            en_valid=1;
        end else begin
            next_state=RESPREAD;
        end
    end
    default: next_state=IDLE;
    endcase
end
endmodule


        
