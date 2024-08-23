#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <Vrestoring_division>
#include <Vrestoring_division___024root.h>

#define NUMTESTS 10

int signed_A,signed_B,expected_division;


int time = 0;
int main(int argc, char** argv, char** env){
    Vrestoring_division *dut = new Vrestoring_division; 

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    // Initial values
    dut->dst_ready = 0;

    while (sim_time < MAX_SIM_TIME) {
        dut->clk ^= 1;
        driver(dut);
        dut->eval();
        monitor(dut);
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}

char direct_test_state = 0;
void direct_test(Vrestoring_division *dut, int testA, testB){
    if (~dut->clk) return;

    switch (direct_test_state) {
        case 0: 
                dut->Q = testA;
                dut->M = testB
                dut->src_valid = 1;
                direct_test_state ++;
                break;
        case 1:
                direct_test_state ++;
                break;
        case 2:
                if(dut->src_ready){
                    dut->src_valid =0;
                    direct_test_state ++;
                }
                break;
        case 3:
                break;
    }
}

char driver_state = 0;
int num_of_tests =0;
void driver(Vrestoring_division *dut){
    if (~dut->clk) return;

    switch (driver_state) {
        case 0: 
                dut->Q = rand();
                dut->M = rand();
                dut->src_valid = 1;
                num_of_tests++;
                driver_state++;
                break;
        case 1:
                driver_state++;
                break;
        case 2:
                if(dut->src_ready){
                    dut->src_valid =0;

                    driver_state++;
                }
                break;
        case 3:
                if (num_of_tests < NUMTESTS) driver_state=0;
                break;
    }
}


char monitor_state=0;
void monitor(Vrestoring_division *dut) {
    if (~dut->clk) return;
    switch (monitor_state) {
        case 0:
            monitor_state++;
            break;
        case 1:
            if(dut->src_valid){
                signed_A = Q;
                signed_B = M;
                expected_division = signed_A / signed_B;
                monitor_state++
            } 
            break;
        case 2: 
            if(dut->dst_valid){
                if(dut->out != expected_division) 
                    printf("Test Failed: A = %d, B = %d, Expected = %x, Got = %x", signed_A, signed_B, expected_division, out);
                else
                    printf("Test Passed: A = %d, B = %d, Expected = %x, Got = %x", signed_A, signed_B, expected_division, out);

                dut->dst_ready=1;
                monitor_state++;
            } 
            break;
        case 3:
            dut->dst_value =0;
            monitor_state = 0;
            break;   
    }
}

