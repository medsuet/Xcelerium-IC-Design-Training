module cache_controller 
(
    input logic clk, 
    input logic rst ,
    input logic c_hit ,
    input logic c_rd ,
    input logic c_wr ,
    input logic c_flash ,
    input logic flash_dirty_bit ,
    input logic flash_done ,
    input logic dirty_bit ,
    input logic r_resp ,
    input logic b_resp ,

    output logic cache_hit ,
    output logic cache_miss ,
    output logic c_rd_en ,
    output logic c_wr_en ,
    output logic alo_wr_en ,
    output logic r_valid ,
    output logic w_valid ,
    output logic flash_start ,
    output logic flash_stop ,
    output logic c_ready 
);
    
logic [2:0] c_state,n_state;
parameter  IDLE     = 0;
parameter  PRO_REQ  = 1;
parameter  ALLOCATE = 2;
parameter  WR_BACK  = 3;
parameter  FLASHING  = 4;

always_ff @(posedge clk or negedge rst) 
begin
    if(!rst) c_state <= IDLE;  
    else     c_state <= n_state;  
end

//next state logic
always_comb begin
    case (c_state)
        IDLE: 
        begin
            if      (c_flash )    n_state = FLASHING; 
            else if (c_wr ^ c_rd) n_state = PRO_REQ;
            else                  n_state = IDLE;
        end

        PRO_REQ:
        begin
            if      (c_hit & c_wr & !dirty_bit) n_state = IDLE;
            else if (c_hit & c_rd)                n_state = IDLE;
            else if (c_hit & c_wr & dirty_bit)  n_state = WR_BACK;
            else if (!c_hit & dirty_bit)        n_state = WR_BACK;
            else if (!c_hit & !dirty_bit)       n_state = ALLOCATE;
            else                                n_state = PRO_REQ;
        end

        ALLOCATE: 
        begin
            if(r_resp)  n_state = PRO_REQ;
            else        n_state = ALLOCATE;
        end

        WR_BACK: 
        begin
            if     (b_resp &  flash_start) n_state = FLASHING;
            else if(b_resp & !flash_start) n_state = ALLOCATE;
            else                           n_state = WR_BACK;
        end

        FLASHING: 
        begin
            if      (flash_dirty_bit)   n_state = WR_BACK;
            else if (flash_done)        n_state = IDLE;
            else                        n_state = FLASHING;
        end
        
        default: 
        begin
            n_state = IDLE;
        end
    endcase
end

// output logic
always_comb begin
    case (c_state)
        IDLE: 
        begin
            r_valid = 1'b0;
            w_valid = 1'b0;
            c_ready = 1'b1;
            cache_hit = 1'b0;
            c_wr_en = 1'b0;
            c_rd_en = 1'b0;
            flash_start = 1'b0;
            flash_stop = 1'b0;
            if      (c_flash )    begin c_ready = '0; end
            else if (c_wr ^ c_rd) begin c_ready = '0; end
            else                  begin c_ready = 1'b1; end
        end

        PRO_REQ: 
        begin
            alo_wr_en = 1'b0;
            if(c_hit)
            begin
                if(c_wr & !dirty_bit)     begin cache_hit = 1'b1; c_wr_en = 1'b1; cache_miss= 1'b0;end
                else if(c_wr & dirty_bit) begin cache_miss= 1'b1; w_valid = 1'b1; cache_hit = 1'b0; end
                else                      begin cache_hit = 1'b1; c_rd_en = 1'b1;  cache_miss= 1'b0;end
            end
            else
            begin
                cache_hit = 1'b0;
                if(dirty_bit)   begin w_valid = 1'b1; cache_miss =1'b1; end
                else            begin r_valid = 1'b1; cache_miss =1'b1; end
            end
        end

        ALLOCATE: 
        begin
            r_valid = 1'b0;
            if(r_resp) alo_wr_en = 1'b1;
            else       alo_wr_en = 1'b0;
        end

        WR_BACK: 
        begin
            w_valid = 1'b0;
            if     (b_resp &  flash_start) begin flash_stop = 1'b0; end
            else if(b_resp & !flash_start) begin r_valid = 1'b1;end
            else                           begin r_valid = 1'b0;end
        end

        FLASHING: 
        begin
            flash_start = 1'b1;
            if(flash_dirty_bit) begin w_valid = 1'b1; flash_stop = 1'b1; end 
            else if(flash_done)      flash_start = 1'b0;
            else                w_valid = 1'b0;
        end
    endcase
end

endmodule