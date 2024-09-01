module datapath #(
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
    input logic cache_read,
    input logic cache_write,
    input logic allocate_cache,
    input logic wr_bck_cache,
    input logic load_addr_en,
    input logic flush,
    input logic mem_ack,
    input logic zero_dirty,
    input logic [ADDR_WIDTH-1:0] address,
    input logic [BLOCK_SIZE-1:0] read_data_mem, 
    input logic [WORD_SIZE-1:0] write_data_cpu,
    output logic [BLOCK_SIZE-1:0] modf_data_mem, 
    output logic [WORD_SIZE-1:0] read_data_cpu, 
    output logic [ADDR_WIDTH-1:0] memory_address,
    output logic hit,
    output logic flush_done,
    output logic dirty
);

    // Cache memory
    logic [TAG_SIZE-1:0] tag_array [NUM_LINES-1:0];   // Tag array
    logic [BLOCK_SIZE-1:0] data_array [NUM_LINES-1:0];// Data array (16 bytes per line)
    logic valid_array [NUM_LINES-1:0];                // Valid bit array
    logic dirty_array [NUM_LINES-1:0];                // Dirty bit array

    // Address decoding
    logic [INDEX_WIDTH-1:0] index;
    logic [TAG_SIZE-1:0] tag;
    logic [BLOCK_OFFSET-1:0] block_offset; // 16-byte block => 4-bit block offset

    assign index = address[13:4];   // 10-bit index
    assign tag = address[31:14];    // 18-bit tag
    assign block_offset = address[3:0]; // 4-bit block offset
    assign dirty = dirty_array[index];
//     assign valid = valid_array[index];

    // Cache hit detection
    assign hit = (valid_array[index] && (tag_array[index] == tag));

    // Cache read operation (asynchronous)
    always @(*) begin
        if (cache_read) begin
            case (block_offset[3:2]) 
                2'h0: read_data_cpu = data_array[index][31:0];
                2'h1: read_data_cpu = data_array[index][63:32];
                2'h2: read_data_cpu = data_array[index][95:64];
                2'h3: read_data_cpu = data_array[index][127:96];
                default: read_data_cpu = 0; 
            endcase
        end
        
        if (zero_dirty) begin
            dirty_array[index] = 0;
        end
    end

    // Cache write operation (synchronous)
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Reset cache
                flush_done <= 0;
            for (int i=0; i<NUM_LINES; i++) begin
                data_array[i] <= 0;
                tag_array[i] <= 0;
                valid_array[i] <= 1'b0;
                dirty_array[i] <= 1'b0;
            end
        end else begin
            flush_done <= 0;
            if (flush) begin // Flushing of cache
                for (int i=0; i<NUM_LINES; i++) begin
                    if (dirty_array[i]) begin
                        memory_address <= {tag_array[i], i[INDEX_WIDTH-1:0], block_offset};
                        modf_data_mem <= data_array[i];
                    end
                    data_array[i] <= 0;
                    valid_array[i] <= 0;
                    dirty_array[i] <= 0;
                end
                flush_done <= 1;
            end else if (cache_write) begin
                dirty_array[index] <= 1'b1;
                case (block_offset[3:2]) 
                    2'h0: data_array[index][31:0] <= write_data_cpu;
                    2'h1: data_array[index][63:32] <= write_data_cpu;
                    2'h2: data_array[index][95:64] <= write_data_cpu;
                    2'h3: data_array[index][127:96] <= write_data_cpu;
                    default: data_array[index] <= 0; 
                endcase
            end else if (allocate_cache) begin
                if (mem_ack) begin
                    data_array[index] <= read_data_mem;
                    tag_array[index] <= tag;
                    valid_array[index] <= 1'b1;
                end 
            end else if (wr_bck_cache) begin
                modf_data_mem <= data_array[index];
            end else if (load_addr_en) begin
                memory_address <= address;
            end
        end
    end
endmodule

