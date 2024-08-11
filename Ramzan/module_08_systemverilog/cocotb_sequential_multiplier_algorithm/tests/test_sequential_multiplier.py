import cocotb
from cocotb.regression import TestFactory
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from cocotb.result import TestFailure

@cocotb.coroutine
async def reset_dut(dut):
    """Reset the DUT."""
    dut.RST <= 0
    await Timer(2, units="ns")
    dut.RST <= 1
    await Timer(2, units="ns")

@cocotb.coroutine
async def drive_input(dut, A, B):
    """Drive inputs to the DUT."""
    dut.A <= A
    dut.B <= B
    dut.src_valid_in <= 1
    await RisingEdge(dut.CLK)
    dut.src_valid_in <= 0

@cocotb.coroutine
async def check_output(dut, A, B):
    """Check the output of the DUT."""
    expected_product = A * B

    # Wait for the DUT to process the inputs
    await Timer(17, units="ns")  # Adjust timing if needed

    # Check the output
    if int(dut.PRODUCT) == expected_product:
        dut._log.info(f"Test Passed: A = {int(dut.A)}, B = {int(dut.B)}, PRODUCT = {int(dut.PRODUCT)}")
    else:
        raise TestFailure(f"Test Failed: A = {int(dut.A)}, B = {int(dut.B)}, "
                          f"Expected PRODUCT = {expected_product}, Got PRODUCT = {int(dut.PRODUCT)}")

@cocotb.coroutine
async def monitor_src_valid_in(dut):
    """Monitor and control the src_valid_in signal."""
    while True:
        await RisingEdge(dut.CLK)
        if dut.src_ready_in:
            dut.src_valid_in <= 0

@cocotb.coroutine
async def monitor_dist_ready_out(dut):
    """Monitor and control the dist_ready_out signal."""
    while True:
        await RisingEdge(dut.CLK)
        if dut.dist_valid_out:
            dut.dist_ready_out <= 0

@cocotb.test()
async def sequential_multiplier_test(dut):
    """Test sequence for the sequential_multiplier."""
    # Generate clock
    cocotb.fork(clock_gen(dut.CLK))
    
    # Reset DUT
    await reset_dut(dut)

    # Fork tasks for monitoring signals
    cocotb.fork(monitor_src_valid_in(dut))
    cocotb.fork(monitor_dist_ready_out(dut))

    # Test cases
    await drive_input(dut, 16, 2)
    await check_output(dut, 16, 2)
    
    await drive_input(dut, 5, 10)
    await check_output(dut, 5, 10)
    
    await drive_input(dut, 1024, 3)
    await check_output(dut, 1024, 3)
    
    # Additional test cases can be added here

@cocotb.coroutine
async def clock_gen(signal):
    """Clock generator."""
    while True:
        signal <= 0
        await Timer(10, units="ns")
        signal <= 1
        await Timer(10, units="ns")

