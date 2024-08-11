import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from cocotb.result import TestFailure
import random

@cocotb.coroutine
async def reset_dut(dut):
    dut.RST <= 0
    await Timer(2, units="ns")
    dut.RST <= 1
    #await Timer(2, units="ns")

@cocotb.coroutine
async def drive_input(dut, dividend, divisor):
    dut.START <= 0
    await RisingEdge(dut.CLK)
    await reset_dut(dut)
    dut.Q <= dividend
    dut.M <= divisor
    dut.A <= 0
    dut.START <= 1
    await RisingEdge(dut.CLK)
    dut.START <= 0

@cocotb.coroutine
async def monitor_output(dut, dividend, divisor):
    expected_quotient = dividend // divisor
    expected_remainder = dividend % divisor
    
    for _ in range(16):
        await RisingEdge(dut.CLK)
    
    if (int(dut.QUOTIENT) == expected_quotient and 
        int(dut.REMAINDER) == expected_remainder):
        dut._log.info(f"Test Passed: QUOTIENT = {int(dut.QUOTIENT)}, REMAINDER = {int(dut.REMAINDER)}")
    else:
        raise TestFailure(f"Test Failed: Expected QUOTIENT = {expected_quotient}, REMAINDER = {expected_remainder}; "
                          f"Got QUOTIENT = {int(dut.QUOTIENT)}, REMAINDER = {int(dut.REMAINDER)}")

@cocotb.test()
async def restoring_division_test(dut):
    # Generate clock
    cocotb.fork(clock_gen(dut.CLK))
    
    # Test case 1: dividend = 9, divisor = 4
    await drive_input(dut, 9, 4)
    await monitor_output(dut, 9, 4)
    
    # Test case 2: dividend = 20, divisor = 3
    await drive_input(dut, 20, 3)
    await monitor_output(dut, 20, 3)
    
    # Test case 3: dividend = 100, divisor = 7
    await drive_input(dut, 100, 7)
    await monitor_output(dut, 100, 7)
    
    # Additional test cases can be added here

@cocotb.coroutine
async def clock_gen(signal):
    while True:
        signal <= 0
        await Timer(10, units="ns")
        signal <= 1
        await Timer(10, units="ns")
