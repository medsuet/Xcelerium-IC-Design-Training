#################################################################################
#  +  Author      : Muhammad Ehsan
#  +  Date        : 06-08-2024
#  +  Description : Testing restoring division algorithm using Cocotb.
#################################################################################

import cocotb
from cocotb.triggers import RisingEdge, Timer
import random

#------------------------------ Clock Generation ------------------------------#

async def clock_gen(dut):
    """Clock generation."""
    while True:
        dut.clk.value = 0
        await Timer(5, units='ns')
        dut.clk.value = 1
        await Timer(5, units='ns')

#--------------------------------- RESET Circuit ------------------------------#

async def reset_circuit(dut):
    """Reset circuit."""
    dut.rst.value = 0
    await Timer(5, units='ns')
    dut.rst.value = 1
    dut._log.info("Reset complete")

#-------------------------------- Driving Inputs ------------------------------#

async def drive_inputs(dut, dividend, divisor):
    """Drive inputs to the DUT."""
    dut.dividend.value = dividend
    dut.divisor.value = divisor
    dut.src_valid.value = 1
    await RisingEdge(dut.clk)
    dut.src_valid.value = 0

    while (dut.dest_valid.value == 0):
        await RisingEdge(dut.clk)

    dut.dest_ready.value = 1
    await RisingEdge(dut.clk)
    dut.dest_ready.value = 0
    await RisingEdge(dut.clk)

#------------------------------ Monitoring Outputs ----------------------------#

async def monitor_outputs(dut, dividend, divisor):
    """Monitor outputs"""
    exp_quotient = dividend // divisor
    exp_remainder = dividend % divisor

    while not dut.dest_valid.value:
        await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)

    quotient = int(dut.quotient.value)
    remainder = int(dut.remainder.value)

    if exp_quotient != quotient or exp_remainder != remainder:
        dut._log.error(f"Test Fail: Expected quotient: {exp_quotient},Got quotient: {quotient}; "
                       f" Expected remainder: {exp_remainder}, remainder: {remainder}")
    else:
        dut._log.info("Test Pass")

#----------------------------------- Testing ----------------------------------#

@cocotb.test()
async def tb(dut):
    """Test restoring division algorithm."""

    WIDTH = 16                                   # Width Of Inputs
    Number_of_Tests = 300                        # Number Of Tests Cases
    cocotb.start_soon(clock_gen(dut))
    await reset_circuit(dut)
    dut.dest_ready.value = 0

    # Direct Test
    dividend = 0
    divisor = 1
    drive_task = cocotb.start_soon(drive_inputs(dut, dividend, divisor))
    monitor_task = cocotb.start_soon(monitor_outputs(dut, dividend, divisor))
    await drive_task
    await monitor_task

    # Random Test
    for i in range(Number_of_Tests):
        dividend = random.randint(0,(2**WIDTH)-1)
        divisor = random.randint(1,(2**WIDTH)-1)

        drive_task = cocotb.start_soon(drive_inputs(dut, dividend, divisor))
        monitor_task = cocotb.start_soon(monitor_outputs(dut, dividend, divisor))
        await drive_task
        await monitor_task

    dut._log.info("Test completed")
