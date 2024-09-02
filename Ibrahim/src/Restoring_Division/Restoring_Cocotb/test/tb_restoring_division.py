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
    """Initializing the values and applying reset."""
    dut.rst_n.value = 1
    dut.dividend.value = 0
    dut.divisor.value = 0
    dut.dest_ready.value = 0
    dut.src_valid.value = 0
    await RisingEdge(dut.clk)
    dut.rst_n.value = 0
    await RisingEdge(dut.clk)
    dut.rst_n.value = 1
    dut._log.info("Reset sequence complete")

@cocotb.coroutine
async def drive_inputs(dut, in1, in2):
    """
    Task for driving inputs in cocotb.

    Args:
        dut: The device under test.
        in1: The first input (dividend).
        in2: The second input (divisor).
    """
    # Assign input to dividend and divisor
    dut.dividend = in1
    dut.divisor = in2
    dut.src_valid = 1  # Assert src_valid signal

    # Wait for a positive clock edge
    await RisingEdge(dut.clk)

    # Wait for src_ready signal
    while not dut.src_ready.value:
        await RisingEdge(dut.clk)
    
    # Deassert src_valid signal
    dut.src_valid = 0

    # Wait for dest_valid signal
    while not dut.dest_valid.value:
        await RisingEdge(dut.clk)

    # Assert dest_ready signal
    dut.dest_ready = 1

    # Wait for a positive clock edge
    await RisingEdge(dut.clk)

    # Deassert dest_ready signal
    dut.dest_ready = 0

@cocotb.coroutine
async def monitor_outputs(dut, a, b, pass_count, fail_count):
    """
    Monitor the outputs and verify the quotient and remainder.

    Args:
        dut: The device under test.
        a: The dividend.
        b: The divisor.
        pass_count: A list with one element to keep track of the number of passed tests.
        fail_count: A list with one element to keep track of the number of failed tests.
    """
    # Wait until both dest_ready and dest_valid signals are asserted
    while not ((dut.dest_ready.value) & (dut.dest_valid.value)):
        await RisingEdge(dut.clk)

    # Read the actual quotient and remainder from the DUT
    actual_quotient  = int(dut.quotient)
    actual_remainder = int(dut.remainder)

    # Calculate the expected quotient and remainder using Python's integer division and modulo
    exp_quotient     = a // b
    exp_remainder    = a % b

    # Compare the actual and expected results
    if ((actual_quotient == exp_quotient) & (actual_remainder == exp_remainder)):
        # If they match, increment the pass count and log a passing message
        pass_count[0] += 1
        dut._log.info("Test Passed")
        # dut._log.info(f"Test passed: dividend={int(dut.dividend)}, divisor={int(dut.divisor)}, quotient={actual_quotient}, exp_quotient={exp_quotient}, remainder={actual_remainder}, exp_remainder={exp_remainder}")
    else:
        # If they do not match, increment the fail count and log an error message
        fail_count[0] += 1
        dut._log.error(f"Test failed: dividend={int(dut.dividend)}, divisor={int(dut.divisor)}, quotient={actual_quotient}, exp_quotient={exp_quotient}, remainder={actual_remainder}, exp_remainder={exp_remainder}")
    
    # Wait for the next rising edge of the clock before completing the coroutine
    await RisingEdge(dut.clk)

@cocotb.coroutine
async def random_delay(dut):
    """Random delay between 0 and 9 clock cycles."""
    delay_cycles = random.randint(0, 9)
    for _ in range(delay_cycles):
        await RisingEdge(dut.clk)

@cocotb.coroutine
async def pass_inputs(dut, in1, in2, pass_count, fail_count):
    """
    Task to pass inputs and monitor outputs.

    Args:
        dut: The device under test.
        in1: The first input (dividend).
        in2: The second input (divisor).
        pass_count: A list with one element to keep track of the number of passed tests.
        fail_count: A list with one element to keep track of the number of failed tests.
    """
    # Run drive_inputs and monitor_outputs concurrently
    drive_task = cocotb.start_soon(drive_inputs(dut, in1, in2))
    monitor_task = cocotb.start_soon(monitor_outputs(dut, in1, in2, pass_count, fail_count))

    # Wait for both tasks to complete
    await drive_task
    await monitor_task

    # Add a random delay between tests
    await random_delay(dut)

@cocotb.test()
async def tb_restoring_division(dut):
    """Main test for Restoring Divider."""
    pass_count = [0]
    fail_count = [0]
    cocotb.start_soon(clock_gen(dut))

    await reset_sequence(dut)
    
    # Directed test
    a = 1
    b = 65535
    dut._log.info(f"Testing with random A = {a}, B = {b}")
    await pass_inputs(dut, a, b, pass_count, fail_count)

    
    # Random testing
    for _ in range(100000):
        a = random.randint(0, 65535)
        b = random.randint(1, 65535)
        dut._log.info(f"Testing with random A = {a}, B = {b}")
        await pass_inputs(dut, a, b, pass_count, fail_count)

    # Final results
    dut._log.info(f"Total tests passed: {pass_count[0]}")
    dut._log.info(f"Total tests failed: {fail_count[0]}")
