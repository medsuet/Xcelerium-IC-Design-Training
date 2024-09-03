module axi4_controller (
    input  logic clk,
    input  logic reset,
    input  logic start_write,
    input  logic start_read,
    input  logic aw_ready,
    input  logic w_ready,
    input  logic b_valid,
    input  logic ar_ready,
    input  logic r_valid,
    output logic aw_valid,
    output logic w_valid,
    output logic b_ready,
    output logic ar_valid,
    output logic r_ready,
    output logic axi_ack
);

typedef enum logic [2:0] { 
    IDLE  = 3'b000,
    WADDR = 3'b001,
    WDATA = 3'b010,
    BRESP = 3'b011,
    RADDR = 3'b100,
    RDATA = 3'b101
 } state_type;

state_type current_state , next_state;

always_ff @( posedge clk or negedge reset ) begin
    if (!reset) begin
        current_state <= IDLE;
    end
    else begin
        current_state <= next_state;
    end
end

always_comb begin 
    case (current_state)
        IDLE: begin
            if (!start_read && !start_write) begin
                next_state = IDLE;
            end
            else if (start_read && !ar_ready) begin
                next_state = RADDR;
            end
            else if (start_read && ar_ready) begin
                next_state = RDATA;
            end
            else if (start_write && !aw_ready) begin
                next_state = WADDR;
            end
            else if (start_write && aw_ready) begin
                next_state = WDATA;
            end
            else begin
                next_state = IDLE;
            end
        end
        WADDR: begin
            if(!aw_ready) begin
                next_state = WADDR;
            end
            else begin
                next_state = WDATA;
            end
        end
        WDATA: begin
            if (!w_ready) begin
                next_state = WDATA;
            end
            else begin
                next_state = BRESP;
            end
        end
        BRESP: begin
            if (!b_valid) begin
                next_state = BRESP;
            end
            else begin
                next_state = IDLE;
            end
        end
        RADDR: begin
            if(!ar_ready) begin
                next_state = RADDR;
            end
            else begin
                next_state = RDATA;
            end
        end
        RDATA: begin
            if (!r_valid) begin
                next_state = RDATA;
            end
            else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// output logic

always_comb begin 
    case (current_state)
        IDLE: begin
            if (!start_read && !start_write) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
            else if (start_read && !ar_ready) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b1;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
            else if (start_read && ar_ready) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b1;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
            else if (start_write && !aw_ready) begin
                aw_valid  = 1'b1;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
            else if (start_write && aw_ready) begin
                aw_valid  = 1'b1;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
            else begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
        end
        WADDR: begin
            if(!aw_ready) begin
                aw_valid  = 1'b1;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
            else begin
                aw_valid  = 1'b1;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
        end
        WDATA: begin
            if (!w_ready) begin
                aw_valid  = 1'b1;
                w_valid   = 1'b1;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
            else begin
                aw_valid  = 1'b0;
                w_valid   = 1'b1;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
        end
        BRESP: begin
            if (!b_valid) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b1;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
            else if(b_valid) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b1;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b1;
            end
        end
        RADDR: begin
            if(!ar_ready) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b1;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
            else begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b1;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
            end
        end
        RDATA: begin
            if (!r_valid) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b1;
                axi_ack = 1'b0;
            end
            else begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b1;
                axi_ack = 1'b1;
            end
        end
        default: begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ack = 1'b0;
        end 
    endcase
end

endmodule
