#include <stdlib.h>
#include <iostream>
#include <cstdlib>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vtb_add_1.h"  // Replace with the actual Verilated header file

#define MAX_SIM_TIME_R 43
vluint64_t MAX_SIM_TIME = 0;
vluint64_t sim_time = 0;

int main(int argc, char** argv) {
    
    const int array_size = 1000000-1;

    // Verilator setup
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    // Instantiate the Verilated model
    Vtb_add_1* top = new Vtb_add_1;

    // Initialize trace dump
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);  				// Trace 99 levels of hierarchy
    tfp->open("waveform.vcd");

    for (int i = 0; i < array_size; i++) {

        MAX_SIM_TIME += MAX_SIM_TIME_R;
        
        // Simulate for MAX_SIM_TIME
        while (!Verilated::gotFinish() && sim_time < MAX_SIM_TIME) {

            top->clk ^= 1;
            top->eval();


            tfp->dump(sim_time);

            // Advance time
            sim_time++;
            }
    }

    tfp->close();

    // Clean up
   delete top;

    exit(EXIT_SUCCESS);
}

