import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer
import random

# Helper function to generate clock
async def clock_gen(clk, period=10):
    """ Clock generation with a period of 10 time units """
    while True:
        clk.value = 0
        await Timer(period / 2, units='ns')
        clk.value = 1
        await Timer(period / 2, units='ns')

@cocotb.test()
async def sequential_divider_tb(dut):
    # Clock generation
    cocotb.start_soon(clock_gen(dut.clk))

    # Reset the DUT
    await rst(dut, 100)

    # Directed tests
    await directed_test(dut, 2, 3)
    dut._log.info(f"Divisor: {dut.Divisor.value.integer} Dividend: {dut.Dividend.value.integer} Quotient: {dut.Quotient.value.integer} Remainder: {dut.Remainder.value.integer}")
    await directed_test(dut, 2, 0)
    dut._log.info(f"Divisor: {dut.Divisor.value.integer} Dividend: {dut.Dividend.value.integer} Quotient: {dut.Quotient.value.integer} Remainder: {dut.Remainder.value.integer}")
    await directed_test(dut, 4, 6)
    dut._log.info(f"Divisor: {dut.Divisor.value.integer} Dividend: {dut.Dividend.value.integer} Quotient: {dut.Quotient.value.integer} Remainder: {dut.Remainder.value.integer}")
    await directed_test(dut, 12, 3)
    dut._log.info(f"Divisor: {dut.Divisor.value.integer} Dividend: {dut.Dividend.value.integer} Quotient: {dut.Quotient.value.integer} Remainder: {dut.Remainder.value.integer}")
    await directed_test(dut, 15, 5)
    dut._log.info(f"Divisor: {dut.Divisor.value.integer} Dividend: {dut.Dividend.value.integer} Quotient: {dut.Quotient.value.integer} Remainder: {dut.Remainder.value.integer}")
    await directed_test(dut, 8, 9)
    dut._log.info(f"Divisor: {dut.Divisor.value.integer} Dividend: {dut.Dividend.value.integer} Quotient: {dut.Quotient.value.integer} Remainder: {dut.Remainder.value.integer}")
    await directed_test(dut, 1, 32767)
    dut._log.info(f"Divisor: {dut.Divisor.value.integer} Dividend: {dut.Dividend.value.integer} Quotient: {dut.Quotient.value.integer} Remainder: {dut.Remainder.value.integer}")
    await directed_test(dut, 1, 2**16-1)
    dut._log.info(f"Divisor: {dut.Divisor.value.integer} Dividend: {dut.Dividend.value.integer} Quotient: {dut.Quotient.value.integer} Remainder: {dut.Remainder.value.integer}")
    await directed_test(dut, 0, 2**16-1)
    dut._log.info(f"Divisor: {dut.Divisor.value.integer} Dividend: {dut.Dividend.value.integer} Quotient: {dut.Quotient.value.integer} Remainder: {dut.Remainder.value.integer}")
    


    # Random tests
    # Fork driver and monitor tasks
    driver_handle = cocotb.start_soon(driver(dut))
    monitor_handle = cocotb.start_soon(monitor(dut))

    # Wait for both tasks to complete
    await cocotb.triggers.Combine(driver_handle.join(), monitor_handle.join())

    dut._log.info("Driver and monitor tasks have completed.") 

async def rst(dut, duration):
    """ Reset the DUT """
    dut.reset.value = 1
    await Timer(duration, units='ns')
    dut.reset.value = 0
    await Timer(duration, units='ns')
    dut.reset.value = 1

async def directed_test(dut, a, b):
    """ Directed test for verification """
    dut.Divisor.value = a
    dut.Dividend.value = b
    dut.src_valid.value = 1
    await RisingEdge(dut.clk)
    dut.src_valid.value = 0

    # Wait for dest_valid
    while not dut.dest_valid.value:
        await RisingEdge(dut.clk)

    # Assert dest_ready and check the result
    dut.dest_ready.value = 1
    await RisingEdge(dut.clk)
    dut.dest_ready.value = 0

async def driver(dut):
    """ Driver for random tests """
    for _ in range(200000):
        a = random.randint(0, 2**16-1)
        b = random.randint(0, 2**16-1)
        await directed_test(dut, a, b)
   
async def monitor(dut):
    """Monitor to check the output of the DUT."""
    # Pass Test Count
    count_pass = 0;
    for _ in range(200000):
        await FallingEdge(dut.src_valid)

        # Wait for valid and ready signals
        while (not dut.dest_valid.value and not dut.dest_ready.value):
            await RisingEdge(dut.clk)

        # Calculate expected remainder and quotient
        if dut.Divisor.value.integer != 0:
            expected_quotient = dut.Dividend.value.integer // dut.Divisor.value.integer
            expected_remiander = dut.Dividend.value.integer % dut.Divisor.value.integer
        else:
            expected_quotient = dut.Dividend.value.integer 
            expected_remiander = dut.Dividend.value.integer 
        
        await RisingEdge(dut.dest_ready)

        # Check the product against the expected value
        if (dut.Quotient.value.integer != expected_quotient) and (dut.Remainder.value.integer != expected_remiander):
            dut._log.error(f"Error: Expected Quotient {expected_quotient} Expected Remainder {expected_remiander}, but got Quotient {int(dut.Quotient.value.integer)} Remainder {int(dut.Remainder.value.integer)}")
        else:
            count_pass += 1
    dut._log.info(f"Test Passed: {count_pass}")
