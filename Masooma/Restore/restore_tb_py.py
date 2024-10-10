import cocotb
from cocotb.triggers import RisingEdge, Timer
import random

async def clk_gen(dut):
    """Clock generator"""
    while True:
        dut.clk.value = 0
        await Timer(5, units="ns")
        dut.clk.value = 1
        await Timer(5, units="ns")


async def basic_test(dut, num1, num2):
    await RisingEdge(dut.clk)
    dut.dd.value=num1
    dut.ds.value=num2
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
    if ((num1//num2==dut.quo.value)&(num1%num2==dut.rem.value)):
        dut._log.info(f"Test Pass of multiplication of dd={(dut.dd.value)} and ds={(dut.ds.value)}")
    else:
        dut._log.info(f"Test Fail of multiplication of dd={(dut.dd.value)} and ds={(dut.ds.value)}; Expected quo={(num1//num2)} and rem={num1%num2}; We got quo={(dut.quo.value)} and rem={(dut.rem.value)}")
async def driver(dut, num1, num2):
    await RisingEdge(dut.clk)
    dut.dest_ready.value=0
    dut.dd.value=num1
    dut.ds.value=num2
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
    if ((num1//num2==dut.quo.value)&(num1%num2==dut.rem.value)):
        dut._log.info(f"Test Pass of multiplication of dd={int(dut.dd.value)} and ds={int(dut.ds.value)}")
    else:
        dut._log.info(f"Test Fail of multiplication of dd={int(dut.dd.value)} and ds={int(dut.ds.value)}; Expected quo={(num1//num2)} and rem={num1%num2}; We got quo={(dut.quo.value)} and rem={(dut.rem.value)}")
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
    await basic_test(dut, 9, 4)
    dut._log.info("-------------------------------------------------------")
    await basic_test(dut, 7, 2)
    dut._log.info("-------------------------------------------------------")
    await basic_test(dut, 1, 41)
    dut._log.info("-------------------------------------------------------")
    for i in range(500):
        num1=random.randint(0, 0xFFFFFFFF)
        num2=random.randint(0, 0xFFFFFF)
        await driver(dut,num1,num2)
        dut._log.info(f"-------------------------Test {i}------------------------------")
        await monitor(dut,num1,num2)


