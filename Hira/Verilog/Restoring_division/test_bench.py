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

async def to_signed(value, width):
    signed_value = value 
    return signed_value


async def random_testing(dut):
    num_test_cases=20000
    for i in range(0,num_test_cases):
        dut.rst.value =1
        await RisingEdge(dut.clk)

        dut.rst.value =0
        await RisingEdge(dut.clk)
        dut.dividend.value=random.randint(0, 32767)
        dut.divisor.value=random.randint(0, 32767)

        dut.src_valid.value=1
        dut.dd_ready.value=1

        while(dut.src_ready.value==0):
            await RisingEdge(dut.clk)
        await RisingEdge(dut.clk)
        dut.src_valid.value=0

        while(dut.dd_valid.value==0):
            await RisingEdge(dut.clk)

        dividend = await to_signed(int(dut.dividend.value), 32)
        divisor = await to_signed(int(dut.divisor.value), 32)
        remainder = await to_signed(int(dut.remainder.value), 32)  
        quotient  = await to_signed(int(dut.quotient.value), 32)
        ref_quotient= dividend // divisor
        ref_remainder=dividend %divisor

        if (remainder==ref_remainder and quotient==ref_quotient):
            dut._log.info(f"Test_case Passed")
        else:
            dut._log.info(f"failed: dividend = {dividend}, divisior = {divisor}, expected= {ref_remainder},got_remainder = {remainder}, expected={ref_quotient} got_Qutient = {quotient}")
        await RisingEdge(dut.clk)  # Delay between tests
    

    # Directed test cases
async def driver(dut, dividend_in, divisor_in):
    dut.rst.value =1
    await RisingEdge(dut.clk)

    dut.rst.value =0
    await RisingEdge(dut.clk)

    dut.dividend.value=dividend_in
    dut.divisor.value=divisor_in

    dut.src_valid.value=1
    dut.dd_ready.value=1

    while(dut.src_ready.value==0):
        await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    dut.src_valid.value=0

    while(dut.dd_valid.value==0):
        await RisingEdge(dut.clk)

    dividend = await to_signed(int(dut.dividend.value), 32)
    divisor = await to_signed(int(dut.divisor.value), 32)
    remainder = await to_signed(int(dut.remainder.value), 32)  
    quotient  = await to_signed(int(dut.quotient.value), 32)


    dut._log.info(f"Passed: dividend = {dividend}, divisior = {divisor}, remainder = {remainder} , Qutient = {quotient}")
    await RisingEdge(dut.clk)  # Delay between tests

# Top-level test
@cocotb.test()
async def top_test(dut):
    """Top-level test"""
    cocotb.start_soon(clock_gen(dut.clk))  # Start the clock generator
    await random_testing(dut)

    
    # Directed test cases
    await driver(dut, 100, 3)  # Both inputs are zero
    await driver(dut, 3, 1)  # One input is one
    await driver(dut, 75,35)  # Both inputs are zero
    await driver(dut, 3, -1)  # One input is negative one
    await driver(dut, 32767, 32767)  # Both are maximum numbers
    await driver(dut, -32768, -32768)  # Both are maximum negative numbers