import cocotb
import random
from cocotb.triggers import RisingEdge, Timer

#Function to generate forever clk
async def clk_gen(dut):
    while True:
        dut.clk.value = 0
        await Timer(1, units="ns")
        dut.clk.value = 1
        await Timer(1, units="ns")
#Function to convert unsigned product to signed
async def to_signed(value, width):
    signed_value = value if value < (1 << (width - 1)) else value - (1 << width)
    return signed_value


async def run_test(dut, a_val, b_val, expected_result):
    dut.A.value = a_val
    dut.B.value = b_val
    await RisingEdge(dut.clk)
    dut.start.value = 1
    await RisingEdge(dut.clk)
    dut.start.value = 0

    while dut.ready.value == 0:
        await RisingEdge(dut.clk)
    
    a_signed = await to_signed(int(dut.A.value), 16)
    b_signed = await to_signed(int(dut.B.value), 16)
    p_signed = await to_signed(int(dut.P.value), 32)

    # Check the result
    if p_signed == expected_result:
        dut._log.info(f"Passed: A = {a_signed}, B = {b_signed}, Product = {p_signed}")
        return True
    else:
        dut._log.info(f"Failed: A = {a_signed}, B = {b_signed}, Expected = {expected_result}, Got = {p_signed}")
        return False

@cocotb.test()
async def directed_tests(dut):
    await cocotb.start(clk_gen(dut))
    dut.reset.value = 1
    dut.start.value = 0
    dut.A.value = 0
    dut.B.value = 0
    await RisingEdge(dut.clk)
    dut.reset.value = 0

    pass_count = 0
    fail_count = 0

    # Directed tests
    directed_cases = [(-3, 0, 0), (4, -2, -8), (7, 6, 42), (-5, -5, 25)]
    
    for a, b, expected in directed_cases:
        result = await run_test(dut, a, b, expected)
        if result:
            pass_count += 1
        else:
            fail_count += 1
    
    dut._log.info(f"Directed tests completed. Passed: {pass_count}, Failed: {fail_count}")

#Random Tests
@cocotb.test()
async def random_tests(dut):
    await cocotb.start(clk_gen(dut))
    dut.reset.value = 1
    dut.start.value = 0
    dut.A.value = 0
    dut.B.value = 0
    await RisingEdge(dut.clk)
    dut.reset.value = 0

    pass_count = 0
    fail_count = 0
    num_tests = 10000
    
    for _ in range(num_tests):
        a = random.randint(-32768, 32767)
        b = random.randint(-32768, 32767)
        expected_result = a * b
        result = await run_test(dut, a, b, expected_result)
        if result:
            pass_count += 1
        else:
            fail_count += 1

    dut._log.info(f"Random tests completed. Passed: {pass_count}, Failed: {fail_count}")





    
