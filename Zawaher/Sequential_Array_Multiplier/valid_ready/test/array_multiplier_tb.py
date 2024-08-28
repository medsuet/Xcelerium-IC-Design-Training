import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer
import random

# Define the reset sequence
async def reset_sequence(dut):
    """Applying the Reset"""
    dut.reset.value = 1
    dut.dst_ready.value = 0
    await RisingEdge(dut.clk)
    dut.reset.value = 0
    await RisingEdge(dut.clk)
    dut.reset.value = 1
    await RisingEdge(dut.clk)

# Apply random inputs to the DUT
async def apply_inputs(dut):
    """Apply random inputs to DUT"""
    dut.multiplicand.value = random.randint(0, (1 << 16) - 1)
    dut.multiplier.value = random.randint(0, (1 << 16) - 1)  # Avoid zero divisor

# Driver function to apply inputs and assert valid
async def driver(dut):
    """Drive the inputs"""
    await apply_inputs(dut)
    dut.valid_src.value = 1
    await RisingEdge(dut.clk)
    dut.valid_src.value = 0
    await RisingEdge(dut.clk)  # Wait for one more clock to settle

# Monitor function to check outputs
async def monitor(dut):
    """Monitor the DUT and check results."""
    # Wait untill the valid_out got high
    while (dut.dst_valid.value == 0):
        await RisingEdge(dut.clk)
                                                    
    expected_product = int(dut.multiplier.value) * int(dut.multiplicand.value)
        
    # Compare the expected and actual outputs
    if int(dut.product.value) == expected_product:
            print("================= Test Passed ================")
            print(f"Multiplier: {int(dut.multiplier.value)} | Multiplicand: {int(dut.multiplicand.value)} | Product: {int(dut.product.value)}")
    else:
            print("================== Test Failed ================")
            print(f"Multiplier: {int(dut.multiplier.value)} | Multiplicand: {int(dut.multiplicand.value)}")
            print(f"Expected {int(expected_product)}, got {int(dut.product.value)}")


async def apply_dst_redy(dut):
    await RisingEdge(dut.clk)
    dut.dst_ready.value = 1
    await RisingEdge(dut.clk)
    dut.dst_ready.value = 0
    await RisingEdge(dut.clk)

        
@cocotb.test()
async def array_multiplier_tb(dut):
    """Testbench for array_multiplier"""
    # Start the clock
    cocotb.start_soon(Clock(dut.clk, 5, units='ns').start())

    # Apply the reset sequence
    await reset_sequence(dut)


    # Apply inputs and check outputs in a loop
    for _ in range(10):
        await driver(dut)  # Apply new inputs
        await monitor(dut)
        await apply_dst_redy(dut)

