#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vtb_sequential_adder.h"

#define MAX_SIM_TIME 150
vluint64_t sim_time = 0;

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    Vtb_sequential_adder* top = new Vtb_sequential_adder;

    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("adder.vcd");

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
