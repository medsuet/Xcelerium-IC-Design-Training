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
    dut.Multiplicand.value = 0
    dut.Multiplier.value = 0
    dut.rst.value = 0
    dut.start.value = 0
    await RisingEdge(dut.clk)
    dut.rst.value = 1
    dut._log.info("Reset sequence complete")
    

# Function to convert an integer to a signed value of a given bit width
def to_signed(val, bits):
    mask = 1 << (bits - 1)
    return (val & (mask - 1)) - (val & mask)

@cocotb.coroutine
async def drive_inputs(dut, in1, in2):
    """Drive inputs."""
    dut.Multiplicand.value = in1
    dut.Multiplier.value = in2
    dut.start.value = 1
    await RisingEdge(dut.clk)
    dut.start.value = 0
    while not dut.ready.value:
        await RisingEdge(dut.clk)
    # dut._log.info(f"Inputs driven: Multiplicand={in1}, Multiplier={in2}")

@cocotb.coroutine
async def monitor_outputs(dut, a, b, pass_count, fail_count):
    """Monitor outputs."""
    while not dut.ready.value:
        await RisingEdge(dut.clk)
    actual = to_signed(int(dut.Product), 32)
    exp = a * b
    if actual == exp:
        pass_count[0] += 1
        dut._log.info(f"Test passed: Multiplicand={to_signed(int(dut.Multiplicand),16)}, Multiplier={to_signed(int(dut.Multiplier),16)}, Product={actual}, Expected={exp}")
    else:
        fail_count[0] += 1
        dut._log.error(f"Test failed: Multiplicand={to_signed(int(dut.Multiplicand),16)}, Multiplier={to_signed(int(dut.Multiplier),16)}, Product={actual}, Expected={exp}")
    await RisingEdge(dut.clk)

@cocotb.test()
async def tb_seq_multiplier(dut):
    """Main test for Sequential Multiplier."""
    pass_count = [0]
    fail_count = [0]
    cocotb.start_soon(clock_gen(dut))

    await reset_sequence(dut)

    # Random testing
    for _ in range(10000):
        a = random.randint(-32767, 32767)
        b = random.randint(-32767, 32767)
        dut._log.info(f"Testing with random A = {a}, B = {b}")
        drive_task = cocotb.start_soon(drive_inputs(dut, a, b))
        monitor_task = cocotb.start_soon(monitor_outputs(dut, a, b, pass_count, fail_count))
        await drive_task
        await monitor_task

    # Final results
    dut._log.info(f"Total tests passed: {pass_count[0]}")
    dut._log.info(f"Total tests failed: {fail_count[0]}")
