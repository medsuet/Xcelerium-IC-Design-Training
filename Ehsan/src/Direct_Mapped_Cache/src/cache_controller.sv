module cache_controller (

    input    logic       clk,
    input    logic       rst,

	// Interface Between Cache Controller And CPU
    input    logic       cpu_valid,
    input    logic [1:0] cpu_req,
    output   logic       cache_ready,

	// Interface Between Cache Datapath And Cache Controller
    input    logic       cache_hit,
    input    logic       dirty_bit,
    input    logic       flush_done,
    output   logic       change_dirty_bit,
    output   logic       write_from_cpu,
    output   logic       flush_en,
    output   logic       flush_counter_en,
    output   logic       write_from_main_mem,

	// Interface Between Cache Controller And Axi Controller
    input    logic       axi_ack,
    output   logic       read_req,
    output   logic       write_req
);

// State Machine
parameter IDLE            = 3'b000;
parameter PROCESS_REQUEST = 3'b001;
parameter ALLOCATE_MEMORY = 3'b010;
parameter WRITEBACK       = 3'b011;
parameter FLUSH           = 3'b100;

logic [2:0] current_state, next_state;
logic [1:0] request;

always_ff @(posedge clk or negedge rst) begin
    if(!rst) begin
        current_state <= IDLE;
        request <= 0;

    end else begin
        current_state <= next_state;
        if (cache_ready) begin
            request <= cpu_req;
        end
        else if (!cache_ready) begin
            request <= request;
        end
    end
end

always_comb begin
    case(current_state)
        IDLE: begin
            read_req            = 0;
            write_req           = 0;
            change_dirty_bit    = 0;
            write_from_cpu      = 0;
            flush_en            = 0;
            flush_counter_en    = 0;
            cache_ready         = 1;
            write_from_main_mem = 0;

            if(!cpu_valid) begin
                next_state = IDLE;
            end 
            else if(cpu_req == 2'b10) begin
                // flush_counter_en = 1;
                flush_en       = 1;
                next_state     = FLUSH;
            end
            else begin
                next_state = PROCESS_REQUEST;
            end
        end 

        PROCESS_REQUEST: begin
            read_req            = 0;
            write_req           = 0;
            change_dirty_bit    = 0;
            write_from_cpu      = 0;
            flush_en            = 0;
            flush_counter_en    = 0;
            cache_ready         = 0;
            write_from_main_mem = 0;

            if(cache_hit && request == 2'b00) begin
                next_state      = IDLE;
            end 
            else if(cache_hit && request == 2'b01) begin
                write_from_cpu = 1;
                next_state     = IDLE;
            end
            else if(!cache_hit && !dirty_bit) begin
                read_req   = 1;
                next_state = ALLOCATE_MEMORY;
            end 
            else if(!cache_hit && dirty_bit) begin
                write_req  = 1;
                next_state = WRITEBACK;
            end 
            else begin
                next_state  = PROCESS_REQUEST;
            end
        end

        ALLOCATE_MEMORY: begin
            read_req            = 1;
            write_req           = 0;
            change_dirty_bit    = 0;
            write_from_cpu      = 0;
            flush_en            = 0;
            flush_counter_en    = 0;
            cache_ready         = 0;
            write_from_main_mem = 0;

            if (axi_ack) begin
                write_from_main_mem = 1;
                next_state          = PROCESS_REQUEST;
            end
            else if(!axi_ack) begin
                read_req   = 1;
                next_state = ALLOCATE_MEMORY;
            end
        end

        WRITEBACK: begin
            read_req            = 0;
            write_req           = 0;
            change_dirty_bit    = 0;
            write_from_cpu      = 0;
            flush_counter_en    = 0;
            cache_ready         = 0;
            write_from_main_mem = 0;

            if(!axi_ack && flush_en) begin
                flush_en   = 1;
                next_state = WRITEBACK; 
            end 
            else if(axi_ack && !flush_en) begin
                read_req   = 1;
                next_state = ALLOCATE_MEMORY;
            end 
            else if(axi_ack && flush_en) begin
                flush_counter_en   = 1;
                change_dirty_bit = 1;
                next_state       = FLUSH;
            end
            else if(!axi_ack) begin
                next_state = WRITEBACK;
            end
        end

        FLUSH: begin
            read_req            = 0;
            write_req           = 0;
            change_dirty_bit    = 0;
            write_from_cpu      = 0;
            flush_en            = 1;
            flush_counter_en    = 0;
            cache_ready         = 0;
            write_from_main_mem = 0;

            if(flush_done) begin
                cache_ready = 1;
                flush_en    = 0;
                next_state  = IDLE;
            end 
            else if(!flush_done && !dirty_bit) begin
                flush_counter_en = 1;
                next_state       = FLUSH;

            end 
            else if(!flush_done && dirty_bit) begin
                write_req        = 1;
                flush_counter_en = 0;
                next_state       = WRITEBACK;
            end
        end
    endcase
end

endmodule