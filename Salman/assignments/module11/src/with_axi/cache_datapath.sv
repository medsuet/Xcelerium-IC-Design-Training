module cache_datapath(
    input  logic            clk,
    input  logic            reset,
    // Processor Pinout
    input  logic            flush_req,
    input  logic [31:0]     cpu_addr,
    input  logic [31:0]     cpu_wdata,
    output logic [31:0]     cpu_rdata,
    // Cache Controller Pinout
    output logic            flush_done,
    output logic            flush,
    output logic            dirty,
    output logic            cache_hit,
    input  logic            index_sel,
    input  logic [1:0]      dirty_sel,
    input  logic [1:0]      valid_sel,
    input  logic            data_sel,
    input  logic            rd_en,
    input  logic            wr_en,
    input  logic            count_en,
    input  logic            count_clear,
    input  logic            reg_flush_en,
    input  logic            valid_clear,
    // Memory Pinout
    output logic [31:0]     mem_araddr,         // Address Read
    input  logic [31:0]     mem_rdata,          // Read Data
    output logic [31:0]     mem_awaddr,         // Address Write
    output logic [31:0]     mem_wdata           // Write Data
);
    logic [10:0] count;                         // Flush Counter
    logic [10:0] count_sum;                     // Plus 1 adder at counter input
    logic [10:0] mux_counter_out;
    
    logic [31:0] cache_mem [1023:0];            // 4 KB Cache Memory - 4B Cache line - 1024 Indexes
    logic [31:0] cache_wdata;
    //logic [31:0] cache_addr;
    logic [31:0] cache_rdata;
    logic [19:0] tag_mem [1023:0];              // Tag Memory - 1024 Indexes - 20 bit tag

    logic [1023:0] reg_valid;                   // Valid Bit Register
    logic mux_valid_out;                        // Input to register
    logic [1023:0] reg_dirty;                   // Dirty Bit Register
    logic mux_dirty_out;                        // Input to register

    logic [19:0]    tag;
    logic [9:0]     index;
    logic [1:0]     offset;
    logic valid;
    //logic dirty;

    // logic [127:0] data_mem [2*28:0];       // 4 GB Data Memory

    assign tag      = cpu_addr[31:12];          // 20 bit tag
    assign offset   = cpu_addr[1:0];            // 2 bit offset
    assign valid    = reg_valid[index];
    assign dirty    = reg_dirty[index];

    assign mem_araddr = {tag,index,2'b0};
    assign mem_awaddr = {tag,index,2'b0};
    assign mem_wdata  = cache_rdata;

    assign cpu_rdata  = cache_rdata;

    assign cache_hit  = ((valid == 1) && (tag == tag_mem[index]));
    assign flush_done = (count == 1024);


    // Reset logic
    always_ff @(posedge clk or negedge reset)
    begin
        if (!reset)
            begin
                reg_valid <= #1 0;
                reg_dirty <= #1 0;
            end
        else
            begin
                if (valid_clear)
                    reg_valid   <= #1 0;
                else
                    reg_valid[index] <= #1 mux_valid_out;
                reg_dirty[index] <= #1 mux_dirty_out;
            end
    end

    // Mux before counter
    always_comb 
    begin
        count_sum = count + 1;
        if (count_clear)
            mux_counter_out = 0;
        else
            mux_counter_out = count_sum;
    end

    // Counter logic
    always_ff @(posedge clk or negedge reset)
    begin
        if (!reset)
            begin
                count <= #1 0;
            end
        else
            begin
                if (count_en)
                    count <= #1 mux_counter_out;
            end
    end

    // Flush register logic
    always_ff @(posedge clk or negedge reset)
    begin
        if (!reset)
            flush <= #1 0;
        else
            begin
                if (reg_flush_en)
                    flush <= #1 flush_req;
                else
                    flush <= flush;
            end
    end

    // Index selection logic
    always_comb
    begin
        if (index_sel)
            index = count;                      // Flush counter
        else
            index = cpu_addr[11:2];             // 10 bit index
    end

    // Data selection logic
    always_comb
    begin
        if (data_sel)
            cache_wdata = mem_rdata;            // Data from memory
        else
            cache_wdata = cpu_wdata;            // Data from instruction
    end

    // Valid selection logic - Mux beforr reg_valid
    always_comb
    begin
        case(valid_sel)
            2'b01:  mux_valid_out = 0;                  // Clear
            2'b10:  mux_valid_out = 1;                  // Set
            default:mux_valid_out = reg_valid[index];   // Retain
        endcase
    end

    // Dirty selection logic - Mux before reg_dirty
    always_comb
    begin
        case(dirty_sel)
            2'b01:  mux_dirty_out = 0;                  // Clear
            2'b10:  mux_dirty_out = 1;                  // Set
            default:mux_dirty_out = reg_dirty[index];   // Retain
        endcase
    end

    // Read data from cache - Asynchronous
    always_comb
    begin
        if (rd_en)
        begin
            cache_rdata = cache_mem[index];
        end
        else
            cache_rdata = 0;
    end

    // Write data to cache - Synchronous
    always_ff @(negedge clk)
    begin
        if (wr_en)
        begin
            cache_mem[index] = cache_wdata;
            tag_mem[index]   = tag;
        end
    end

endmodule