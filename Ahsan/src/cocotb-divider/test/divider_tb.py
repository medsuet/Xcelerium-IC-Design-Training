import cocotb
from cocotb.triggers import RisingEdge, Timer
import random


@cocotb.coroutine
async def clock_gen(dut):
    """Clock generation."""
    while True:
        dut.clk.value = 0
        await Timer(5, units='ns')
        dut.clk.value = 1
        await Timer(5, units='ns')

@cocotb.coroutine
async def reset_sequence(dut):
    """Reset sequence."""
    dut.divident.value = 0
    dut.divisor.value = 0
    dut.rst.value = 0
    dut.start.value = 0
    await RisingEdge(dut.clk)
    dut.rst.value = 1

@cocotb.coroutine
async def drive_inputs(dut, in1, in2):
    """Drive inputs."""
    dut.divident.value = in1
    dut.divisor.value = in2
    dut.start.value = 1
    await RisingEdge(dut.clk)
    dut.start.value = 0
    while not dut.ready.value:
        await RisingEdge(dut.clk)

@cocotb.coroutine
async def monitor_outputs(dut, exp_remain,exp_quot):
    """Monitor outputs."""
    await RisingEdge(dut.ready)
    actual_remain = int(dut.remainder)
    actual_quot = int(dut.quotient)
    if ((actual_remain == exp_remain) and (actual_quot == exp_quot)):
        dut._log.info(f"Test passed")
    else:
        dut._log.error(f"Test failed")

@cocotb.test()
async def test_seq_mul(dut):
    """Main test for Sequential Multiplier."""
    cocotb.start_soon(clock_gen(dut))

    await reset_sequence(dut)

    # Directed testing
    for i in range(400):
        a = (10*i)
        b = (1+i)
        exp_remain =  int(a % b)
        exp_quot   = int(a / b)
        dut._log.info(f"Testing with A = {a}, B = {b}")
        drive_task = cocotb.start_soon(drive_inputs(dut, a, b))
        monitor_task = cocotb.start_soon(monitor_outputs(dut, exp_remain,exp_quot))
        await drive_task
        await monitor_task

    # Random testing
    for i in range(400000):
        a = random.randint(0, 32767)
        b = random.randint(1, 32767)
        exp_remain = int(a % b)
        exp_quot   = int(a / b)
        dut._log.info(f"Testing with random A = {a}, B = {b}")
        drive_task = cocotb.start_soon(drive_inputs(dut, a, b))
        monitor_task = cocotb.start_soon(monitor_outputs(dut, exp_remain,exp_quot))
        await drive_task
        await monitor_task
