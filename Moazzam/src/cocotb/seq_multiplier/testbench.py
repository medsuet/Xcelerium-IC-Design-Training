import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.triggers import FallingEdge

async def run_reset_routine(dut):
    for i in range(2):
        await RisingEdge(dut.clk)
    dut.n_rst.value = 1

async def run_start_routine(dut):
    for i in range(1):
        await RisingEdge(dut.clk)
    dut.start.value = 0

@cocotb.test()
async def basic_test(dut):
    # generate clock 
    cocotb.start_soon(Clock(dut.clk, 1, units="ns").start())

    # initialize the signals
    dut.multiplier.value = 0
    dut.multiplicand.value = 0
    dut.start.value = 0

    # Reset Dut
    dut.n_rst.value = 0

    # wait 2 rising egdes until we release reset
    cocotb.start_soon(run_reset_routine(dut))

    for i in range(2):
        await RisingEdge(dut.clk)

    # Apply Direct Inputs
    dut.multiplier.value = 66
    dut.multiplicand.value = 2
    dut.start.value = 0

    # wait for the start for only 1 rising edge
    for i in range(1):
        await RisingEdge(dut.clk)

    dut.start.value = 1

    cocotb.start_soon(run_start_routine(dut))

    #await RisingEdge(dut.ready)
    for out in range(20):
        await RisingEdge(dut.clk)