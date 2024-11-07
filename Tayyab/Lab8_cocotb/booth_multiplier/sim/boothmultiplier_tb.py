"""
    Name: boothmultiplier_tb.sv
    Author: Muhammad Tayyab
    Date: 7-8-2024
    Description: Cocotb testbanch for booth_multiplier.sv
"""

import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
from random import randint
from ref_models.boothmultiplier import boothMultiplier as ref_model
import os
# Control vars
NUMBITS = 32
directed_test_pairs = [(-1,-1),(2,3),(3,-2),(-6,6)]
NUM_RAND_TESTS = int(1e3)

MASK = (2**NUMBITS)-1
TEST_BOUND = 2**(NUMBITS-1)
random_test_pairs = [(randint(-TEST_BOUND, TEST_BOUND-1), randint(-TEST_BOUND, TEST_BOUND-1)) for x in range(NUM_RAND_TESTS)]
directed_test_pairs.extend(random_test_pairs)

@cocotb.test()
async def directed_random_tests(dut):
    await init(dut)
    await reset_sequence(dut, 5)

    for test_pair in directed_test_pairs:
        await RisingEdge(clk)
        num_a.value = test_pair[0]
        num_b.value = test_pair[1]
        valid_src.value = 1

        ref_result = ref_model(test_pair[0], test_pair[1])
        ref_high_bits = ref_result[0] & MASK
        ref_low_bits = ref_result[1] & MASK

        while (not valid_dst.value):
            await RisingEdge(clk)
        
        assert (ref_high_bits, ref_low_bits) == (product_high.value, product_low.value)
        if 0:
            print("\n")
            print("a,b:",hex(num_a.value), hex(num_b.value))
            print("Product:",hex(product_high.value), hex(product_low.value))
            print("Ref    :",hex(ref_high_bits), hex(ref_low_bits))
            print("\n")

        ready_dst.value = 1
        await RisingEdge(clk)
        ready_dst.value = 0
        valid_src.value = 0
        

async def init(dut):
    # Global handles for signals
    global clk, reset, num_a, num_b, product_low, product_high
    global valid_src, ready_dst, ready_src, valid_dst
    
    clk=dut.clk
    reset=dut.reset
    num_a=dut.num_a
    num_b=dut.num_b
    product_high=dut.product_high
    product_low=dut.product_low
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

