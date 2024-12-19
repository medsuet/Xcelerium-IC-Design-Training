import cocotb
from cocotb.triggers import RisingEdge, Timer
from cocotb.regression import TestFactory
import random


@cocotb.coroutine
async def clock_gen(dut):
    """Generate clock signal with 10 ns period."""
    while True:
        dut.clk.value = 1
        await Timer(5, units='ns')
        dut.clk.value = 0
        await Timer(5, units='ns')



async def rst_seq(dut):
    """Initialize inputs and apply reset."""
    # Initialize inputs
    dut.dividend.value = 0
    dut.divisor.value = 0
    dut.rst.value = 0
    dut.valid_src.value = 0

    # Wait for 2 clock cycles
    await RisingEdge(dut.clk)  
    await RisingEdge(dut.clk)  

    # Deassert reset
    dut.rst.value = 1



@cocotb.coroutine
async def dir_test(dut, a_in, b_in):
    """Direct test equivalent to SystemVerilog task"""
    # Set the inputs
    await RisingEdge(dut.clk)
    dut.rst.value = 1
    dut.valid_src.value = 1
    dut.dividend.value = a_in
    dut.divisor.value = b_in
    
    # Wait for one rising edge of the clock
    await RisingEdge(dut.clk)
    
    # Deassert valid_src
    dut.valid_src.value = 0
    
#    # Wait for 17 more rising edges of the clock
#    for _ in range(17):
#        await RisingEdge(dut.clk)

    exp_remain =  int(a_in % b_in)
    exp_quot   = int(a_in / b_in)

    await RisingEdge(dut.valid_des)
    await RisingEdge(dut.clk)
    #dut._log.info(f"Testing with A = {a_in}, B = {b_in}")    
    actual_remain = int(dut.reminder)
    actual_quot = int(dut.quotient)
    if ((actual_remain == exp_remain) and (actual_quot == exp_quot)):
        #dut._log.info(f"Test passed")
        pass
    else:
        dut._log.info(f"Testing with random A = {a}, B = {b}")
        dut._log.info(f"Testing with random q = {actual_quot}, q_e = {exp_quot}")
        dut._log.info(f"Testing with random r = {actual_remain}, q_e = {exp_remain}")
        dut._log.error(f"Test failed")
    await RisingEdge(dut.clk)
    


@cocotb.coroutine
async def drive_inputs(dut, in1, in2):
    """Drive inputs and wait for a clock edge"""
    # Set the inputs
    dut.dividend.value = in1
    dut.divisor.value = in2
    dut.valid_src.value = 1

    # Wait for one rising edge of the clock
    await RisingEdge(dut.clk)
    
    # Deassert valid_src
    dut.valid_src.value = 0

    while not dut.valid_des:
        await RisingEdge(dut.clk)

@cocotb.coroutine
async def monitor_outputs(dut, a,b,exp_remain,exp_quot):
    """Monitor outputs."""
    await RisingEdge(dut.valid_des)
    await RisingEdge(dut.clk)
    actual_remain = int(dut.reminder)
    actual_quot = int(dut.quotient)
    if ((actual_remain == exp_remain) and (actual_quot == exp_quot)):
        #dut._log.info(f"Test passed")
        pass
    else:
        dut._log.info(f"Testing with random A = {a}, B = {b}")
        dut._log.info(f"Testing with random q = {actual_quot}, q_e = {exp_quot}")
        dut._log.info(f"Testing with random r = {actual_remain}, q_e = {exp_remain}")
        dut._log.error(f"Test failed")
    await RisingEdge(dut.clk)
    

@cocotb.test()
async def test_seq_mul(dut):
    """Main test for Sequential Multiplier."""
    cocotb.start_soon(clock_gen(dut))

    await rst_seq(dut)

    # Directed testing
    a = 0 
    b = 10
    t1 = cocotb.start_soon(dir_test(dut, a ,b))
    await t1
    a = 123 
    b = 123
    t1 = cocotb.start_soon(dir_test(dut, a ,b))
    await t1
    a = 7 
    b = 2
    t1 = cocotb.start_soon(dir_test(dut, a ,b))
    await t1
    a = 65535 
    b = 5
    t1 = cocotb.start_soon(dir_test(dut, a ,b))
    await t1


    # Random testing
    for i in range(40000):
        a = random.randint(0, 65535)
        b = random.randint(1, 65535)
        exp_remain = int(a % b)
        exp_quot   = int(a / b)
        #dut._log.info(f"Testing with random A = {a}, B = {b}")
        drive_task = cocotb.start_soon(drive_inputs(dut, a, b))
        monitor_task = cocotb.start_soon(monitor_outputs(dut, a, b,exp_remain,exp_quot))
        await drive_task
        await monitor_task
