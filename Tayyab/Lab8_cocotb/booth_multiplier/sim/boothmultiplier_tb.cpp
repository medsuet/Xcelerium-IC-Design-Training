/*
    Name: boothmultiplier_tb.cpp
    Author: Muhammad Tayyab
    Date: 6-8-2024
    Description: Verilator testbench for boothmultiplier.sv

    Comandline argument: argv[1]   : number of random tests to run
*/

#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vbooth_multiplier.h"
#include "Vbooth_multiplier___024root.h"

#define NUMBITS 32

// Clocking variables
vluint64_t sim_time = 0;
vluint64_t clk_pedges = 0;

// Global variables
int num_rand_tests;
char monitor_state = 0;
signed int monitor_num_a, monitor_num_b;
signed long ref_result;
char driver_state = 0;
int num_tests = 0;
int passed_tests = 0, failed_tests = 0;

// Function prototypes
void driver(Vbooth_multiplier *dut);
void monitor(Vbooth_multiplier *dut);


int main(int argc, char** argv, char** env) {

    // Get command line arguments
    if (argc==2) {
        num_rand_tests = atoi(argv[1]);
    }
    else {
        num_rand_tests = 100;
    }

    // Connect to dut
    Vbooth_multiplier *dut = new Vbooth_multiplier;

    // Dump signals to wavefile
    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    // Random seed
    srand(3456);

    // Loop until all random tests performed
    while (num_tests <= num_rand_tests) {
        dut->clk ^= 1;
        driver(dut);        // drive signals
        dut->eval();
        monitor(dut);       // monitor the outputs
        m_trace->dump(sim_time);
        sim_time++;
    }

    // Print results
    printf("\n##################\n");
    printf("Total random tests: %d\n", int(num_rand_tests));
    printf("Passed: %d\n", passed_tests);
    printf("Failed: %d\n", failed_tests);
    printf("\n##################\n");

    // Close wavefile and dut
    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}

void driver(Vbooth_multiplier *dut) {
    // At negedge clk, hold values
    if (sim_time % 2 == 1) {
        dut->reset=dut->reset;
        dut->num_a=dut->num_a;
        dut->num_b=dut->num_b;
        dut->valid_src=dut->valid_src;
        dut->ready_dst=dut->ready_dst;
    }
    // At posedge clk, drive new values
    else {
        switch (driver_state)
        {
            // Init sequence
            case 0:
                dut->reset=1;
                dut->num_a=0;
                dut->num_b=0;
                dut->valid_src=0;
                dut->ready_dst=0;
                driver_state = 1;
                break;
            // Reset
            case 1 ... 3:
                dut->reset=0;
                dut->num_a=0;
                dut->num_b=0;
                dut->valid_src=0;
                dut->ready_dst=0;
                driver_state += 1;
                break;
            // Apply random inputs
            case 4:
                dut->reset=1;
                dut->num_a = rand();// % (1<<NUMBITS);
                dut->num_b = rand();// % (1<<NUMBITS);
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

void monitor(Vbooth_multiplier *dut) {
    // Don't run (return) on negedge clk
    if (sim_time % 2 == 1) {
        return;
    }
    
    // Wait for valid_src
    // Then sample inputs of dut 
    if (monitor_state==0 && dut->valid_src) {
        monitor_num_a = dut->num_a;
        monitor_num_b = dut->num_b;
        ref_result =  (long) monitor_num_a * monitor_num_b;
        monitor_state = 1;
        return;
    }

    // When valid_dst comes, check output of dut
    if (monitor_state==1 && dut->valid_dst) {
        long test_product = ((long) dut->product_high << NUMBITS) + dut->product_low;
        if (test_product != ref_result) {
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

