module cache_controller (

    input logic       clk,
    input logic       reset,

	// cache Datapath -> cache controller
    input logic       cache_hit,
    input logic       cache_miss,
    input logic       dirty_bit,
    input logic       flush_done,
    
    // cpu -> cache controller
    input logic       cpu_valid,
    input logic [1:0] cpu_request,
    
    // axi controller -> cache controller
    input logic       axi_ready,

	// cache controller -> axi controller
    output logic      read_req,
    output logic      write_req,
    
    // cache controller -> cache datapath 
    output logic      change_dirty_bit,
    output logic      write_from_cpu,
    output logic      flush_en,
    output logic      flush_count_en,
    output logic      cache_ready,
    output logic      write_from_main_mem

);

typedef enum logic [2:0] {
    IDLE            = 3'b000,
    PROCESS_REQUEST = 3'b001,
    ALLOCATE_MEMORY = 3'b010,
    WRITEBACK       = 3'b011,
    FLUSH           = 3'b100
} state_t;

state_t state, next_state;

logic read_en, write_en;
logic read_hit_en, write_hit_en;

assign read_en     = (cpu_request == 2'b00) ? 1 : 0;
assign write_en    = (cpu_request == 2'b01) ? 1 : 0;
assign cache_flush = (cpu_request == 2'b10) ? 1 : 0;
assign no_task     = (cpu_request == 2'b11) ? 1 : 0;

always_ff @(posedge clk or negedge reset) begin
    if(!reset) begin
        write_hit_en <= 1'b0;
        read_hit_en  <= 1'b0;
    end else if(read_en) begin
        write_hit_en <= 1'b0;
        read_hit_en  <= 1'b1;
    end else if(write_en) begin
        write_hit_en <= 1'b1;
        read_hit_en  <= 1'b0;
    end
end

always_ff @(posedge clk or negedge reset) begin
    if(!reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    case(state)
        IDLE: begin
            read_req            = 0;
            write_req           = 0;
            change_dirty_bit    = 0;
            write_from_cpu      = 0;
            flush_en            = 0;
            flush_count_en      = 0;
            cache_ready         = 1;
            write_from_main_mem = 0;

            if((read_en || write_en) && cpu_valid) begin
                next_state = PROCESS_REQUEST;
            end else if(!cpu_valid) begin
                next_state = IDLE;
            end else if(cache_flush) begin
                flush_count_en = 1'b1;
                flush_en       = 1'b1;
                next_state     = FLUSH;
            end
        end

        PROCESS_REQUEST: begin
            read_req            = 0;
            write_req           = 0;
            change_dirty_bit    = 0;
            write_from_cpu      = 0;
            flush_en            = 0;
            flush_count_en      = 0;
            cache_ready         = 0;
            write_from_main_mem = 0;

            if(cache_hit && read_hit_en) begin
                next_state      = IDLE;
            end else if(cache_hit && write_hit_en) begin
                write_from_cpu  = 1;
                next_state      = IDLE;
            end

            else if(cache_miss && !dirty_bit) begin
                read_req    = 1;
                next_state  = ALLOCATE_MEMORY;
            end else if(cache_miss && dirty_bit) begin
                write_req   = 1;
                next_state  = WRITEBACK;
            end else begin
                next_state  = PROCESS_REQUEST;
            end

        end

        ALLOCATE_MEMORY: begin
            read_req            = 1;
            write_req           = 0;
            change_dirty_bit    = 0;
            write_from_cpu      = 0;
            flush_en            = 0;
            flush_count_en      = 0;
            cache_ready         = 0;
            write_from_main_mem = 0;

            if (axi_ready) begin
                change_dirty_bit    = 1;
                write_from_main_mem = 1;
                next_state          = PROCESS_REQUEST;
            end
            else if(!axi_ready) begin
                read_req   = 1;
                next_state = ALLOCATE_MEMORY;
            end
        end

        WRITEBACK: begin
            read_req            = 0;
            write_req           = 0;
            change_dirty_bit    = 0;
            write_from_cpu      = 0;
            flush_count_en      = 0;
            cache_ready         = 0;
            write_from_main_mem = 0;

            if(!axi_ready && flush_en) begin
                flush_en   = 1;
                next_state = WRITEBACK; 
            end 
            else if(axi_ready && !flush_en) begin
                read_req    = 1;
                next_state = ALLOCATE_MEMORY;
            end 
            else if(axi_ready && flush_en) begin
                flush_count_en   = 1;
                change_dirty_bit = 1;
                next_state       = FLUSH;
            end
            else if(!axi_ready) begin
                next_state = WRITEBACK;
            end
        end

        FLUSH: begin
            read_req            = 0;
            write_req           = 0;
            change_dirty_bit    = 0;
            write_from_cpu      = 0;
            flush_en            = 1;
            flush_count_en      = 0;
            cache_ready         = 0;
            write_from_main_mem = 0;

            if(flush_done) begin
                cache_ready = 1;
                flush_en    = 0;
                next_state  = IDLE;
            end else if(!flush_done && !dirty_bit) begin
                flush_count_en = 1;
                next_state     = FLUSH;

            end else if(!flush_done && dirty_bit) begin
                write_req  = 1;
                flush_count_en = 0;
                next_state = WRITEBACK;
            end
        end
    endcase
end

endmodule