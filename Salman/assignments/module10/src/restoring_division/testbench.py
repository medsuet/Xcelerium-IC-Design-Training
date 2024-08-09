import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, Combine
import random

simulator_run = True
count = 1000000
WIDTH = 16

# Clock generation
async def clock_gen(dut):
    while True:
        dut.clk.value = 0
        await Timer(10, units='ns')
        dut.clk.value = 1
        await Timer(10, units='ns')

# Reset sequence
async def reset_sequence(dut):
    await RisingEdge(dut.clk)
    dut.reset.value = 0
    dut.src_valid.value = 0
    dut.dst_ready.value = 0
    simulator_run = True
    await RisingEdge(dut.clk)
    dut.reset.value = 1

# Task to perform directed test
async def directed_test(dut, dividend_in, divisor_in):
    expected_quotient = int(dividend_in / divisor_in)
    expected_remainder = int(dividend_in % divisor_in)

    # Valid input
    await RisingEdge(dut.clk)
    dut.src_valid.value = 1
    dut.dividend.value = dividend_in
    dut.divisor.value = divisor_in

    # Wait for handshake to occur
    while dut.src_valid.value:
        await RisingEdge(dut.clk)

    # Wait for a valid output
    while not dut.dst_valid.value:
        await RisingEdge(dut.clk)

    dut.dst_ready.value = 1

    # Valid output at negedge of CLK
    await FallingEdge(dut.clk)

    assert dut.quotient.value.integer == expected_quotient, f"ERROR: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Expected Quotient={expected_quotient}, Got={dut.quotient.value.integer}"
    dut._log.info(f"QUOTIENT  PASS: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Quotient ={dut.quotient.value.integer}")

    assert dut.remainder.value.integer == expected_remainder, f"ERROR: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Expected Remainder={expected_remainder}, Got={dut.remainder.value.integer}"
    dut._log.info(f"REMAINDER PASS: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Remainder={dut.remainder.value.integer}")

    # Wait for handshake to occur
    while dut.dst_ready.value:
        await RisingEdge(dut.clk)

    await RisingEdge(dut.clk)

# Task to perform ready_before_valid test
async def ready_before_valid(dut, dividend_in, divisor_in):
    expected_quotient = int(dividend_in / divisor_in)
    expected_remainder = int(dividend_in % divisor_in)

    # Valid input after ready - ready before valid
    await RisingEdge(dut.clk)
    dut.src_valid.value = 1
    dut.dividend.value = dividend_in
    dut.divisor.value = divisor_in

    # Wait for handshake to occur
    while dut.src_valid.value:
        await RisingEdge(dut.clk)

    # Set ready as 1 after 14 edge of clock 'before valid output' - ready before valid
    for x in range (WIDTH-2):
        await RisingEdge(dut.clk)
    dut.dst_ready.value = 1

    # Wait for a valid output
    while not dut.dst_valid.value:
        await RisingEdge(dut.clk)

    assert dut.quotient.value.integer == expected_quotient, f"ERROR: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Expected Quotient={expected_quotient}, Got={dut.quotient.value.integer}"
    dut._log.info(f"QUOTIENT  PASS: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Quotient ={dut.quotient.value.integer}")

    assert dut.remainder.value.integer == expected_remainder, f"ERROR: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Expected Remainder={expected_remainder}, Got={dut.remainder.value.integer}"
    dut._log.info(f"REMAINDER PASS: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Remainder={dut.remainder.value.integer}")

    # Wait for handshake to occur
    while dut.dst_ready.value:
        await RisingEdge(dut.clk)

    await RisingEdge(dut.clk)

# Task to perform valid_before_ready test
async def valid_before_ready(dut, dividend_in, divisor_in):
    expected_quotient = int(dividend_in / divisor_in)
    expected_remainder = int(dividend_in % divisor_in)

    # Wait for handshake to occur
    while dut.src_valid.value:
        await RisingEdge(dut.clk)

    # Valid before ready
    for x in range (WIDTH-2):
        await RisingEdge(dut.clk)
    
    dut.dividend.value = dividend_in
    dut.divisor.value = divisor_in
    dut.src_valid.value = 1

    await RisingEdge(dut.clk)

    # Wait till handshake occurs
    while dut.src_valid.value:
        await RisingEdge(dut.clk)

    # Wait till a valid output comes
    while not dut.dst_valid.value:
        await RisingEdge(dut.clk)

    assert dut.quotient.value.integer == expected_quotient, f"ERROR: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Expected Quotient={expected_quotient}, Got={dut.quotient.value.integer}"
    dut._log.info(f"QUOTIENT  PASS: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Quotient ={dut.quotient.value.integer}")

    assert dut.remainder.value.integer == expected_remainder, f"ERROR: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Expected Remainder={expected_remainder}, Got={dut.remainder.value.integer}"
    dut._log.info(f"REMAINDER PASS: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Remainder={dut.remainder.value.integer}")

    # Delay - Valid before ready
    await Timer(30, units='ns')
    dut.dst_ready.value = 1

    # Wait for handshake to occur
    while dut.dst_ready.value:
        await RisingEdge(dut.clk)

    await RisingEdge(dut.clk)


# Task to perform valid_with_ready handshake test
async def valid_with_ready(dut, dividend_in, divisor_in):
    expected_quotient = int(dividend_in / divisor_in)
    expected_remainder = int(dividend_in % divisor_in)

    # Wait for prev ready to start - directed test in parallel
    while not dut.src_ready.value:
        await RisingEdge(dut.clk)

    # Wait for prev ready to end - directed test in parallel
    while dut.src_ready.value:
        await RisingEdge(dut.clk)

    # Wait for next ready to start - valid with ready
    await RisingEdge(dut.src_ready)

    dut.dividend.value = dividend_in
    dut.divisor.value = divisor_in
    dut.src_valid.value = 1

    # Wait for handshake to occur
    while dut.src_valid.value:
        await RisingEdge(dut.clk)

    # Wait for a valid output - valid with ready
    await RisingEdge(dut.dst_valid)
    dut.dst_ready.value = 1

    # Valid output at negedge of clock - due to delay
    await FallingEdge(dut.clk)

    assert dut.quotient.value.integer == expected_quotient, f"ERROR: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Expected Quotient={expected_quotient}, Got={dut.quotient.value.integer}"
    dut._log.info(f"QUOTIENT  PASS: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Quotient ={dut.quotient.value.integer}")

    assert dut.remainder.value.integer == expected_remainder, f"ERROR: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Expected Remainder={expected_remainder}, Got={dut.remainder.value.integer}"
    dut._log.info(f"REMAINDER PASS: DIVIDEND={dividend_in}, DIVISOR={divisor_in}, Remainder={dut.remainder.value.integer}")

    # Wait for handshake to occur
    while dut.dst_ready.value:
        await RisingEdge(dut.clk)

    await RisingEdge(dut.clk)

# Task to perform handshake reset valid
async def handshake_reset_valid(dut):
    while simulator_run:
        await RisingEdge(dut.clk)
        if dut.src_valid.value and dut.src_ready.value:
            dut.src_valid.value = 0
        if dut.dst_ready.value and dut.dst_valid.value:
            dut.dst_ready.value = 0

# Driver task
async def driver(dut, count):
    await RisingEdge(dut.clk)

    dut.dividend.value = random.randint(1,(2**(WIDTH))-1)
    dut.divisor.value = random.randint(1,(2**(WIDTH))-1)
    dut._log.info(f"INPUT: A={dut.dividend.value.integer}, B={dut.divisor.value.integer}")
    dut.src_valid.value = 1

    while dut.src_valid.value:
        await RisingEdge(dut.clk)

    for x in range (WIDTH):
        await RisingEdge(dut.clk)

    dut.dst_ready.value = 1

    for _ in range(count-1):
        await RisingEdge(dut.src_ready)

        dut.dividend.value = random.randint(1,(2**(WIDTH))-1)
        dut.divisor.value = random.randint(1,(2**(WIDTH))-1)
        
        dut.src_valid.value = 1

        while dut.src_valid.value:
            await RisingEdge(dut.clk)

        for x in range (WIDTH-2):
            await RisingEdge(dut.clk)

        dut.dst_ready.value = 1

# Monitor task
async def monitor(dut, count):
    for i in range(count):
        await RisingEdge(dut.src_valid)

        await FallingEdge(dut.clk)

        dividend_m = dut.dividend.value.integer
        divisor_m = dut.divisor.value.integer
        
        expected_quotient = int(dividend_m / divisor_m)
        expected_remainder = int(dividend_m % divisor_m)

        while not dut.dst_valid.value:
            await RisingEdge(dut.clk)

        assert dut.quotient.value.integer == expected_quotient, f"ERROR: DIVIDEND={dividend_m}, DIVISOR={divisor_m}, Expected Quotient={expected_quotient}, Got={dut.quotient.value.integer}"
        dut._log.info(f"RANDOM TEST #{i+1} | QUOTIENT  PASS | DIVIDEND = {dividend_m:6} | DIVISOR = {divisor_m:6} | Quotient = {dut.quotient.value.integer:6}")

        assert dut.remainder.value.integer == expected_remainder, f"ERROR: DIVIDEND={dividend_m}, DIVISOR={divisor_m}, Expected Remainder={expected_remainder}, Got={dut.remainder.value.integer}"
        dut._log.info(f"RANDOM TEST #{i+1} | REMAINDER PASS | DIVDEND = {dividend_m:6} | DIVISOR = {divisor_m:6} | Remainder = {dut.remainder.value.integer:6}")



@cocotb.test()
async def test_ready_before_valid(dut):
    # Clock generation
    cocotb.start_soon(clock_gen(dut))
    
    # Reset sequence
    await reset_sequence(dut)

    # Run handshake reset valid
    cocotb.start_soon(handshake_reset_valid(dut))

    # ##########################################
    # RUN: ready_before_valid handshake test
    # REQUIREMENTS: none
    # ##########################################
    await ready_before_valid(dut, 32770, 65234)



@cocotb.test()
async def test_valid_before_ready(dut):
    # Clock generation
    cocotb.start_soon(clock_gen(dut))
    
    # Reset sequence
    await reset_sequence(dut)

    # Run handshake reset valid
    cocotb.start_soon(handshake_reset_valid(dut))

    # ##########################################
    # RUN: valid_before_ready handshake test
    # REQUIREMENTS: directed_test
    # ##########################################
    forked_directed_test = cocotb.start_soon(directed_test(dut, 1, 1))
    forked_valid_before_ready = cocotb.start_soon(valid_before_ready(dut, 12, 5))
    await Combine(forked_directed_test, forked_valid_before_ready)

    

@cocotb.test()
async def test_valid_with_ready(dut):
    # Clock generation
    cocotb.start_soon(clock_gen(dut))
    
    # Reset sequence
    await reset_sequence(dut)

    # Run handshake reset valid
    cocotb.start_soon(handshake_reset_valid(dut))

    # ##########################################
    # RUN: valid_with_ready handshake test
    # REQUIREMENTS: directed_test
    # ##########################################
    forked_directed_test = cocotb.start_soon(directed_test(dut, 11, 3))
    forked_valid_with_ready = cocotb.start_soon(valid_with_ready(dut, 9, 2))
    await Combine(forked_directed_test, forked_valid_with_ready)

    
# Create a series of tests for each iteration
@cocotb.test()
async def test_random_driver_monitor(dut):
    cocotb.start_soon(clock_gen(dut))
    cocotb.start_soon(handshake_reset_valid(dut))

    driver_task = cocotb.start_soon(driver(dut,count))
    monitor_task = cocotb.start_soon(monitor(dut,count))
    await Combine(driver_task, monitor_task)

