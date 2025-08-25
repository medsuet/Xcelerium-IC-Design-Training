module AXI_controller 
#(
    //parameters
) 
(   
    input logic clk,
    input logic rst,

    input logic w_req,
    input logic aw_ready,
    input logic w_ready,
    input logic b_valid,

    input logic r_req,
    input logic ar_ready,
    input logic r_valid,

    output logic aw_valid,
    output logic w_valid,
    output logic b_ready,
    
    output logic ar_valid,
    output logic r_ready,

    output logic ack
);

//AXI_controller  AXI_CON
//(   
//    .clk        (  ),
//    .rst        (  ),
//
//    .w_req      (  ),
//    .aw_ready   (  ),
//    .w_ready    (  ),
//    .b_valid    (  ),
//
//    .r_req      (  ),
//    .ar_ready   (  ),
//    .r_valid    (  ),
//
//    .aw_valid   (  ),
//    .w_valid    (  ),
//    .b_ready    (  ),
//
//    .ar_valid   (  ),
//    .r_ready    (  ),
//
//    .ack        (  )
//);
    

typedef enum logic[2:0] { 
    IDLE     = 0,
    READ_START  = 1,
    R_WAIT_DATA = 2,
    WRITE_START  = 3,
    W_WAIT_DATA  = 4,
    WRITE_DONE   = 5
} state_enum;

state_enum c_state,n_state;

always_ff @(posedge clk or negedge rst) 
begin
    if(!rst) c_state <= #1 IDLE;  
    else     c_state <= #1 n_state;  
end


//next state logic
always_comb begin
    case (c_state)
        IDLE: 
        begin
            if(w_req & !r_req)  n_state = WRITE_START;
            else if(r_req & !w_req)   n_state = READ_START;
            else             n_state = IDLE;
        end

        READ_START: 
        begin
            if(ar_ready)    n_state = R_WAIT_DATA;
            else            n_state = READ_START;
        end

        R_WAIT_DATA: 
        begin
            if(r_valid)     n_state = IDLE;
            else            n_state = R_WAIT_DATA;
        end

        WRITE_START: 
        begin
            if     (aw_ready & w_ready)      n_state = WRITE_DONE;
            else if(aw_ready & !w_ready)     n_state = W_WAIT_DATA;
            else                             n_state = WRITE_START;
        end

        W_WAIT_DATA: 
        begin
            if(w_ready)     n_state = WRITE_DONE;
            else            n_state = W_WAIT_DATA;
        end

        WRITE_DONE: 
        begin
            if(b_valid)     n_state = IDLE;
            else            n_state = WRITE_DONE;
        end
    endcase
end


//OUTPUT LOGIC
always_comb begin
    case (c_state)
        IDLE: 
        begin
            aw_valid = 1'b0;
            w_valid  = 1'b0;
            b_ready  = 1'b0;
            ar_valid = 1'b0;
            r_ready  = 1'b0;
            ack      = 1'b0;
        end

        READ_START: 
        begin
            ar_valid = 1'b1;
            r_ready  = 1'b1;
        end

        R_WAIT_DATA: 
        begin
            ar_valid = 1'b0;
            if(r_valid) begin ack = 1'b1;end
            else        begin ack = 1'b0;end
            r_ready = 1'b1;
        end

        WRITE_START: 
        begin
            aw_valid = 1'b1;
            w_valid  = 1'b1;
            b_ready  = 1'b1;
        end

        W_WAIT_DATA: 
        begin
            aw_valid = 1'b0;
            w_valid  = 1'b1;
            b_ready  = 1'b1;
        end

        WRITE_DONE: 
        begin
            aw_valid = 1'b0;
            w_valid  = 1'b0;
            if(b_valid) ack = 1'b1;
            else        ack = 1'b0;
        end
    endcase
end

endmodule