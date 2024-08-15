module Control_unit (
    input  logic     clk,
    input  logic     rst,
    input  logic     cpu_request,
    input  logic     cache_flush,
    input  logic     dirty_bit,
    input  logic     main_memory_ack,
    input  logic     flush,
    input  logic     cache_hit,
    input  logic     cache_miss,
    input  logic     flush_done,
    output logic     read_enable,
    output logic     write_enable,
    output logic     enable_flush,
    output logic     mem_read,
    output logic     mem_write
);

    typedef enum logic [3:0] { 
        IDLE,
        PROCESS_REQUEST,
        CACHE_ALLOCATE,
        WRITEBACK,
        FLUSH
    } state_t;

    state_t state, next_state;

    // Control signals based on state
    always_comb begin
        read_enable = 0;
        write_enable = 0;
        mem_read = 0;
        mem_write = 0;
        enable_flush = 0;

        case(state)
            IDLE: begin
                if(cpu_request) begin
                    read_enable = 1;
                    $display("read_enable");
                    next_state = PROCESS_REQUEST;
                end else if (cache_flush) begin
                    enable_flush = 1;
                    next_state = FLUSH;
                end else begin
                    next_state = IDLE;
                end
            end

            PROCESS_REQUEST: begin
                if(cache_hit) begin
                    next_state = IDLE;
                end else if (cache_miss && dirty_bit) begin
                    mem_write = 1;
                    next_state = WRITEBACK;
                end else if(cache_miss && !dirty_bit) begin
                    next_state = CACHE_ALLOCATE;
                end
            end

            CACHE_ALLOCATE: begin
                if(main_memory_ack) begin
                    next_state = PROCESS_REQUEST;
                end else begin
                    mem_read = 1;
                    next_state = CACHE_ALLOCATE;
                end
            end

            WRITEBACK: begin
                if(main_memory_ack && flush) begin
                    enable_flush = 1;
                    next_state = FLUSH;
                end else if (main_memory_ack && !flush) begin
                    mem_read = 1;
                    next_state = CACHE_ALLOCATE;
                end else begin
                    mem_write = 1;
                    next_state = WRITEBACK;
                end
            end

            FLUSH: begin
                if (flush_done) begin
                    next_state = IDLE;
                end else if (dirty_bit && !flush_done) begin
                    write_enable = 1;
                    mem_write = 1;
                    next_state = WRITEBACK;
                end else begin
                    next_state = FLUSH;
                end
            end
        endcase
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
endmodule




