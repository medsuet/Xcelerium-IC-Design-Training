#################################################################################
#  +  Author      : Muhammad Ehsan
#  +  Date        : 07-08-2024
#  +  Description : Testing sequential multiplier using Cocotb.
#################################################################################

import cocotb
from cocotb.triggers import RisingEdge, Timer
import random

#------------------------------ Clock Generation ------------------------------#

async def clock_gen(dut):
    while True:
        dut.clk.value = 1
        await Timer(5, units='ns')
        dut.clk.value = 0
        await Timer(5, units='ns')

#--------------------------------- RESET Circuit ------------------------------#

async def reset_circuit(dut):
    dut.rst.value = 0
    await Timer(5, units='ns')
    dut.rst.value = 1
    dut._log.info("Reset complete")

#-------------------------------- Driving Inputs ------------------------------#

async def drive_inputs(dut, in1, in2):
    dut.multiplicand.value = in1
    dut.multiplier.value = in2
    dut.src_valid.value = 1
    await RisingEdge(dut.clk)
    dut.src_valid.value = 0
    while (dut.dest_valid.value == 0):
        await RisingEdge(dut.clk)
    dut.dest_ready.value = 1
    await RisingEdge(dut.clk)
    dut.dest_ready.value = 0

#------------------------------ Monitoring Outputs ----------------------------#

async def monitor_outputs(dut, a, b):
    exp = a * b
    while not dut.dest_ready.value:
        await RisingEdge(dut.clk)    
    await RisingEdge(dut.clk)
    product = int(dut.product.value.signed_integer)
    if product != exp:
        dut._log.error(f"Test failed Expected: {exp}, Got: {product}, a: {a}, b: {b}")
    else:
        dut._log.info(f"Test passed")

#----------------------------------- Testing ----------------------------------#

@cocotb.test()
async def test_seq_mul(dut):
        
    MUL_WIDTH = 16                              # Width Of Inputs
    Number_of_Tests = 300                       # Number Of Tests Cases
    cocotb.start_soon(clock_gen(dut))
    await reset_circuit(dut)
    dut.dest_ready.value = 0

    # Direct Test
    a = 1
    b = 1
    drive_task = cocotb.start_soon(drive_inputs(dut, a, b))
    monitor_task = cocotb.start_soon(monitor_outputs(dut, a, b))
    await drive_task
    await monitor_task

    # Random Test
    for i in range(Number_of_Tests):
        a = random.randint(-(2**(MUL_WIDTH-1)-1), (2**(MUL_WIDTH-1))-1)
        b = random.randint(-(2**(MUL_WIDTH-1)-1), (2**(MUL_WIDTH-1))-1)
        drive_task = cocotb.start_soon(drive_inputs(dut, a, b))
        monitor_task = cocotb.start_soon(monitor_outputs(dut, a, b))
        await drive_task
        await monitor_task

