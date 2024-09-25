// Copyright 2024 University of Engineering and Technology Lahore.
// Licensed under the Apache License, Version 2.0, see LICENSE file for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description: 8x3 priority encoder (low and high)
//
// Author: Muhammad Tayyab, UET Lahore
// Date: 7.9.2023

`timescale 1 ns / 100 ps

`ifndef VERILATOR
`include "../../defines/cache_defs.svh"
`include "../../defines/sb_defs.svh"
`else
`include "cache_defs.svh"
`include "sb_defs.svh"
`endif

module priority_encoder_high_8bit (
    input logic [7:0] in,
    output logic [2:0] out
);
    always_comb begin
        casez (in)
            'b1???????: out = 'h7; 
            'b01??????: out = 'h6;
            'b001?????: out = 'h5;
            'b0001????: out = 'h4;
            'b00001???: out = 'h3;
            'b000001??: out = 'h2;
            'b0000001?: out = 'h1;
            'b00000001: out = 'h0;
            default:    out = 'h0;
        endcase
    end
endmodule

module priority_encoder_low_8bit (
    input logic [SB_NO_OF_LINES-1:0] in,
    output logic [$clog2(SB_NO_OF_LINES)-1:0] out
);
    int i;
    always_comb begin
        out = '0;
        for (i=0; i<$clog2(SB_NO_OF_LINES); i++) begin
            if (in[i] == 1'b1) begin
                out = i[$clog2(SB_NO_OF_LINES)-1:0];
                break;
            end
        end
    end
endmodule
