module controller #(
parameter ADDR_WIDTH = 32,
parameter BLOCK_SIZE = 128,
parameter WORD_SIZE = 32,
parameter TAG_SIZE = 18,
parameter NUM_LINES = 1024,
parameter INDEX_WIDTH = 10,
parameter BLOCK_OFFSET = 4
) (
    input logic clk,
    input logic rst,
    input logic hit,
    input logic dirty,
    input logic flush,
    input logic mem_ack,
    input logic flush_done,
    input logic cpu_valid,
    input logic cpu_wr_en,
    output logic cpu_ready,
    output logic mem_wr_en,
    output logic cache_read,
    output logic cache_write,
    output logic allocate_cache,
    output logic load_addr_en,
    output logic zero_dirty,
    output logic src_valid,
    output logic wr_bck_cache
);
    // State machine states
    typedef enum logic [1:0] {
        PROCESS_REQ,
        ALLOCATE_CACHE,
        WRITE_BACK,
        FLUSH 
    } state_t;

    state_t current_state, next_state;

    // FSM: Cache controller state machine
    always_ff @(posedge clk or negedge rst) begin
        if (!rst)
            current_state <= PROCESS_REQ;
        else
            current_state <= next_state;
    end

    always_comb begin
        // Default values
        mem_wr_en = 0;
        cache_read = 0;
        cache_write = 0;
        allocate_cache = 0;
        wr_bck_cache = 0;
        load_addr_en = 0;
        cpu_ready = 0;
        zero_dirty = 0;
        src_valid = 0;

        case (current_state)
            PROCESS_REQ: begin
                cpu_ready = 1;
                if (cpu_valid) begin
                    load_addr_en = 1;
                    src_valid = 0;
                    if (hit & !cpu_wr_en) begin
                        cache_read = 1;
                        next_state = PROCESS_REQ;
                    end else if (hit & cpu_wr_en) begin
                        cache_write = 1;
                        next_state = PROCESS_REQ;
                    end else if (flush) begin
                        next_state = FLUSH;
                    end else if (!hit & !dirty) begin
                        next_state = ALLOCATE_CACHE;
                    end else if (!hit & dirty) begin
                        wr_bck_cache = 1;
                        next_state = WRITE_BACK;
                    end else begin
                        next_state = PROCESS_REQ;
                    end
                end else begin
                    next_state = PROCESS_REQ;
                end
            end

            ALLOCATE_CACHE: begin
                allocate_cache = 1;
                if (flush) begin
                    next_state = FLUSH;
                end else if (!mem_ack & !flush) begin
                    src_valid = 1;
                    mem_wr_en = 0;
                    next_state = ALLOCATE_CACHE;
                end else if (mem_ack & !flush) begin
                    cpu_ready = 1;
                    next_state = PROCESS_REQ;
                end
            end


            WRITE_BACK: begin
                if (flush) begin
                    next_state = FLUSH;
                end else if (!mem_ack & !flush) begin
                    src_valid = 1;
                    mem_wr_en = 1;
                    wr_bck_cache = 1;
                    next_state = WRITE_BACK;
                end else if (mem_ack & !flush) begin
                    zero_dirty = 1;
                    load_addr_en = 1;
                    next_state = ALLOCATE_CACHE;
                end
            end

            FLUSH: begin
                mem_wr_en = 1;
                if (!flush_done) begin
                    next_state = FLUSH;
                end else begin
                    cpu_ready = 1;
                    next_state = PROCESS_REQ;
                end
            end
        endcase
    end
endmodule
