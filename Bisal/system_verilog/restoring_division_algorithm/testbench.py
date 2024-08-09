import cocotb
import random
from cocotb.triggers import RisingEdge, Timer

# Function to generate forever clk
async def clk_gen(dut):
    while True:
        dut.clk.value = 0
        await Timer(1, units="ns")
        dut.clk.value = 1
        await Timer(1, units="ns")

# Function to run the division test
async def run_division_test(dut, dividend, divisor, expected_quotient, expected_remainder):
    dut.Q.value = dividend
    dut.M.value = divisor
    dut.src_valid.value = 1

    # Wait for the source to be ready
    await RisingEdge(dut.src_ready)

    # Start the operation
    dut.src_valid.value = 1
    dut.dst_ready.value = 1
    
    # Wait until the destination is valid
    while dut.dst_valid.value == 0:
        await RisingEdge(dut.clk)

    # Check the result
    quotient = int(dut.Quotient.value)
    remainder = int(dut.Remainder.value)
    
    if quotient == expected_quotient and remainder == expected_remainder:
        dut._log.info(f"Passed: Dividend = {dividend}, Divisor = {divisor}, Quotient = {quotient}, Remainder = {remainder}")
        return True
    else:
        dut._log.info(f"Failed: Dividend = {dividend}, Divisor = {divisor}, Expected Quotient = {expected_quotient}, Got = {quotient}, Expected Remainder = {expected_remainder}, Got = {remainder}")
        return False

@cocotb.test()
async def directed_tests(dut):
    await cocotb.start(clk_gen(dut))
    dut.reset.value = 1
    dut.src_valid.value = 0
    dut.dst_ready.value = 0
    await RisingEdge(dut.clk)
    dut.reset.value = 0

    pass_count = 0
    fail_count = 0

    # Directed tests
    directed_cases = [
        (11, 3, 3, 2),  
        (20, 4, 5, 0),   
        (15, 2, 7, 1),  
        (100, 10, 10, 0) 
    ]
    
    for dividend, divisor, expected_quotient, expected_remainder in directed_cases:
        result = await run_division_test(dut, dividend, divisor, expected_quotient, expected_remainder)
        if result:
            pass_count += 1
        else:
            fail_count += 1
    
    dut._log.info(f"Directed tests completed. Passed: {pass_count}, Failed: {fail_count}")

# Random Tests
@cocotb.test()
async def random_tests(dut):
    await cocotb.start(clk_gen(dut))
    dut.reset.value = 1
    dut.src_valid.value = 0
    dut.dst_ready.value = 0
    await RisingEdge(dut.clk)
    dut.reset.value = 0

    pass_count = 0
    fail_count = 0
    num_tests = 100000
    
    for _ in range(num_tests):
        dividend = random.randint(1, 1000)
        divisor = random.randint(1, 100)
        expected_quotient = dividend // divisor
        expected_remainder = dividend % divisor
        result = await run_division_test(dut, dividend, divisor, expected_quotient, expected_remainder)
        if result:
            pass_count += 1
        else:
            fail_count += 1

    dut._log.info(f"Random tests completed. Passed: {pass_count}, Failed: {fail_count}")
