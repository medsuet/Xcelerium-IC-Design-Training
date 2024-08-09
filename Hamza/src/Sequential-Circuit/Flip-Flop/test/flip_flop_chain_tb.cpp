#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vflip_flop_chain_tb.h"

#define MAX_SIM_TIME 150
vluint64_t sim_time = 0;

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    Vflip_flop_chain_tb* top = new Vflip_flop_chain_tb;

    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("flip_flop_chain_tb.vcd");

    while (!Verilated::gotFinish() && sim_time < MAX_SIM_TIME) {
      
        top->clk ^= 1;


        top->eval();

        tfp->dump(sim_time);

        sim_time++;


    }

    tfp->close();

    delete top;

    exit(EXIT_SUCCESS);
}