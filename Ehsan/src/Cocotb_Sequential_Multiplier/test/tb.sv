/********************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 07-08-2024
  +  Description : Testing sequential multiplier using Cocotb.
********************************************************************************/

parameter MUL_WIDTH = 16;

module tb;

//=================== Declearing Input And Outputs For UUT ===================//

    logic                                  clk;              
    logic                                  rst;             
    logic   signed   [MUL_WIDTH-1:0]       multiplicand;    
    logic   signed   [MUL_WIDTH-1:0]       multiplier;      
    logic   signed   [(2*MUL_WIDTH)-1:0]   product;    
    logic                                  src_valid;
    logic                                  src_ready;
    logic                                  dest_valid;
    logic                                  dest_ready;
    
//=========================== Module Instantiation ===========================//

    sequential_multiplier_top #(.MUL_WIDTH(MUL_WIDTH)) uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready),
        .product(product)
    );
//=========================== Generating Waveform ============================//

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end

endmodule

