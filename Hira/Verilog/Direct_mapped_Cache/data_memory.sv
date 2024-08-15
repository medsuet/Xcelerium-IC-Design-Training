
module data_path(
    input  logic         clk,
    input  logic         rst,
    input  logic         enable_read,
    input  logic         enable_write,
    input  logic         mem_read,
    input  logic         mem_write,
    input  logic  [31:0] address,
    input  logic  [31:0] input_data,         
    input  logic         cpu_request_write,
    input  logic         cpu_request_read,
    
    output logic         cache_flush,
    output logic  [31:0] data,       
    output logic         dirty_bit,
    output logic         main_memory_ack,
    output logic         flush,
    output logic         cache_hit,
    output logic         cache_miss,
    output logic         flush_done
);

    logic [31:0] cache_data_array [3:0];
    logic [21:0] cache_tag_array [3:0];
    logic [1:0]  valid_dirty_bit_array [3:0];


    logic [31:0] data_mem [3:0];

    logic [31:0] cache_read_data;
    logic [31:0] cache_write_data;

    logic [21:0] tag;
    logic [1:0]  index; // Adjusted to match array size
    logic [1:0]  offset;

    assign tag    = address[31:10];
    assign index  = address[9:8]; // Adjusted to match array size
    assign offset = address[1:0];


always_ff @(posedge clk or posedge rst) begin 
        if (rst) begin
            for (int i = 0; i < 4; i++) begin
                cache_data_array[i] <= 0;
                data_mem[i]=1;
                cache_tag_array[i] <= 0;
                valid_dirty_bit_array[i][0] <= 0;
                valid_dirty_bit_array[i][1] <= 0;
            end
            cache_flush <= 0;
            data <= 0;
            dirty_bit <= 0;
            main_memory_ack <= 0;
            flush <= 0;
            cache_hit <= 0;
            cache_miss <= 0;
            flush_done <= 0;
        end else begin
                if (enable_read) begin
                        dirty_bit <= valid_dirty_bit_array[index][1];
                        cache_hit  <= (cache_tag_array[index] == tag) && (valid_dirty_bit_array[index][0] == 1);
                        cache_miss = ~cache_hit;
                end
                else if (main_memory_ack && !flush) begin
                        cache_hit <= 1;
                        main_memory_ack <= 0;
                        cache_miss<=0;
                        data <= cache_data_array[index];
                end else if (mem_read) begin
                        //read from memory
                        cache_data_array[index] <= data_mem[index];  
                        valid_dirty_bit_array[index][0] <= 1;                   //valid_bit
                        cache_tag_array[index] <= tag;
                        cache_hit<=1;
                        cache_miss<=0;
                        dirty_bit <= 0;
                        main_memory_ack <= 1;
                end else if (mem_write) begin
                    //write to the memory
                        data_mem[index] <= input_data;
                        main_memory_ack <= 1;
                        valid_dirty_bit_array[index][1] <= 0;
                end else if (cache_hit) begin
                    data <= cache_data_array[index];
                end else begin
                    cache_flush <= 0;
                    data <= 0;
                    dirty_bit <= 0;
                    main_memory_ack <= 0;
                    flush <= 0;
                    cache_hit <= 0;
                    cache_miss <= 0;
                    flush_done <= 0;
                end 
            end
        end

endmodule





