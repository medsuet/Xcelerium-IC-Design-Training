`timescale 1ns / 1ps
module Cache_TB();
    localparam CLK_PERIOD = 10;
    logic clk=1;
    logic reset;
    parameter C=32;
    parameter b=8;
    parameter Data_bytes=16;
    parameter Address_bits=32;
    parameter Offset_bits=$clog2(Data_bytes);
    parameter Index_bits=$clog2(C/b);
    parameter Tag_bits=Address_bits-Offset_bits-Index_bits;
    parameter Memory_size=100;
    parameter Addressibility=8;
    logic [Address_bits-1:0]address;
    logic rd_en,wr_en,CPU_Request;
    logic [Addressibility-1:0]write_data,read_data;
    logic aw_ready,w_ready,b_valid,ar_ready,r_valid,aw_valid,w_valid,b_ready,ar_valid,r_ready,Main_Mem_ack,Main_Mem_ack1,start_write,start_read;
    logic [Data_bytes*8-1:0]Main_Memory[Memory_size-1:0];
    Cache#(.Addressibility(Addressibility),.C(C),.b(b),.Data_bytes(Data_bytes),.Address_bits(Address_bits),.Offset_bits($clog2(Data_bytes)),.Index_bits($clog2(C/b)),.Tag_bits(Address_bits-Offset_bits-Index_bits),.Memory_size(Memory_size))Cache1(clk,reset,CPU_Request,address,rd_en,wr_en,write_data,read_data,aw_ready,w_ready,b_valid,ar_ready,r_valid,aw_valid,w_valid,b_ready,ar_valid,r_ready,Main_Mem_ack1,Main_Mem_ack,start_write,start_read,Main_Memory);
    task driver_miss_dirty_bit1(input logic CPU_Request_driver,input logic rd_en_driver,input logic wr_en_driver,input logic [7:0]write_data_driver,input logic [31:0]address_driver);
    begin
        aw_ready=0;
        w_ready=0;
        b_valid=0;
        ar_ready=0;
        r_valid=0;
        CPU_Request=CPU_Request_driver;
        rd_en=rd_en_driver;
        wr_en=wr_en_driver;
        write_data = write_data_driver;
        address=address_driver;
        while(!start_write)begin
            @(posedge clk);
        end
        while(!aw_valid)begin
            @(posedge clk);
        end
        aw_ready=1;
        CPU_Request=0;
        while(!w_valid)begin
            @(posedge clk);
        end
        
        w_ready=1;
        while(!b_ready)begin
            @(posedge clk);
        end
        b_valid=1;
        while(!Main_Mem_ack1)begin
        @(posedge clk);
        end
        
        ar_ready=1;
        while(!ar_valid)begin
        @(posedge clk);
        end
        r_valid=1;
        while(!r_ready)begin
        @(posedge clk);
        end
        while(!Main_Mem_ack1)begin
        @(posedge clk);
        end
        while(!start_read)begin
            @(posedge clk);
        end
        while(!ar_valid)begin
            @(posedge clk);
        end
        ar_ready=1;
        CPU_Request=0;
        while(!r_ready)begin
        @(posedge clk);
        end
        r_valid=1;
        while(!Main_Mem_ack1)begin
        @(posedge clk);
        end
        #30;
    end
    endtask
    task driver_miss_dirty_bit0(input logic CPU_Request_driver,input logic rd_en_driver,input logic wr_en_driver,input logic [7:0]write_data_driver,input logic [31:0]address_driver);
    begin
        aw_ready=0;
        w_ready=0;
        b_valid=0;
        ar_ready=0;
        r_valid=0;
        CPU_Request=CPU_Request_driver;
        rd_en=rd_en_driver;
        wr_en=wr_en_driver;
        write_data = write_data_driver;
        address=address_driver;
        while(!start_read)begin
            @(posedge clk);
        end
        while(!ar_valid)begin
            @(posedge clk);
        end
        ar_ready=1;
        CPU_Request=0;
        while(!r_ready)begin
            @(posedge clk);
        end
        r_valid=1;
        while(!Main_Mem_ack1)begin
            @(posedge clk);
        end
        #30;
    end
    endtask
    always #(CLK_PERIOD/2) clk = ~clk;
    initial begin
        reset = 1;
        #10;
        reset = 0;
        #10
        reset = 1;
        #10;
        driver_miss_dirty_bit0(1,0,1,210,0);
        driver_miss_dirty_bit1(1,0,1,-1,32'b1000000);
        #100
      $finish;
    end
endmodule