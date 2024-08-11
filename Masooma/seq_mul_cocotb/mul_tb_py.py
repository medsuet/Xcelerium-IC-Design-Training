import cocotb
from cocotb.triggers import RisingEdge, Timer
import random

async def to_signed(value, width):
    """Convert an unsigned integer value to a signed integer considering the bit width."""
    signed_value = value if value < (1 << width-1) else value - (1 << width)
    return signed_value

async def clk_gen(dut):
    """Clock generator"""
    while True:
        dut.clk.value = 0
        await Timer(5, units="ns")
        dut.clk.value = 1
        await Timer(5, units="ns")


async def basic_test(dut, num1, num2):
    await RisingEdge(dut.clk)
    dut.q.value=num1
    dut.m.value=num2
    while dut.src_ready.value == 0:
        await RisingEdge(dut.clk)
    dut._log.info("src_ready asserted")
    dut.src_valid.value = 1
    await RisingEdge(dut.clk)
    dut.src_valid.value = 0
    while dut.dest_valid.value == 0:
        await RisingEdge(dut.clk)
    dut._log.info("dest_valid asserted")
    dut.dest_ready.value=1
    await RisingEdge(dut.clk)
    if (num1*num2==(await to_signed(int(dut.p.value),32))):
        dut._log.info(f"Test Pass of multiplication of q={await to_signed(int(dut.q.value),16)} and m={await to_signed(int(dut.m.value),16)}")
    else:
        dut._log.info(f"Test Fail of multiplication of q={await to_signed(int(dut.q.value),16)} and m={await to_signed(int(dut.m.value),16)}; Expected={num1*num2}; We got={await to_signed(int(dut.p.value),32)}")
async def driver(dut, num1, num2):
    await RisingEdge(dut.clk)
    dut.dest_ready.value=0
    dut.q.value=num1
    dut.m.value=num2
    while dut.src_ready.value == 0:
        await RisingEdge(dut.clk)
    dut._log.info("src_ready asserted")
    dut.src_valid.value = 1
    await RisingEdge(dut.clk)
    dut.src_valid.value = 0
    while dut.dest_valid.value == 0:
        await RisingEdge(dut.clk)
    dut._log.info("dest_valid asserted")
async def monitor(dut, num1, num2):
    dut.dest_ready.value=1
    await RisingEdge(dut.clk)
    if (num1*num2==(await to_signed(int(dut.p.value),32))):
        dut._log.info(f"Test Pass of multiplication of q={await to_signed(int(dut.q.value),16)} and m={await to_signed(int(dut.m.value),16)}")
    else:
        dut._log.info(f"Test Fail of multiplication of q={await to_signed(int(dut.q.value),16)} and m={await to_signed(int(dut.m.value),16)}; Expected={num1*num2}; We got={await to_signed(int(dut.p.value),32)}")

@cocotb.test()
async def run_tests(dut):
    await cocotb.start(clk_gen(dut))
    dut.rst.value = 0
    await Timer(100, units="ns")
    dut.rst.value = 1
    dut._log.info("-------------------------------------------------------")
    await basic_test(dut, 1, 3)
    dut._log.info("-------------------------------------------------------")
    await basic_test(dut, 0, 675)
    dut._log.info("-------------------------------------------------------")
    await basic_test(dut, -9, 4)
    dut._log.info("-------------------------------------------------------")
    await basic_test(dut, -7, -2)
    dut._log.info("-------------------------------------------------------")
    await basic_test(dut, -1, 41)
    dut._log.info("-------------------------------------------------------")
    for i in range(2000):
        num1=random.randint(-32768, 32767)
        num2=random.randint(-32768, 32767)
        await driver(dut,num1,num2)
        dut._log.info(f"-------------------------Test {i}------------------------------")
        await monitor(dut,num1,num2)


