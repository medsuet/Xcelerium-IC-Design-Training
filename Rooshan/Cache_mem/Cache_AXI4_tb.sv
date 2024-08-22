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
    parameter Addressability=8;
    int num_tests=4;
    int exit=0;
    int num_tests_passed=0;
    logic [Address_bits-1:0]address;
    logic rd_en,wr_en,CPU_Request;
    logic [Addressability-1:0]write_data,read_data;
    logic aw_ready,w_ready,b_valid,ar_ready,r_valid,aw_valid,w_valid,b_ready,ar_valid,r_ready,Main_Mem_ack,Main_Mem_ack1,start_write,start_read;
    logic Cache_hit,Cache_miss;
    logic Cache_Flush;
    Cache#(.Addressability(Addressability),.C(C),.b(b),.Data_bytes(Data_bytes),.Address_bits(Address_bits),.Offset_bits($clog2(Data_bytes)),.Index_bits($clog2(C/b)),.Tag_bits(Address_bits-Offset_bits-Index_bits),.Memory_size(Memory_size))Cache1(clk,reset,CPU_Request,address,rd_en,wr_en,write_data,read_data,aw_ready,w_ready,b_valid,ar_ready,r_valid,aw_valid,w_valid,b_ready,ar_valid,r_ready,Main_Mem_ack1,Main_Mem_ack,start_write,start_read,Cache_hit,Cache_miss,Cache_Flush);
    task monitor;
    begin
        for (int k=0;k<num_tests;k++)begin
            while(!Cache_miss)begin
                @(posedge clk);
            end
            while(!Cache_hit)begin
                @(posedge clk);
            end
            num_tests_passed+=1;
        end
        exit=1;
    end
    endtask
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
        Cache_Flush=0;
        driver_miss_dirty_bit0(1,0,1,8'hd3,32'b000000); //cache index 0
        driver_miss_dirty_bit0(1,0,1,8'hd7,32'b010000); //cache index 1
        driver_miss_dirty_bit0(1,0,1,8'h98,32'b100000); //cache index 2
        driver_miss_dirty_bit0(1,0,1,8'h9d,32'b110000); //cache index 3
        driver_miss_dirty_bit1(1,0,1,8'h92,32'b1000000);
        CPU_Request=1;
        rd_en=0;
        wr_en=1;
        write_data = 8'h99;
        address=32'b000000;
        #10;
        CPU_Request=0;
        
        Cache_Flush=1;
        aw_ready=1;
        w_ready=1;
        b_valid=1;
        ar_ready=1;
        r_valid=1;
        #100
        Cache_Flush=0;        
        if( exit==1)
            if (num_tests_passed==num_tests)begin
                $display("All tests passed");
            end
        #1000
      $finish;
    end
    initial begin
        monitor;
    end
endmodule
