/*
    Name: cache_tb.cpp
    Author: Muhammad Tayyab
    Date: 15-8-2024
    Description: Verilator testbench for cache.sv
*/

// Top level module name
#define MODULE Vcache

#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vaxi4lite_parameters.h"
#include "Vaxi4lite_parameters___024root.h"

#define MAX_SIM_TIME 100

// Clocking variables
vluint64_t sim_time = 0;
vluint64_t clk_pedges = 0;

// Global variables
int num_rand_tests;
char monitor_state = 0;
signed short monitor_num_a, monitor_num_b;
signed int ref_result;
char driver_state = 0;
int num_tests = 0;
int passed_tests = 0, failed_tests = 0;

// Function prototypes
void driver(MODULE *dut);
void monitor(MODULE *dut);


int main(int argc, char** argv, char** env) {

    // Get command line arguments

    // Instantiate dut
    MODULE *dut = new MODULE;

    // Dump signals to wavefile
    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("verilator_waveform.vcd");

    // Random seed
    srand(439);

    // Loop 
    while (sim_time < MAX_SIM_TIME) {
        dut->clk ^= 1;
        driver(dut);        // drive signals
        dut->eval();
        monitor(dut);       // monitor the outputs
        m_trace->dump(sim_time);
        sim_time++;
    }

    // Print results
    printf("\n##################\n");
    printf("Complete");
    printf("\n##################\n");

    // Close wavefile and dut
    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}

void driver(MODULE *dut) {
    // Dont run at negedge clk
    if (sim_time % 2 == 1) return;
    
    // At posedge clk, drive new values
    else {
        switch (driver_state)
        {
            // Init sequence
            case 0:
                dut->reset=1;
                driver_state = 1;
                break;
            // Reset
            case 1 ... 3:
                dut->reset=0;
                driver_state += 1;
                break;
            // Write 
            case 4:
                dut->reset=1;
                dut->
                dut->valid_src=1;
                driver_state=5;
                num_tests += 1;
                break;
            // Wait for ready_src
            case 5:
                dut->reset=1;
                dut->num_a=dut->num_a;
                dut->num_b=dut->num_b;
                dut->valid_src=1;
                // if ready_src, deassert valid_src and go back to state 4
                if (dut->ready_src) {
                    dut->valid_src=0;
                    driver_state = 4;
                }
                break; 
            
            default:
                dut->reset=1;
                dut->num_a=0;
                dut->num_b=0;
                dut->valid_src=0;
                dut->ready_dst=0;
                driver_state = driver_state;
                break; 
        }
    clk_pedges += 1;
    }
}

void monitor(MODULE *dut) {
    // Don't run on negedge clk
    if (sim_time % 2 == 1) return;
    
    // Wait for valid_src
    // Then sample inputs of dut 
    if (monitor_state==0 && dut->valid_src) {
        monitor_num_a = dut->num_a;
        monitor_num_b = dut->num_b;
        ref_result =  monitor_num_a * monitor_num_b;
        monitor_state = 1;
        return;
    }

    // When valid_dst comes, check output of dut
    if (monitor_state==1 && dut->valid_dst) {

        if (dut->product != ref_result) {
            printf("\nTest fail.\n");
            failed_tests += 1;
        }
        else {
            passed_tests += 1;
        }
        monitor_state = 2;
        return;
    }

    // Assert ready_dst
    if (monitor_state==2) {
        dut->ready_dst = 1;
        monitor_state = 3;
        return;
    }

    // Deassert ready_dst
    if (monitor_state==3) {
        dut->ready_dst = 0;
        monitor_state = 0;
        return;
    }

}

