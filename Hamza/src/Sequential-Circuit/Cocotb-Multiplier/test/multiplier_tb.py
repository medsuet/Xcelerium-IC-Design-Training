import cocotb
from cocotb.triggers import RisingEdge, Timer
import random

# Function to convert an integer to a signed value of a given bit width
def to_signed(val, bits):
    mask = 1 << (bits - 1)
    return (val & (mask - 1)) - (val & mask)


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
    dut.Multiplicand.value = 0
    dut.Multiplier.value = 0
    dut.rst.value = 0
    dut.start.value = 0
    await RisingEdge(dut.clk)
    dut.rst.value = 1

@cocotb.coroutine
async def driver(dut, in1, in2):
    """Drive inputs."""
    dut.Multiplicand.value = in1
    dut.Multiplier.value = in2
    dut.start.value = 1
    await RisingEdge(dut.clk)
    dut.start.value = 0
    while not dut.ready.value:
        await RisingEdge(dut.clk)

@cocotb.coroutine
async def monitor(dut, exp):
    """Monitor outputs."""
    await RisingEdge(dut.ready)
    actual = to_signed(int(dut.Product), 32)
    if actual != exp:
        dut._log.info(f"Test failed: A={to_signed(int(dut.Multiplicand), 16)}, B={to_signed(int(dut.Multiplier), 16)}, Product={actual}, Expected={exp}")
    else:
        dut._log.info(f"Test passed: A={to_signed(int(dut.Multiplicand), 16)}, B={to_signed(int(dut.Multiplier), 16)}, Product={actual}, Expected={exp}")

@cocotb.test()
async def multiplier_tb(dut):
    """Main test for Sequential Multiplier."""
    cocotb.start_soon(clock_gen(dut))

    await reset_sequence(dut)

    # Directed testing
    for i in range(400):
        a = to_signed(101*i, 16)
        b = to_signed(10+i, 16)
        exp = a * b
        dut._log.info(f"Testing with A = {a}, B = {b}")
        drive_task = cocotb.start_soon(driver(dut, a, b))
        monitor_task = cocotb.start_soon(monitor(dut, exp))
        await drive_task
        await monitor_task

    # Random testing
    for _ in range(400):
        a = random.randint(-32768, 32767)
        b = random.randint(-32768, 32767)
        exp = a * b
        dut._log.info(f"Testing with random A = {a}, B = {b}")
        drive_task = cocotb.start_soon(driver(dut, a, b))
        monitor_task = cocotb.start_soon(monitor(dut, exp))
        await drive_task
        await monitor_task