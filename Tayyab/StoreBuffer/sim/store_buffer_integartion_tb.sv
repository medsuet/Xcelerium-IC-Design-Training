
`timescale 1 ns / 100 ps

`ifndef VERILATOR
`include "../defines/mmu_defs.svh"
`include "../defines/cache_defs.svh"
`include "../defines/ddr_defs.svh"
`else
`include "mmu_defs.svh"
`include "cache_defs.svh"
`include "ddr_defs.svh"
`endif

module store_buffer_integartion_tb ();

    parameter NUM_urandom_TESTS = 1000;
    parameter urandom_DELAY = 5;
    parameter urandomOM_SEED = 1;
    parameter ADDR_RANGE = 10;

    int i;

// Signals
    logic                                   clk;
    logic                                   rst_n;
    type_if2icache_s                        if2icache_i;
    type_icache2if_s                        icache2if_o, icache2if_sb_o;
    type_mmu2dcache_s                       mmu2dcache_i;
    type_dcache2mmu_s                       dcache2mmu_o, dcache2mmu_sb_o;
    type_dbus2peri_s                        dbus2peri_i;
    type_peri2dbus_s                        dcache2dbus_o, dcache2dbus_sb_o;
    type_peri2dbus_s                        bmem2dbus_o, bmem2dbus_sb_o;
    logic                                   dcache_flush_i;
    logic                                   lsu_flush_i;
    logic                                   dmem_sel_i;
    logic                                   bmem_sel_i;

// Instantization
    mem_top dut(
        .clk                                (clk),
        .rst_n                              (rst_n),
        .if2icache_i                        (if2icache_i),
        .icache2if_o                        (icache2if_sb_o),
        .mmu2dcache_i                       (mmu2dcache_i),
        .dcache2mmu_o                       (dcache2mmu_sb_o),
        .dbus2peri_i                        (dbus2peri_i),
        .dcache2dbus_o                      (dcache2dbus_sb_o),
        .bmem2dbus_o                        (bmem2dbus_sb_o),
        .dcache_flush_i                     (dcache_flush_i),
        .lsu_flush_i                        (lsu_flush_i),
        .dmem_sel_i                         (dmem_sel_i),
        .bmem_sel_i                         (bmem_sel_i)
    );

    original_mem_top dref(
        .clk                                (clk),
        .rst_n                              (rst_n),
        .if2icache_i                        (if2icache_i),
        .icache2if_o                        (icache2if_o),
        .mmu2dcache_i                       (mmu2dcache_i),
        .dcache2mmu_o                       (dcache2mmu_o),
        .dbus2peri_i                        (dbus2peri_i),
        .dcache2dbus_o                      (dcache2dbus_o),
        .bmem2dbus_o                        (bmem2dbus_o),
        .dcache_flush_i                     (dcache_flush_i),
        .lsu_flush_i                        (lsu_flush_i),
        .dmem_sel_i                         (dmem_sel_i),
        .bmem_sel_i                         (bmem_sel_i)
    );

// Generate clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

// Waveform
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end

// Tests
    initial begin
        reset_sequence();
        fork
            urandomom_driver();
            monitor();    
        join_any
    end

// Tasks
    task urandomom_driver();
        for (i=0; i<NUM_urandom_TESTS; i++) begin
            if2icache_i = {$urandom[2:0], $urandom};
            mmu2dcache_i = {$urandom[1:0], $urandom};
            dbus2peri_i = {$urandom[5:0], $urandom, $urandom};
            dcache_flush_i = $urandom()[0];
            lsu_flush_i = $urandom[0];
            dmem_sel_i = $urandom[0];
            bmem_sel_i = $urandom[0];
            @(posedge clk);
        end
    endtask

    task monitor();
        forever begin
            assert (bmem2dbus_o==bmem2dbus_sb_o)
            else begin $display("\n\nFAIL: bmem2dbus_o not matching\n\n"); $stop; end

            assert (dcache2dbus_o==dcache2dbus_sb_o)
            else begin $display("\n\nFAIL: dcache2dbus_o not matching\n\n"); $stop; end

            assert (dcache2mmu_o==dcache2mmu_sb_o)
            else begin $display("\n\nFAIL: dcache2mmu_o not matching\n\n"); $stop; end

            assert (icache2if_o==icache2if_sb_o)
            else begin $display("\n\nFAIL: icache2if_o not matching\n\n"); $stop; end

            @(posedge clk);
        end
    endtask

    task reset_sequence();
        rst_n = 1;
        #7;
        rst_n = 0;
        #25;
        rst_n = 1;
    endtask

endmodule