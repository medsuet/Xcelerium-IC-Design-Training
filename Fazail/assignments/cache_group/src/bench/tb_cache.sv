module tb_cache;

logic clk,reset;

// cpu -> cache
logic [1:0]     cpu_request;
logic           proc_valid;
logic           flush;

// cache -> cpu
logic           cache_ready;

// cpu <--> cache
logic [31:0]    cpu_addr;
logic [31:0]    cpu_data;
logic [31:0]    data_out;
logic [127:0]   r_data;
logic [127:0]   w_data;

// Axi --> Testbench
logic           ar_valid;
logic           r_ready;
logic           aw_valid;
logic           w_valid;
logic           b_valid;

// datapath --> mem
logic [31:0]    aw_addr;

// Testbench --> Axi
logic           ar_ready;
logic           r_valid;
logic           aw_ready;
logic           w_ready;
logic           b_ready;

// mem --> datapath
logic [31:0]    aw_data;
logic [31:0]    ar_addr;

logic [31:0]    local_ar_addr;
logic [31:0]    local_aw_addr;
logic [31:0]    cmp_data;

logic [31:0] memory[0:31];
logic [31:0] dummy[0:31];

cache  dut ( 
    .clk(clk), .rst(reset), 
    .flush_en       (flush), 
    .aw_ready(aw_ready), 
    .w_ready(w_ready), 
    .ar_ready(ar_ready), 
    .b_ready(b_ready), 
    .cpu_request(cpu_request), 
    .cpu_addr(cpu_addr), 
    .cpu_data(cpu_data), 
    .proc_valid(proc_valid), 
    .cache_ready(cache_ready), 
    .ar_valid(ar_valid), 
    .r_data(r_data), 
    .r_valid(r_valid), 
    .r_ready(r_ready), 
    .aw_data(aw_data), 
    .ar_addr(ar_addr),
    .aw_addr(aw_addr),  
    .aw_valid(aw_valid), 
    .w_valid(w_valid), 
    .b_valid(b_valid),  
    .w_data(w_data), 
    .data_out(data_out)
);

// clk block
initial begin
   clk = 0;
   forever #5 clk = ~clk; // 10ns clock period
end

initial begin   
    memory[65537] = 75;
end

task read_from_memory();
   forever begin
      //ar_ready = 1'b1;
      @(posedge clk);   
      while(!ar_valid) 
         @(posedge clk);
      
      //@(posedge clk); 
      ar_ready = 1'b0;

      repeat($random % 11) @(posedge clk); // repeat randon number of clock cycles(1 to 10)
      
      local_ar_addr = ar_addr;
      ar_ready = 1'b0;
      
      assign r_data = memory[local_ar_addr];
      assign r_valid = 1'b1; 
      @(posedge clk);
      
      while(!r_ready)
         @(posedge clk);
      
      repeat($random % 11) @(posedge clk);  // repeat randon number of clock cycles(1 to 10)  
      
      assign r_valid = 1'b0;
   end
endtask

task write_to_memory();
   forever begin  
      aw_ready = 1'b1;
      @(posedge clk);
      
      while(!aw_valid) 
         @(posedge clk);
      aw_ready      = 1'b0;
      
      repeat($random % 11) @(posedge clk);  // repeat randon number of clock cycles(1 to 10)  
      local_aw_addr = aw_addr;
      w_ready       = 1'b1; 
      @(posedge clk);

      while(!w_valid) 
         @(posedge clk);

      repeat($random % 11) @(posedge clk);  // repeat randon number of clock cycles(1 to 10)
      
      memory[local_aw_addr] = aw_data;  
      w_ready = 1'b0;
   end
endtask

task response();
   while(1) begin
      b_valid = 1;  
      
      @(posedge clk);
      while(!b_ready) begin 
         @(posedge clk); 
      end
      b_valid = 0;
      @(posedge clk);
      while(!aw_valid) 
         @(posedge clk);
      //repeat($random % 3) @(posedge clk);  // repeat randon number of clock cycles(1 to 10)  
   end
endtask

task driver_cache(
      input  [1:0]request, 
      input [31:0]addr, 
      input [31:0]data
);
      cpu_request = request;
      cpu_addr = addr;
      cpu_data = data;
     
      proc_valid = 1;
      @(posedge clk);
      while(!cache_ready)begin 
         @(posedge clk); 
      end     
      proc_valid = 0; 
      @(posedge clk);
       //random clk cycles
endtask



task driver_memory();
begin
  fork
    read_from_memory();
    write_to_memory();
    response();
  join_any 
end
endtask


task monitor();
begin
@(negedge reset);
@(posedge reset);
cmp_data = 32'd0;
  forever begin
     @(posedge clk);
     if(cpu_request == 2'b00)begin
           if (proc_valid==1 && cache_ready==1) 
           begin
               cmp_data = dummy[cpu_addr];
               if(data_out == cmp_data) $display("pass");
               else $display("fail");
           end
     end
     else dummy[cpu_addr] = cpu_data;

  end      
end  
endtask

initial begin
   init_signals;
   reset = 0;
   @(posedge clk);
   reset = 1;
   flush =0;
   //writing (hit case)
   driver_cache(2'b01, 32'd1, 32'd2024);
   // reading (hit case)
   driver_cache(2'b00, 32'd1, 32'd0000);
   // miss case with dirty bit 0 (store->read->overwrite)
   driver_cache(2'b01, 32'h10001, 32'd2025);
   driver_cache(2'b01, 32'h10001, 32'd2026);

   //driver_cache(2'b00, 32'd1, 32'd2024);
  // $stop;
end

initial begin
   //fork
      driver_memory();
      
   //join_any
end

initial monitor();

task init_signals;
   reset    = 1;
   aw_ready = '0;
	w_ready  = '0;
	b_valid  = '0;
	ar_ready = 1; 
	r_valid  = '0;
   @(posedge clk);
endtask
endmodule