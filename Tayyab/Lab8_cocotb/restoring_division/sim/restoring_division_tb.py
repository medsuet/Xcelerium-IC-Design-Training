"""
    Name: restoring_division_tb.sv
    Author: Muhammad Tayyab
    Date: 7-8-2024
    Description: Cocotb testbanch for restoring_division.sv
"""

def ref_model(a, b):
    return (a//b, a%b)

import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
from random import randint

# Control vars
NUMBITS = 4
directed_test_pairs = [(1,1),(0,1),(8,0)]
NUM_RAND_TESTS = int(1e3)

MASK = (2**NUMBITS)-1
TEST_BOUND = 2**(NUMBITS-1)
random_test_pairs = [(randint(0, TEST_BOUND-1), randint(0, TEST_BOUND-1)) for x in range(NUM_RAND_TESTS)]
directed_test_pairs.extend(random_test_pairs)

@cocotb.test()
async def directed_random_tests(dut):
    await init(dut)
    await reset_sequence(dut, 5)

    for test_pair in directed_test_pairs:
        await RisingEdge(clk)
        dividend.value = test_pair[0]
        divisor.value = test_pair[1]
        valid_src.value = 1

        try:
            ref_result = ref_model(test_pair[0], test_pair[1])
        except ZeroDivisionError:
            ref_result = (0,0)
        
        ref_quotient = ref_result[0] & MASK
        ref_remainder = ref_result[1] & MASK

        while (not valid_dst.value):
            await RisingEdge(clk)
        
        if 0:
            print("\n")
            print("a,b:",hex(dividend.value), hex(divisor.value))
            print("Result:",hex(quotient.value), hex(remainder.value))
            print("Ref    :",hex(ref_quotient), hex(ref_remainder))
            print("\n")
        
        assert (ref_quotient, ref_remainder) == (quotient.value, remainder.value)

        ready_dst.value = 1
        await RisingEdge(clk)
        ready_dst.value = 0
        valid_src.value = 0
        

async def init(dut):
    # Global handles for signals
    global clk, reset, dividend, divisor, quotient, remainder
    global valid_src, ready_dst, ready_src, valid_dst
    
    clk=dut.clk
    reset=dut.reset
    dividend=dut.dividend
    divisor=dut.divisor
    quotient=dut.quotient
    remainder=dut.remainder
    valid_src=dut.valid_src
    ready_dst=dut.ready_dst
    ready_src=dut.ready_src
    valid_dst=dut.valid_dst

    # Initial values
    reset.value=1
    valid_src.value=0
    ready_dst.value=0

    # Start clock
    c = Clock(dut.clk, 10, 'step')
    await cocotb.start(c.start())

async def reset_sequence(dut, reset_time):
    reset.value = 0
    await Timer(reset_time)
    reset.value = 1

