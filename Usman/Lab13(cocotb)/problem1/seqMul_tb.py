
import os
import random
import sys
from pathlib import Path

import cocotb
from cocotb.triggers import Timer,RisingEdge
from cocotb.clock import Clock
from random import randint

async def direct_test(dut,A,B):
    dut.A.value = A
    dut.A.value = B
    dut.src_valid.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    while(not dut.dst_valid.value):
        await RisingEdge(dut.clk)
   
    signed_A1 = dut.A.value.signed_integer  
    signed_B1 = dut.B.value.signed_integer
    expected_product1 = signed_A1 * signed_B1
    assert expected_product1 == dut.out.value

    dut.dst_ready.value =1
    await RisingEdge(dut.clk)  
    dut.dst_ready.value =0   
    
    while(not dut.src_ready.value):
        await RisingEdge(dut.clk)
    
    dut.src_valid.value = 0
    await RisingEdge(dut.clk)

    

async def driver(dut,k):
    for i in range(0,k):
        dut.A.value = randint(1,100)
        dut.A.value = randint(1,100)
        dut.src_valid.value = 1
        await RisingEdge(dut.clk)
        await RisingEdge(dut.clk)
    
        while(not dut.src_ready.value):
            await RisingEdge(dut.clk)
    
        dut.src_valid.value = 0
        await RisingEdge(dut.clk)
dut.src_valid.value = 0

async def monitor(dut):
    dut.dst_ready.value=0
    while True:
        await RisingEdge(dut.clk)
        
        while(not dut.src_valid.value):
            await RisingEdge(dut.clk)
        
        signed_A = dut.A.value.signed_integer  
        signed_B = dut.B.value.signed_integer
        expected_product = signed_A * signed_B
        
        while(not dut.dst_valid.value):
            await RisingEdge(dut.clk)    
        
        if(out != expected_product):
            print(f"Test Failed A={hex(dut.A.value)}  B = {hex(dut.b.value)} Expected = {hex(expected_product)} Got {hex(dut.out.value)}")
        else
            print(f"Test Passed A={hex(dut.A.value)}  B = {hex(dut.b.value)} Expected = {hex(expected_product)} Got {hex(dut.out.value)}") 
        dut.dst_ready.value =1
        await RisingEdge(dut.clk)  
        dut.dst_ready.value =0
@cocotb.test()
async def mutliplier_test(dut):
    clock_unit = Clock(dut.clk,10,"ps")
    await cocotb.start(clock_unit.start()) 

# input A, B,clk,reset,src_valid,dst_ready 
# output  src_ready,dst_valid, [31:0] out
     
    
    await direct_test(15,3)
    await direct_test(-5,7)
    await direct_test(8,-4)
    await direct_test(-6,-5)
    
      

    
    


