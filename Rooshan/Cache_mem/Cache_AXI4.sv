`timescale 1ns / 1ps
module Controller#(parameter Tag_bits=17,parameter Index_bits=2,parameter IDLE=3'd0,parameter PROCESS_REQUEST=3'd1,parameter CACHE_ALLOCATE=3'd2,parameter WRITEBACK=3'd3,parameter FLUSH=3'd4)(
input logic clk,
input logic reset,
input logic CPU_Request,Valid_bit,Dirty_bit,Dirty_bit_Flush,Main_Mem_ack,
output logic Flush,
output logic Flush_Done,
input logic Cache_Flush,rd_en,wr_en,
input logic [Tag_bits-1:0]Tag_Address,Tag_Cache,
output logic Cache_hit,Cache_miss,
output logic Load_from_Memory,Save_to_Memory,flush_count_update_enable,
output logic [Index_bits-1:0]flush_count
);
    logic [2:0] c_state, n_state;
    //state register
    always_ff @ (posedge clk or negedge reset)
    begin
       //reset is active low
        if (!reset)begin
            c_state <= IDLE;
        end
        else begin
            c_state <= n_state;
        end
    end
    //next_state always block
    always_comb
    begin
    case (c_state)
        IDLE: begin if (CPU_Request) n_state = PROCESS_REQUEST;
            else if (Cache_Flush)n_state = FLUSH;
            else n_state = IDLE;end
        PROCESS_REQUEST: begin if (Cache_hit) n_state = IDLE;
            else if ((Cache_miss==1)&&(Dirty_bit==0))n_state = CACHE_ALLOCATE;
            else if ((Cache_miss==1)&&(Dirty_bit==1))n_state = WRITEBACK;end
        CACHE_ALLOCATE: begin if (Main_Mem_ack) n_state = PROCESS_REQUEST;
            else n_state = CACHE_ALLOCATE;end
        WRITEBACK: begin if ((Main_Mem_ack==1)&&(Flush==0)) n_state = CACHE_ALLOCATE;  //&&(Flush==0)///////////
            else if (!Main_Mem_ack)n_state = WRITEBACK;
            else if ((Main_Mem_ack==1)&&(Flush==1))n_state = FLUSH;end
        FLUSH: begin if (Flush_Done==1)n_state = IDLE;
            else if (Dirty_bit_Flush==0) n_state = FLUSH;
            else if ((Dirty_bit_Flush==1)&&(Flush_Done==0))n_state = WRITEBACK;
            end
        default: n_state = IDLE;
        endcase
    end
    //output always block
    always_comb
    begin
        case (c_state)
            IDLE: begin
                flush_count=0;
                Flush=0;
                flush_count_update_enable=0;
                Flush_Done=0;
                Cache_miss=0;
                Cache_hit=0;
                Load_from_Memory=0;
                Save_to_Memory=0;
            end
            PROCESS_REQUEST: begin
                if (((Tag_Address==Tag_Cache)&&(Valid_bit==1))||(Main_Mem_ack))begin
                    Cache_miss=0;
                    Cache_hit=1;
                end
                else begin
                    Cache_miss=1;
                    Cache_hit=0;
                end
            end
            CACHE_ALLOCATE:begin
                    Load_from_Memory=1;
                    Save_to_Memory=0;
            end
            WRITEBACK:begin
                Load_from_Memory=0;
                Save_to_Memory=1;
                if (Flush)begin
                    flush_count_update_enable=1;
                end
            end
            FLUSH:begin
                Flush=1;
                if (flush_count_update_enable)begin
                    if (flush_count==(2**Index_bits-1))begin
                        Flush_Done=1;
                    end
                    else begin
                        flush_count=flush_count+1;
                        flush_count_update_enable=0;
                    end
                end
                if (!Flush_Done)begin
                    if ((flush_count<2**Index_bits)&&(Dirty_bit==1))begin
//                        Load_from_Memory=0;
//                        Save_to_Memory=1;
                    end
                    else begin
                        Load_from_Memory=0;
                        Save_to_Memory=0;                        
                    end
                end
            end
            default:begin
            end
        endcase
    end
endmodule

module Main_Memory#(parameter Address_bits=32,parameter Index_bits=2,parameter Memory_size=32,parameter Data_bytes=16,parameter Addressability=8,parameter Offset_bits=16)(input logic clk,reset,
input logic [Address_bits-1:0]Address_modified,input logic [Data_bytes*8-1:0]Data_modified,
input logic cache_miss,dirty_bit,Flush,Flush_Done,
input logic [Address_bits-1:0]Address_required,
input logic Load_From_Memory,Save_to_Memory,
output logic Main_mem_ack,
output logic [Data_bytes*8-1:0]Data_required,
input logic aw_ready,w_ready,b_valid,ar_ready,r_valid,aw_valid,w_valid,b_ready,ar_valid,r_ready
);
    logic Main_mem_ack_saved,Main_mem_ack_loaded;
    logic [Addressability-1:0]Main_Memory[Memory_size-1:0];
    logic [Index_bits+Offset_bits-1:0]flush_count_with_offset_bits;
    assign Main_mem_ack=Main_mem_ack_saved|Main_mem_ack_loaded;
    always_comb begin
        Main_mem_ack_loaded=0;
        if (r_valid&&r_ready)begin
            for (int l=0;l<(2**Offset_bits);l++)begin
                Data_required[(l)*Addressability+:8]=Main_Memory[Address_required+l];
            end
            Main_mem_ack_loaded=1;
        end
    end
    always_ff @(posedge clk or negedge reset)begin
        if(!reset)begin
            for (int i=0;i<Memory_size;i++)begin
                Main_Memory[i]<=0;
                Main_mem_ack_saved<=0;
            end
        end
        else if (b_valid&&b_ready)begin
            if ((!Flush_Done))begin
                for (int k=0;k<(2**Offset_bits);k++)begin
                    Main_Memory[Address_modified+k]<=Data_modified[(k)*Addressability+:8];
                end
                Main_mem_ack_saved<=1;
            end
        end
        else begin
            Main_mem_ack_saved<=0;
        end
    end
endmodule

module Cache#(parameter Addressability=8, parameter C=200,parameter b=8,parameter Data_bytes=16,parameter Address_bits=32,parameter Offset_bits=$clog2(Data_bytes),parameter Index_bits=$clog2(C/b),parameter Tag_bits=32-Offset_bits-Index_bits,parameter Memory_size=32)(
input logic clk,reset,
input logic CPU_Request,
input logic [Address_bits-1:0]address,
input logic rd_en,wr_en,
input logic [Addressability-1:0]write_data,
output logic [Addressability-1:0]read_data,
input logic aw_ready,w_ready,b_valid,ar_ready,r_valid, // These values will be given from the test bench(actually these are outputs)
output logic aw_valid,w_valid,b_ready,ar_valid,r_ready,Main_Mem_ack,Main_Mem_ack1,
output logic Save_to_Memory,Load_from_Memory,
output logic Cache_hit,Cache_miss,
input logic Cache_Flush
);
    logic Valid_bit,Dirty_bit,Flush,Flush_Done,Dirty_bit_Flush;
    logic [Data_bytes*8-1:0]Main_Memory[Memory_size-1:0];
    // C=Number of bytes that the cache can store, For block size of b bytes, the cache has B = C/b blocks

    logic [Offset_bits-1:0]Offset_address;
    logic [Index_bits-1:0]Index_address;
    logic [Tag_bits-1:0]Tag_Address;
    logic [Tag_bits-1:0]Tag_Cache;
    logic [Data_bytes*8-1:0] Data_New,Data_prev;    
    logic [Address_bits-1:0] Address_prev;
    
    logic [Index_bits-1:0]flush_count;
    logic flush_count_update_enable;
    assign Offset_address=address[Offset_bits-1:0];
    assign Index_address=address[Index_bits-1+Offset_bits:Offset_bits];
    assign  Tag_Address=address[Tag_bits-1+Offset_bits+Index_bits:Offset_bits+Index_bits];

    axi_master_controller axi4(clk,reset,Save_to_Memory,Load_from_Memory,aw_ready,w_ready,b_valid,ar_ready,r_valid,aw_valid,w_valid,b_ready,ar_valid,r_ready,Main_Mem_ack1);

    Main_Memory#(.Address_bits(Address_bits),.Index_bits(Index_bits),.Memory_size(Memory_size),.Data_bytes(Data_bytes),.Addressability(Addressability),.Offset_bits(Offset_bits))MM(clk,reset,Address_prev,Data_prev,Cache_miss,Dirty_bit,Flush,Flush_Done,address,Load_from_Memory,Save_to_Memory,Main_Mem_ack,Data_New,aw_ready,w_ready,b_valid,ar_ready,r_valid,aw_valid,w_valid,b_ready,ar_valid,r_ready);

    Cache_Memory #(.Index_bits(Index_bits),.Tag_bits(Tag_bits),.Data_bytes(Data_bytes),.Offset_bits(Offset_bits),.Address_bits(Address_bits))CM(clk,reset,Cache_hit,Cache_miss,wr_en,rd_en,Main_Mem_ack1,Flush,Index_address,Offset_address,address,write_data,Data_New,Tag_Address,Tag_Cache,Valid_bit,Dirty_bit,Dirty_bit_Flush,Data_prev,Address_prev,read_data,Flush_Done,flush_count);    

    Controller#(.Tag_bits(Tag_bits),.Index_bits(Index_bits),.IDLE(3'd0),.PROCESS_REQUEST(3'd1),.CACHE_ALLOCATE(3'd2),.WRITEBACK(3'd3),.FLUSH(3'd4))CTRL(clk,reset,CPU_Request,Valid_bit,Dirty_bit,Dirty_bit_Flush,Main_Mem_ack1,Flush,Flush_Done,Cache_Flush,rd_en,wr_en,Tag_Address,Tag_Cache,Cache_hit,Cache_miss,Load_from_Memory,Save_to_Memory,flush_count_update_enable,flush_count);


endmodule

module Cache_Memory#(parameter Index_bits=5,parameter Tag_bits=8,parameter Data_bytes=16,parameter Offset_bits=4,parameter Address_bits=32)(
input clk,reset,Cache_hit,Cache_miss,wr_en,rd_en,Mem_ack,Flush,
input logic [Index_bits-1:0]Index,
input logic [Offset_bits-1:0]Offset,
input logic [Address_bits-1:0]Address_required,
input logic [7:0]wr_data,
input logic [Data_bytes*8-1:0] Data_New,
input logic [Tag_bits-1:0]Tag_Address,
output logic [Tag_bits-1:0]Tag_Cache,
output logic Valid_bit_Cache,Dirty_bit_Cache,
output logic Dirty_bit_Flush,
output logic [Data_bytes*8-1:0] Data_prev,
output logic [Address_bits-1:0] Address_prev,
output logic [7:0]rd_data,
input logic Flush_Done,
input logic [Index_bits-1:0]flush_count
);
    logic [1+1+Tag_bits+Data_bytes*8-1:0]Cache[2**(Index_bits)-1:0];
    logic [1+1+Tag_bits+Data_bytes*8-1:0]Cache_Line_Reading;
    logic [1+1+Tag_bits+Data_bytes*8-1:0]Cache_Line_Writing;
    logic cache_line_deleted;

    always_comb begin
        Tag_Cache=Cache[Index][Tag_bits-1+Data_bytes*8:Data_bytes*8];
        Valid_bit_Cache=Cache[Index][1+Tag_bits+Data_bytes*8];
        Dirty_bit_Cache=Cache[Index][0+Tag_bits+Data_bytes*8];
        Dirty_bit_Flush=Cache[flush_count][0+Tag_bits+Data_bytes*8];
        if (Flush)begin
            Address_prev={{Tag_Cache},{flush_count},{Offset_bits{1'b0}}};
        end
        if ((Cache_hit)&&(!Cache_miss))begin
            if (rd_en)begin
                Cache_Line_Reading=Cache[Index];
                Cache_Line_Reading=Cache_Line_Reading>>(Data_bytes-1-Offset)*8;
                rd_data=Cache_Line_Reading[7:0];
            end
        end
        else if (Cache_miss)begin
            Data_prev=Cache[Index][Data_bytes*8-1:0]; //Data to be sent sent to the main memory
            Address_prev={{Tag_Cache},{Index},{Offset_bits{1'b0}}};
        end
        if (Mem_ack&&(!Cache_hit)&&(Cache_miss))begin
            Cache[Index][Data_bytes*8-1:0]=Data_New;
            Cache[Index][Tag_bits-1+Data_bytes*8:Data_bytes*8]=Tag_Address;
            Cache[Index][Tag_bits+Data_bytes*8]=0;  //Dirty_bit is cleared
            Cache[Index][Tag_bits+Data_bytes*8+1]=1;
        end
        if (Dirty_bit_Flush)begin
            if((Flush)&&(!Flush_Done)&&(!cache_line_deleted))begin
                Data_prev=Cache[flush_count][Data_bytes*8-1:0];
                cache_line_deleted=1;
            end
        end
        if(Flush&&(!Flush_Done)&&Mem_ack)begin
            Cache[flush_count]=0;
            cache_line_deleted=0;
        end
    end
    always_ff @(posedge clk or negedge reset) begin
        if (!reset)begin
            Cache_Line_Writing<=0;
            for (int i=0;i<2**(Index_bits);i++)begin
                Cache[i]<=0;
            end
            cache_line_deleted<=0;
        end
        else begin
            if (Cache_hit&&wr_en)begin
                Cache_Line_Writing=255;
                Cache_Line_Writing=Cache_Line_Writing<<(Offset*8);
                Cache_Line_Writing=~Cache_Line_Writing;
                Cache[Index]=Cache[Index]&Cache_Line_Writing;
                Cache_Line_Writing={{(1+1+Tag_bits+Data_bytes*8-8){1'b0}},wr_data};
                Cache_Line_Writing=Cache_Line_Writing<<(Offset*8);
                Cache[Index]=Cache[Index]|Cache_Line_Writing;
                Cache[Index][Tag_bits+Data_bytes*8]=1;  //Dirty_bit is set
                Cache[Index][1+Tag_bits+Data_bytes*8]=1;
            end
        end
    end
endmodule

module axi_master_controller (
    input logic clk,
    input logic reset,
    input logic start_write,
    input logic start_read,
    input logic aw_ready,
    input logic w_ready,
    input logic b_valid,
    input logic ar_ready,
    input logic r_valid,
    output logic aw_valid,
    output logic w_valid,
    output logic b_ready,
    output logic ar_valid,
    output logic r_ready,
    output logic axi_ready
);

// define states

typedef enum logic [2:0] { 
    IDLE  = 3'b000,
    WADDR = 3'b001,
    WDATA = 3'b010,
    BRESP = 3'b011,
    RADDR = 3'b100,
    RDATA = 3'b101
 } state_type;

// define current and next state

state_type current_state , next_state;

// sequential next state logic

always_ff @( posedge clk or negedge reset ) begin
    if (!reset) begin
        current_state <=  IDLE;
    end
    else begin
        current_state <=  next_state;
    end
end

// next state logic 

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
                axi_ready = 1'b0;
            end
            else if (start_read && !ar_ready) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b1;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
            else if (start_read && ar_ready) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b1;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
            else if (start_write && !aw_ready) begin
                aw_valid  = 1'b1;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
            else if (start_write && aw_ready) begin
                aw_valid  = 1'b1;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
            else begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
        end
        WADDR: begin
            if(!aw_ready) begin
                aw_valid  = 1'b1;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
            else begin
                aw_valid  = 1'b1;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
        end
        WDATA: begin
            if (!w_ready) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b1;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
            else begin
                aw_valid  = 1'b0;
                w_valid   = 1'b1;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
        end
        BRESP: begin
            if (!b_valid) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b1;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
            else begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b1;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ready = 1'b1;
            end
        end
        RADDR: begin
            if(!ar_ready) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b1;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
            else begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b1;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
            end
        end
        RDATA: begin
            if (!r_valid) begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b1;
                axi_ready = 1'b0;
            end
            else begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b1;
                axi_ready = 1'b1;
            end
        end
        default: begin
                aw_valid  = 1'b0;
                w_valid   = 1'b0;
                b_ready   = 1'b0;
                ar_valid  = 1'b0;
                r_ready   = 1'b0;
                axi_ready = 1'b0;
        end 
    endcase
end

endmodule
