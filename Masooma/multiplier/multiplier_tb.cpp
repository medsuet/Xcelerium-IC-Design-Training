#include <cstdlib> 
#include <ctime>  
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vmultiplier.h"
#include <cstdio>
using namespace std;

#define MAX_SIM_TIME 2000
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env) {
    Vmultiplier *dut = new Vmultiplier;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    // Initialize input signals
    dut->a = 0;
    dut->b = 0;
    // Providing a seed value
    srand((unsigned) time(NULL));

    // Simulation loop
    while (sim_time < MAX_SIM_TIME) {
        dut->a = (rand() % 32768);  
        dut->b = (rand() % 32768);  
        

        // Evaluate the DUT (Device Under Test)
        dut->eval();
        m_trace->dump(sim_time);

        // Check results
        if (dut->a * dut->b == dut->pro) {
            printf("Success: a = %d, b = %d, pro = %d\n", dut->a, dut->b, dut->pro);
        } else {
            printf("ERROR: a = %d, b = %d, a * b = %d, pro = %d\n", dut->a, dut->b, dut->a * dut->b, dut->pro);
        }

        // Increment simulation time
        sim_time += 10;
    }

    m_trace->close();
    delete dut;
    return 0;
}
