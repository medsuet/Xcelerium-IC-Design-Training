`include "defs.svh"
module cache_init(
    input logic clk,
    input logic rst,
    input logic [6:0] opcode,
    input logic [31:0] addr,
    output logic cpu_request,
    output logic cache_hit,
    output logic rd_req,
    output logic wr_req,
    input logic [31:0] wr_data,
    output logic [31:0] r_data,
    output logic cache_miss,
    output logic valid_ff,
    output logic dirty_ff,
    input logic en,
    input logic [127:0] r_mem_data,
    output logic [127:0] wr_mem_data,
    input logic flushing,
    output logic flush_done,
    input logic bvalid,
    output logic [31:0] addr_mem,
    input logic arvalid,
    input logic wvalid, awvalid,
    input logic rd_dcache,
    input logic init,
    input logic wr_dcache,
    input logic d_clear, 
    input logic en_line, 
    input logic tag_en,
    input logic en_valid
);

`define CACHE_BLOCKS 256
logic [19:0] tag [`CACHE_BLOCKS-1:0]='{default: 0};
logic [19:0] tag_addr, tag_addr_ff;
logic [7:0] index, index_ff;
logic [1:0] offset, offset_ff;
logic [31:0] r_data_mux_out;
logic [`CACHE_BLOCKS-1:0] valid_reg;
logic [`CACHE_BLOCKS-1:0] dirty_reg;
logic [`CACHE_LINE_SIZE-1:0] cache_line [`CACHE_BLOCKS-1:0]= '{default: 0};
logic clear_valid;
logic i_set, d_clear_flush;
logic en_for_flush;
int i = 0;

assign tag_addr=addr[31:12];
assign offset=addr[3:2];


always_comb begin
    cpu_request = 0;
    cache_hit = 0;
    cache_miss = 0;
    rd_req = 0;
    wr_req = 0;
    if ((opcode == `OPCODE_L) || (opcode == `OPCODE_S)) begin
        cpu_request = 1;
        rd_req = (opcode == `OPCODE_L);
        wr_req = (opcode == `OPCODE_S);
        if (init) begin
            cache_miss = 0;
            cache_hit=0;
        end else if ((valid_ff == 1) && (tag[index_ff] == tag_addr_ff)) begin
            cache_hit = 1;
            cache_miss=0;
            if (rd_dcache) begin
                r_data = r_data_mux_out;
            end else begin
                r_data = 32'hxxxxxxxx;
            end
        end else begin
            cache_miss = 1;
            cache_hit=0;  
        end
    end
end

always_comb begin
    if (arvalid) begin
        addr_mem = {tag_addr_ff, index_ff, 4'b0};
    end
    else if (awvalid) begin
        addr_mem = {tag[index_ff], index_ff, 4'b0};
    end
end

always_comb begin
    case(offset_ff)
        2'b00: r_data_mux_out = (rd_dcache) ? cache_line[index_ff][31:0] : 32'b0;
        2'b01: r_data_mux_out = (rd_dcache) ? cache_line[index_ff][63:32] : 32'b0;
        2'b10: r_data_mux_out = (rd_dcache) ? cache_line[index_ff][95:64] : 32'b0;
        2'b11: r_data_mux_out = (rd_dcache) ? cache_line[index_ff][127:96] : 32'b0;
        default: r_data_mux_out = 32'b0;
    endcase
end

always_ff @(posedge clk,negedge rst) begin
    if (~rst) begin
        offset_ff <= 0;
        index_ff <= 0;
        tag_addr_ff <= 0;
        valid_ff <= 0;
        dirty_ff <= 0;
    end else if (en) begin
        offset_ff <= offset;
        index_ff <= index;
        tag_addr_ff <= tag_addr;
        valid_ff <= valid_reg[index];
        dirty_ff <= dirty_reg[index];
    end else if (en_for_flush) begin
        offset_ff <= 0;
        index_ff <= index;
        tag_addr_ff <= tag[index];
        valid_ff <= valid_reg[index];
        dirty_ff <= dirty_reg[index];
    end
    else if (en_valid) begin
        valid_ff <= 1;
        valid_reg[index_ff] <= 1;
    end

end

always_ff @(posedge clk,negedge clk) begin
    if (~rst) begin
        cache_line[index_ff] <= 0;
    end else if (en_line) begin
        cache_line[index_ff] <= r_mem_data;
    end else if (wr_dcache) begin
        case (offset_ff)
            2'b00: cache_line[index_ff][31:0] <= wr_data;
            2'b01: cache_line[index_ff][63:32] <= wr_data;
            2'b10: cache_line[index_ff][95:64] <= wr_data;
            2'b11: cache_line[index_ff][127:96] <= wr_data;
        endcase
    end
end

always_ff @(posedge clk,negedge rst) begin
    if (~rst ) begin
        dirty_reg <= '{default: 0};
    end else if (d_clear|d_clear_flush) begin
        dirty_reg[index_ff] <= 0;
    end
    else if (wr_dcache) begin
        dirty_reg[index_ff] <= 1;
    end
end

always_ff @(posedge clk,negedge rst) begin
    if (~rst) begin
        tag[index_ff] <= 20'h00000;
    end else if(tag_en) begin
        tag[index_ff] <= tag_addr_ff;
    end

end

always_ff @(posedge clk,negedge rst) begin
    if (~rst) begin
        valid_reg <= '{default: 1};
        flush_done <= 0;
    end else if(clear_valid) begin
        valid_reg <= '{default: 0};
        flush_done <= 1;
    end
    else begin
        flush_done <= 0;
    end
end

always_ff @(posedge clk,negedge rst) begin
    if (~rst) begin
        i <= 0;
        d_clear_flush <= 0;
        en_for_flush <= 0;
        clear_valid <= 0;
    end else if (flushing) begin
        if (i < `CACHE_BLOCKS) begin
            if (dirty_reg[i] == 1) begin
                i_set <= 1;
                en_for_flush <= 1;
                if (bvalid == 1) begin
                    i <= i + 1;
                    en_for_flush <= 0;
                end
                d_clear_flush <= 1;
            end else begin
                i <= i + 1;
            end
        end else begin
            clear_valid <= 1;
            i <= 0;
            en_for_flush<=0;
            i_set <= 0;
            d_clear_flush <= 0;
        end
    end else begin
        clear_valid <= 0;
    end
end

always_comb begin
    if (i_set) begin
        index = i;
    end else begin
        index = addr[11:4];
    end
end
always_comb begin
    if (wvalid) begin
        wr_mem_data=cache_line[index_ff];
    end else begin
        wr_mem_data=0;
    end
end
endmodule