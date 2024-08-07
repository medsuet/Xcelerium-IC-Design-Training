import cocotb
from cocotb.triggers import RisingEdge, Timer, Join, Combine
# from cocotb.regression import TestFactory
import random

# Clock generation
async def clock_gen(dut):
    """Clock generation."""
    while True:
        dut.clk.value = 0
        await Timer(5, units='ns')
        dut.clk.value = 1
        await Timer(5, units='ns')

#reset circuit
async def reset_circuit(dut):
    """Reset circuit."""
    dut.rst.value = 0
    await Timer(5, units='ns')
    dut.rst.value = 1
    dut._log.info("Reset complete")

#driving inputs
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

#monitoring outputs
async def monitor_outputs(dut, exp_quotient, exp_remainder):
    """Monitor outputs"""
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

@cocotb.test()
async def tb(dut):
    """Test restoring division algorithm."""

    cocotb.start_soon(clock_gen(dut))

    await reset_circuit(dut)
    
    dut.dest_ready.value = 0

    for i in range(300):
        dividend = random.randint(0,65000)
        divisor = random.randint(1,65000)
        exp_quotient = dividend // divisor
        exp_remainder = dividend % divisor

        drive_task = cocotb.start_soon(drive_inputs(dut, dividend, divisor))
        monitor_task = cocotb.start_soon(monitor_outputs(dut, exp_quotient, exp_remainder))
        await drive_task
        await monitor_task

    dut._log.info("Test completed")
