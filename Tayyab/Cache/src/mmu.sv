/*
    Name: mmu.sv
    Author: Muhammad Tayyab
    Date: 13-8-2024
    Description: Dummy MMU to convert virtual address to physical address
*/

import cache_parameters::*;

module mmu #(parameter PAGEOFFSET_WIDTH)
(
    input logic clk, reset,
    input logic [(ADDRESS_BUSWIDTH-1):0] virtual_address,
    output logic [(ADDRESS_BUSWIDTH-1):0] physical_address
);

    logic [(ADDRESS_BUSWIDTH_BUSWIDTH-PAGEOFFSET_WIDTH-1):0] page_table_mem [(ADDRESS_BUSWIDTH_BUSWIDTH-PAGEOFFSET_WIDTH-1):0];

    initial begin
        for (int i=0; i<(ADDRESS_BUSWIDTH_BUSWIDTH-PAGEOFFSET_WIDTH); i++) begin
            page_table_mem = (i+1000);  // each physical page no is 1000 more than virtual page no
        end
    end

    always_comb begin
        physical_address = {page_table_mem[virtual_address[(ADDRESS_BUSWIDTH_BUSWIDTH-1):PAGEOFFSET_WIDTH]], virtual_address[(PAGEOFFSET_WIDTH-1):0]};
    end

endmodule
