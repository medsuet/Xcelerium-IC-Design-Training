import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from cocotb.regression import TestFactory
import random

# Clock generator
async def clock_gen(clk):
    """Generate clock pulses"""
    while True:
        clk.value = 0
        await Timer(5, units='ns')
        clk.value = 1
        await Timer(5, units='ns')

# Monitor task
async def monitor_output(dut):
    """Monitor output and compare with reference product"""
    while True:
        await RisingEdge(dut.rst)
        await RisingEdge(dut.clk)

        await FallingEdge(dut.rst)
        await RisingEdge(dut.clk)

        await RisingEdge(dut.start)
        await RisingEdge(dut.clk)

        await FallingEdge(dut.start)

        ref_product = int(dut.A.value.signed_integer * dut.B.value.signed_integer)
        while (dut.done.value==0):
            await RisingEdge(dut.clk)
        
        a_signed = await to_signed(int(dut.A.value), 16)
        b_signed = await to_signed(int(dut.B.value), 16)
        p_signed = await to_signed(int(dut.product.value), 32)
        if p_signed == ref_product:
            dut._log.info(f"Passed: A = {a_signed}, B = {b_signed}, Product = {p_signed}")
        else:
            dut._log.error(f"Test failed: A = {a_signed}, B = {b_signed}, Expected Product = {ref_product}, Got Product = {p_signed}")
        await RisingEdge(dut.clk)

# Random test cases
async def random_test(dut):
    num_tests = 100
    for _ in range(num_tests):
        dut.rst.value =1
        await RisingEdge(dut.clk)

        dut.rst.value =0
        await RisingEdge(dut.clk)
        
        dut.A.value = random.randint(-32768, 32767)
        dut.B.value = random.randint(-32768, 32767)
        dut.start.value = 1
        await RisingEdge(dut.clk)
        dut.start.value = 0
        
        while (dut.done.value==0):
            await RisingEdge(dut.clk)
        await RisingEdge(dut.clk)  # Delay between tests
        

async def to_signed(value, width):
    signed_value = value if value < (1 << (width - 1)) else value - (1 << width)
    return signed_value

# Directed test cases
async def driver(dut, A_in, B_in):
    dut.rst.value =1
    await RisingEdge(dut.clk)

    dut.rst.value =0
    await RisingEdge(dut.clk)

    dut.A.value=A_in
    dut.B.value=B_in

    dut.start.value=1
    await RisingEdge(dut.clk)
    dut.start.value=0

    while(dut.done.value==0):
        await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)  # Delay between tests

# Top-level test
@cocotb.test()
async def top_test(dut):
    """Top-level test"""
    cocotb.start_soon(clock_gen(dut.clk))  # Start the clock generator
    cocotb.start_soon(monitor_output(dut))  # Start the monitor

    # Run random test cases
    await random_test(dut)
    
    # Directed test cases
    await driver(dut, 0, 0)  # Both inputs are zero
    await driver(dut, 1, 3)  # One input is one
    await driver(dut, 3, -1)  # One input is negative one
    await driver(dut, 32767, 32767)  # Both are maximum numbers
    await driver(dut, -32768, -32768)  # Both are maximum negative numbers
