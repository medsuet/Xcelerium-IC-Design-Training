module cache_datapath(
    input  logic           clk,
    input  logic           reset,
      
    input  logic 		      counter_en,
    input  logic [31:0]	   cpu_address,
    input  logic [31:0]	   cpu_data_in,
      
    input  logic       	   cache_en,
    input  logic 		      mem_en,
    input  logic 		      flush,          
    input  logic [127:0]   R_data,
      
    output logic [31:0]    AW_addr,
    output logic [31:0]    AR_addr,
    output logic [127:0]   w_data,
      
    output logic [31:0]    cpu_data_out,     
    output logic           flush_done,
    output logic   		   hit,
    output logic 		      dirty_bit           
);
    parameter cache_size = 1024;
    parameter cache_line_size = 16;

    parameter num_lines   = cache_size / cache_line_size;          //64 lines
    parameter index_bits  = $clog2(cache_size / cache_line_size); // 6 bits
    parameter offset_bits = $clog2(cache_line_size);              // 4 bits
    parameter tag_bits    = 32 - index_bits - offset_bits;        // 22 bits

    logic [31:0] 			data;
    logic [tag_bits-1:0] 	cache_tag;
    logic [offset_bits-1:0] offset;
    logic [index_bits-1:0]  index;
    logic [index_bits-1:0]  indx;
    logic [tag_bits-1:0]    tag;
    logic [5:0]				count_out;
    
    // initializing memory for cache data and overhead
    logic [8*(cache_line_size-1):0] cache[num_lines-1:0];
    logic [tag_bits+1:0]     		   overhead[num_lines-1:0];
    logic [3:0] 					      bit_position;
    
     // Initialize cache and overhead
    initial begin
     
        for (int i = 0; i < num_lines; i++) begin
            cache[i] = {cache_line_size{1'b0}};  
            overhead[i] = {tag_bits+2{1'b0}};   
        end
           overhead[0][tag_bits+1] = 1;
    end
    
    //getting offset index and tag
    assign offset = cpu_address[offset_bits-1:0];                   
    assign indx  = cpu_address[offset_bits +: index_bits];           
    assign tag    = cpu_address[31 -: tag_bits];                    

   //Extracting data from overhead
    assign cache_tag = overhead[index][tag_bits-1:0];
    assign dirty_bit = overhead[index][tag_bits];
    assign valid_bit = overhead[index][tag_bits+1];

    assign hit = (valid_bit == 1 && tag == cache_tag) ? 1 : 0;
    
     mux21_6 mux_index(indx,count_out,flush,index);
     
   // flushing and writeback operationoperation
    counter Counter(clk,reset,counter_en,count_out,flush_done);
    mux21_32 WB_mux_addr({{cache_tag},{index},{4'd0}},{{overhead[count_out][tag_bits-1:0]},{count_out},{4'd0}},flush,AW_addr);    
    
    
    assign bit_position = offset * 32;
    always_ff @(posedge clk ) 
    begin 
       // in case of writing due to cpu                                
      if(cache_en == 1) begin
              cache[index][bit_position +: 32] <= cpu_data_in;    //  writing due to cpu
              overhead[index][tag_bits] <= 1'b1;     //setting dirty bit 
              overhead[index][tag_bits+1]<=1'b1;
      end

      // in case of reading from memory                                                     
      if(mem_en == 1 )begin 
              cache[index] <= R_data;                 // writing data
              overhead[index][tag_bits-1:0] <= tag;   //setting tag 
              overhead[index][tag_bits+1] <= 1'b1;   // setting valid bit 
               overhead[index][tag_bits] <= 1'b0;    //clearing dirty bit
      end 
      if(flush)begin 
            overhead[count_out][tag_bits]<=0;  
            overhead[count_out][tag_bits+1]<=0; 
       end
         
    end
   
    always_comb //reading data
    begin
       cpu_data_out = cache[index][bit_position +: 32];
       AR_addr = cpu_address;
       w_data =       cache[index];
       
      end
endmodule

module counter (
	input  logic clk,
	input  logic reset,
	input  logic en,
	
	output logic [5:0]out,
	output logic flush_done
);

always_ff @(posedge clk or negedge reset) begin

	if(!reset) 
		out<=6'b0;
	else if(out == 6'd63) 
		out<=6'b0;
	else  if(en) 
		out <= out+1;
end
	
assign	flush_done = (out == 6'd63) ? 1:0;

endmodule	// counter

module mux21_6 (
	input logic [5:0] in0,in1,
	input logic sel,
	
	output logic [5:0] out
);

always_comb begin
	case(sel)
	   0: out = in0;
	   1: out = in1;
	   default: out = 0;
	endcase
end

endmodule 	// mux21_6

module mux21_32 (
	input logic [31:0] in0,in1,
	input logic sel,
	
	output logic [31:0] out
);

always_comb begin
	case(sel)
	   0: out = in0;
	   1: out = in1;
	   default: out = 0;
	endcase
end

endmodule	// mux21_32
