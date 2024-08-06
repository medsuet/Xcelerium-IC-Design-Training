import cocotb
from cocotb.triggers import RisingEdge, Timer
import random

async def clock_gen(dut):
    """Clock generation."""
    while True:
        dut.clk.value = 0
        await Timer(5, units='ns')
        dut.clk.value = 1
        await Timer(5, units='ns')

async def reset_sequence(dut):
    """Reset sequence."""
    dut.rst.value = 0
    await RisingEdge(dut.clk)
    dut.rst.value = 1
    dut._log.info("Reset sequence complete")

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

async def monitor_outputs(dut, exp, a, b):
    """Monitor outputs."""
    while not dut.dest_ready.value:
        await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    actual = int(dut.product)

    if actual != exp:
        dut._log.info(f"Test failed exp: {exp}, actual: {actual}, a: {a}, b: {b}")
    else:
        dut._log.info("Test passed")

@cocotb.test()
async def test_seq_mul(dut):
    """Main test for Sequential Multiplier."""
    cocotb.start_soon(clock_gen(dut))

    await reset_sequence(dut)
    dut.dest_ready.value = 0

    dut._log.info("Testing")

    for i in range(1000):
        a = i
        b = i
        exp = a * b
        drive_task = cocotb.start_soon(drive_inputs(dut, a, b))
        monitor_task = cocotb.start_soon(monitor_outputs(dut, exp, a, b))
        await drive_task
        await monitor_task
