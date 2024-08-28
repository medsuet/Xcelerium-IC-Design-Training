module cache_controller(
    input logic clk,
    input logic rst,
    input logic cpu_request,
    input logic src_valid,
    input logic req_type,
    input logic cache_hit,
    input logic dirty,
    input logic axi_ack,
    input logic flush,
    input logic flush_done,
    input logic flush_req,
    //output logic
    output logic src_ready,
    output logic [1:0] dirty_sel,
    output logic [1:0] valid_sel,
    output logic rd_en,
    output logic wr_en,
    output logic mem_wr_req,
    output logic index_sel,
    output logic mem_rd_req,
    output logic data_sel,
    output logic count_en,        //count enable signal
    output logic count_clear,      //count clear signa
    output logic flush_sel,
    output logic valid_clear
);

    //parameter IDLE            = 3'b000;      
    //parameter PROCESS_REQ     = 3'b001;
    //parameter CACHE_ALLOCATE  = 3'b010;
    //parameter WRITEBACK       = 3'b011;
    //parameter FLUSH_STATE     = 3'b100;   
    //logic [2:0] n_state;
    //logic [2:0] c_state;

    typedef enum logic [2:0]{
        IDLE,
        PROCESS_REQ,
        CACHE_ALLOCATE,
        WRITEBACK,
        FLUSH_STATE
    }cache_state;

    cache_state c_state, n_state;

    always_ff @(posedge clk or negedge rst) begin
        if(!rst)
            c_state <= #1 IDLE;
        else
            c_state <= #1 n_state;
    end

    // State transition logic
    always_comb begin
        case(c_state)
            IDLE: begin
                if (cpu_request &  src_valid & ~flush)
                    begin
                        n_state = PROCESS_REQ;
                    end
                else if(flush_req & src_valid)
                    begin
                        n_state = FLUSH_STATE;
                    end
                else
                    begin
                        n_state = IDLE;
                    end
            end
            //S1
            PROCESS_REQ : begin
                if (cache_hit & req_type)
                    begin
                        n_state = IDLE;
                    end
                else if(cache_hit & ~req_type)
                    begin
                        n_state = IDLE;
                    end
                else if (~cache_hit & ~dirty)
                    begin
                        n_state = CACHE_ALLOCATE;
                    end
                else if(~cache_hit & dirty)
                    begin
                        n_state = WRITEBACK;
                    end
                else
                    begin
                        n_state = PROCESS_REQ;
                    end
            end
            //S2
            CACHE_ALLOCATE : begin
                if(axi_ack)
                    begin
                        n_state = PROCESS_REQ;
                    end
                else
                    begin
                        n_state = CACHE_ALLOCATE;
                    end
            end
            //S3
            WRITEBACK : begin
                if (axi_ack & ~flush)
                    begin
                        n_state = CACHE_ALLOCATE;
                    end
                else if (axi_ack & flush)
                    begin
                        n_state = FLUSH_STATE;
                    end
                else
                    begin
                        n_state = WRITEBACK;
                    end
            end
            //S4
            FLUSH_STATE : begin
                if(dirty & ~flush_done)
                    begin
                        n_state = WRITEBACK;
                    end
                else if(~dirty & ~flush_done)
                    begin
                        n_state = FLUSH_STATE;
                    end
                else if(flush_done)
                    begin
                        n_state = IDLE;
                    end
            end
        endcase
    end

    //output logic
    always_comb
    begin
        case(c_state)
            IDLE : begin
                src_ready = 1'b1;
                if(flush_req & src_valid)
                begin
                    count_clear = 1'b1;
                    index_sel   = 1'b1;
                    flush_sel   = 1'b1;
                    valid_clear = 1;
                end
                else
                begin
                    count_clear = 1'b0;
                    index_sel   = 1'b0;
                    flush_sel   = 1'b0;
                    valid_clear = 0;
                end
                //src_ready       = 0;
                dirty_sel       = 0;
                valid_sel       = 0;
                rd_en           = 0;
                wr_en           = 0;
                mem_wr_req      = 0;
                //index_sel       = 0;
                mem_rd_req      = 0;
                data_sel        = 0;
                count_en        = 0;
                //count_clear     = 0;
                //flush_sel    = 0;
            end
            //S1
            PROCESS_REQ : begin
                if (cache_hit & req_type)
                    begin
                        dirty_sel   = 2'b10;
                        valid_sel   = 2'b10;
                        wr_en       = 1'b1;
                        rd_en       = 0;
                        mem_rd_req  = 0;
                        mem_wr_req  = 0;
                    end
                else if(cache_hit & ~req_type)
                    begin
                        rd_en       = 1'b1;
                        dirty_sel   = 0;
                        valid_sel   = 0;
                        wr_en       = 0;
                        mem_rd_req  = 0;
                        mem_wr_req  = 0;
                    end
                else if (~cache_hit & ~dirty)
                    begin
                        mem_rd_req = 1'b1;
                        dirty_sel   = 0;
                        valid_sel   = 0;
                        wr_en       = 0;
                        rd_en       = 0;
                        mem_wr_req  = 0;
                    end
                else if(~cache_hit & dirty)
                    begin
                        mem_wr_req  = 1'b1;
                        wr_en       = 0;
                        dirty_sel   = 0;
                        valid_sel   = 0;
                        rd_en       = 0;
                        mem_rd_req  = 0;
                    end
                src_ready       = 0;
                //dirty_sel       = 0;
                //valid_sel       = 0;
                //rd_en           = 0;
                //wr_en           = 0;
                //mem_wr_req      = 0;
                index_sel       = 0;
                //mem_rd_req      = 0;
                data_sel        = 0;
                count_en        = 0;
                count_clear     = 0;
                flush_sel    = 0;
                valid_clear     = 0;
            end
            //S2
            CACHE_ALLOCATE : begin
                if(axi_ack)
                begin
                    valid_sel   = 2'b10;
                    data_sel    = 1'b1;
                    wr_en       = 1'b1;
                    mem_rd_req  = 0;
                end
                else
                begin
                    mem_rd_req  = 1'b1;
                    valid_sel   = 0;
                    data_sel    = 0;
                    wr_en       = 0;
                end
                src_ready       = 0;
                dirty_sel       = 0;
                //valid_sel       = 0;
                rd_en           = 0;
                //wr_en           = 0;
                mem_wr_req      = 0;
                index_sel       = 0;
                //mem_rd_req      = 0;
                //data_sel        = 0;
                count_en        = 0;
                count_clear     = 0;
                flush_sel    = 0;
                valid_clear     = 0;
            end
            //S3
            WRITEBACK : begin
                if (axi_ack & ~flush)
                begin
                    mem_rd_req  = 1'b1;
                    mem_wr_req  = 0;
                    dirty_sel   = 0;
                    flush_sel   = 1'b0;
                    index_sel   = 0;
                    rd_en       = 0;
                end
                else if (axi_ack & flush)
                begin
                    dirty_sel   = 2'b01;
                    index_sel   = 1'b1;
                    mem_rd_req  = 0;
                    flush_sel   = 1'b1;
                    mem_wr_req  = 0;
                    rd_en       = 0;
                end
                else if(~axi_ack & ~flush)
                begin
                    mem_wr_req  = 1'b1;
                    rd_en       = 1'b1;
                    dirty_sel   = 0;
                    flush_sel   = 1'b0;
                    index_sel   = 0;
                    mem_rd_req  = 0;
                end
                else if(~axi_ack & flush)
                begin
                    mem_wr_req  = 1'b1;
                    rd_en       = 1'b1;
                    index_sel   = 1'b1;
                    flush_sel   = 1'b1;
                    dirty_sel   = 0;
                    mem_rd_req  = 0;
                end
                //else
                //begin
                //    //n_state = IDLE;
                //    
                //end
                src_ready       = 0;
                //dirty_sel       = 0;
                valid_sel       = 0;
                //rd_en           = 0;
                wr_en           = 0;
                //mem_wr_req      = 0;
                //index_sel       = 0;
                //mem_rd_req      = 0;
                data_sel        = 0;
                count_en        = 0;
                count_clear     = 0;
                //flush_sel    = 0;
                valid_clear     = 0;
            end
            //S4
            FLUSH_STATE : begin
                if(dirty & ~flush_done)
                begin
                    mem_wr_req      = 1'b1;
                    index_sel       = 1'b1;
                    flush_sel       = 1;
                    count_en        = 0;
                end
                else if(~dirty & ~flush_done)
                begin
                    count_en        = 1'b1;
                    index_sel       = 1'b1;
                    mem_wr_req      = 0;
                    flush_sel       = 1;
                end
                else if(flush_done)
                begin
                    flush_sel       = 0;
                    count_en        = 0;
                    index_sel       = 0;
                    mem_wr_req      = 0;
                end
                src_ready       = 0;
                dirty_sel       = 0;
                valid_sel       = 0;
                rd_en           = 0;
                wr_en           = 0;
                //mem_wr_req      = 0;
                //index_sel       = 0;
                mem_rd_req      = 0;
                data_sel        = 0;
                //count_en        = 0;
                count_clear     = 0;
                //flush_sel    = 0;
                valid_clear     = 0;
            end
        endcase
    end
endmodule




        
                
                
                
                
                