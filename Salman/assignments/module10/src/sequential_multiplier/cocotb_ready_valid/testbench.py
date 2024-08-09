import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, Combine
import random

simulator_run = True
count = 1000

# Clock generation
async def clock_gen(dut):
    while True:
        dut.CLK.value = 0
        await Timer(10, units='ns')
        dut.CLK.value = 1
        await Timer(10, units='ns')

# Reset sequence
async def reset_sequence(dut):
    await RisingEdge(dut.CLK)
    dut.RESET.value = 0
    dut.src_valid.value = 0
    dut.dst_ready.value = 0
    simulator_run = True
    await RisingEdge(dut.CLK)
    dut.RESET.value = 1

# Task to perform directed test
async def directed_test(dut, A_in, B_in):
    expected_product = A_in * B_in

    # Valid input
    await RisingEdge(dut.CLK)
    dut.src_valid.value = 1
    dut.A.value = A_in
    dut.B.value = B_in

    # Wait for handshake to occur
    while dut.src_valid.value:
        await RisingEdge(dut.CLK)

    # Wait for a valid output
    while not dut.dst_valid.value:
        await RisingEdge(dut.CLK)

    dut.dst_ready.value = 1

    # Valid output at negedge of CLK
    await FallingEdge(dut.CLK)

    assert dut.product.value.signed_integer == expected_product, f"ERROR: A={A_in}, B={B_in}, Expected Product={expected_product}, Got={dut.product.value.signed_integer}"
    dut._log.info(f"PASS: A={A_in}, B={B_in}, Product={dut.product.value.signed_integer}")

    # Wait for handshake to occur
    while dut.dst_ready.value:
        await RisingEdge(dut.CLK)

    await RisingEdge(dut.CLK)

# Task to perform ready_before_valid test
async def ready_before_valid(dut, A_in, B_in):
    expected_product = A_in * B_in

    # Valid input after ready - ready before valid
    await RisingEdge(dut.CLK)
    dut.src_valid.value = 1
    dut.A.value = A_in
    dut.B.value = B_in

    # Wait for handshake to occur
    while dut.src_valid.value:
        await RisingEdge(dut.CLK)

    # Set ready as 1 after 14 edge of clock 'before valid output' - ready before valid
    await Timer(140, units='ns')
    dut.dst_ready.value = 1

    # Wait for a valid output
    while not dut.dst_valid.value:
        await RisingEdge(dut.CLK)

    assert dut.product.value.signed_integer == expected_product, f"ERROR: A={A_in}, B={B_in}, Expected Product={expected_product}, Got={dut.product.value.signed_integer}"
    dut._log.info(f"PASS: A={A_in}, B={B_in}, Product={dut.product.value.signed_integer}")

    # Wait for handshake to occur
    while dut.dst_ready.value:
        await RisingEdge(dut.CLK)

    await RisingEdge(dut.CLK)

# Task to perform valid_before_ready test
async def valid_before_ready(dut, A_in, B_in):
    expected_product = A_in * B_in

    # Wait for handshake to occur
    while dut.src_valid.value:
        await RisingEdge(dut.CLK)

    # Valid before ready
    await Timer(140, units='ns')
    dut.A.value = A_in
    dut.B.value = B_in
    dut.src_valid.value = 1

    await RisingEdge(dut.CLK)

    # Wait till handshake occurs
    while dut.src_valid.value:
        await RisingEdge(dut.CLK)

    # Wait till a valid output comes
    while not dut.dst_valid.value:
        await RisingEdge(dut.CLK)

    assert dut.product.value.signed_integer == expected_product, f"ERROR: A={A_in}, B={B_in}, Expected Product={expected_product}, Got={dut.product.value.signed_integer}"
    dut._log.info(f"PASS: A={A_in}, B={B_in}, Product={dut.product.value.signed_integer}")

    # Delay - Valid before ready
    await Timer(30, units='ns')
    dut.dst_ready.value = 1

    # Wait for handshake to occur
    while dut.dst_ready.value:
        await RisingEdge(dut.CLK)

    await RisingEdge(dut.CLK)


# Task to perform valid_with_ready handshake test
async def valid_with_ready(dut, A_in, B_in):
    expected_product = A_in * B_in

    # Wait for prev ready to start - directed test in parallel
    while not dut.src_ready.value:
        await RisingEdge(dut.CLK)

    # Wait for prev ready to end - directed test in parallel
    while dut.src_ready.value:
        await RisingEdge(dut.CLK)

    # Wait for next ready to start - valid with ready
    await RisingEdge(dut.src_ready)

    dut.A.value = A_in
    dut.B.value = B_in
    dut.src_valid.value = 1

    # Wait for handshake to occur
    while dut.src_valid.value:
        await RisingEdge(dut.CLK)

    # Wait for a valid output - valid with ready
    await RisingEdge(dut.dst_valid)
    dut.dst_ready.value = 1

    # Valid output at negedge of clock - due to delay
    await FallingEdge(dut.CLK)

    assert dut.product.value.signed_integer == expected_product, f"ERROR: A={A_in}, B={B_in}, Expected Product={expected_product}, Got={dut.product.value.signed_integer}"
    dut._log.info(f"PASS: A={A_in}, B={B_in}, Product={dut.product.value.signed_integer}")

    # Wait for handshake to occur
    while dut.dst_ready.value:
        await RisingEdge(dut.CLK)

    await RisingEdge(dut.CLK)

# Task to perform handshake reset valid
async def handshake_reset_valid(dut):
    while simulator_run:
        await RisingEdge(dut.CLK)
        if dut.src_valid.value and dut.src_ready.value:
            dut.src_valid.value = 0
        if dut.dst_ready.value and dut.dst_valid.value:
            dut.dst_ready.value = 0

# Driver task
async def driver(dut, count):
    await RisingEdge(dut.CLK)

    dut.A.value = random.randint(-2**15, 2**15 - 1)
    dut.B.value = random.randint(-2**15, 2**15 - 1)
    dut._log.info(f"INPUT: A={dut.A.value.signed_integer}, B={dut.B.value.signed_integer}")
    dut.src_valid.value = 1

    while dut.src_valid.value:
        await RisingEdge(dut.CLK)

    await Timer(160, units='ns')

    dut.dst_ready.value = 1

    for _ in range(count-1):
        await RisingEdge(dut.src_ready)

        dut.A.value = random.randint(-2**15, 2**15 - 1)
        dut.B.value = random.randint(-2**15, 2**15 - 1)
        
        dut.src_valid.value = 1

        while dut.src_valid.value:
            await RisingEdge(dut.CLK)

        await Timer(160, units='ns')

        dut.dst_ready.value = 1

# Monitor task
async def monitor(dut, count):
    for i in range(count):
        await RisingEdge(dut.src_valid)

        await FallingEdge(dut.CLK)

        multiplier_m = dut.A.value.signed_integer
        multiplicand_m = dut.B.value.signed_integer
        expected_product = multiplier_m * multiplicand_m

        while not dut.dst_valid.value:
            await RisingEdge(dut.CLK)

        assert dut.product.value.signed_integer == expected_product, f"ERROR: A={multiplier_m}, B={multiplicand_m}, Expected Product={expected_product}, Got={dut.product.value.signed_integer}"
        dut._log.info(f"RANDOM TEST #{i+1} | PASS | A = {multiplier_m:6} | B = {multiplicand_m:6} | Product = {dut.product.value.signed_integer:11}")

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
    await ready_before_valid(dut, 10, -10)

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
    forked_valid_before_ready = cocotb.start_soon(valid_before_ready(dut, -100, 10))
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
    forked_directed_test = cocotb.start_soon(directed_test(dut, 1, 1))
    forked_valid_with_ready = cocotb.start_soon(valid_with_ready(dut, 1000, 10))
    await Combine(forked_directed_test, forked_valid_with_ready)


# Create a series of tests for each iteration
@cocotb.test()
async def test_random_driver_monitor(dut):
    cocotb.start_soon(clock_gen(dut))
    cocotb.start_soon(handshake_reset_valid(dut))

    driver_task = cocotb.start_soon(driver(dut,count))
    monitor_task = cocotb.start_soon(monitor(dut,count))
    await Combine(driver_task, monitor_task)
