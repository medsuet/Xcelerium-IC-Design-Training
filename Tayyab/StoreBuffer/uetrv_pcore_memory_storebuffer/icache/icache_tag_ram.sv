// Copyright 2023 University of Engineering and Technology Lahore.
// Licensed under the Apache License, Version 2.0, see LICENSE file for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description: The instruction cache top module. 
//
// Author: Umer Shahid and Ali Imran, UET Lahore
// Date: 10.4.2023


`ifndef VERILATOR
`include "../../defines/cache_defs.svh"
`else
`include "cache_defs.svh"
`endif

module icache_tag_ram
#(
parameter NUM_COL    = 1,
parameter COL_WIDTH  = 32,
parameter ADDR_WIDTH = $clog2(ICACHE_NO_OF_SETS), // 11
parameter DATA_WIDTH = NUM_COL*COL_WIDTH          // Data width in bits
) (
  input wire                     clk,
  input wire                     rst_n,

  input wire                     req,
  input wire                     wr_en,           // [NUM_COL-1:0]
  input wire   [ADDR_WIDTH-1:0]  addr,
  input wire   [DATA_WIDTH-1:0]  wdata,
  output logic [DATA_WIDTH-1:0]  rdata
);

// Memory
reg [DATA_WIDTH-1:0] icache_tagram [ICACHE_NO_OF_SETS-1:0];

// Port read write operation
always @ (posedge clk) begin
   if (req) begin
      if (wr_en) begin
         icache_tagram[addr] <= wdata;
         rdata               <= wdata;
      end else begin
         rdata               <= icache_tagram[addr]; 
      end 
   end 
end

endmodule 
