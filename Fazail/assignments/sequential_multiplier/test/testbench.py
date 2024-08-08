import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, Combine
import random

# clock generation
async def clock_gen(dut):
	while True:
		dut.clk.value = 0
		await Timer(10, units='ns')
		dut.clk.value = 1
		await Timer(10, units='ns')
          
# initialize all the signals
async def init_signals(dut):
    await RisingEdge(dut.clk)
    dut.n_rst.value = 0
    dut.start.value = 0
    dut.multiplier.value = 0
    dut.multiplicand.value = 0

# reset sequence
async def run_reset_routine(dut):
    await RisingEdge(dut.clk)
    dut.n_rst.value = 0
    await RisingEdge(dut.clk)
    dut.n_rst.value = 1

# directed test
async def directed_test(dut, a_in, b_in):

    # Reset Sequence
    await run_reset_routine(dut)

    exp_product = int(a_in * b_in)
	
	# valid input 
    await RisingEdge(dut.clk)
    dut.multiplier.value = b_in
    dut.multiplicand.value = a_in
    dut.start.value = 1

    await RisingEdge(dut.clk)
    dut.start.value = 0
    
    while not dut.ready.value:
        await RisingEdge(dut.clk)
    	
    #await RisingEdge(dut.clk)
    assert dut.product.value.signed_integer == exp_product, f"ERROR: multiplier = {b_in} , multiplicand = {a_in}, Expected product = {exp_product}, Get = {dut.product.value.integer}"
    dut._log.info(f"PASS: multiplier = {b_in} , multiplicand = {a_in}, product = {int(dut.product.value)}")

# driver
async def driver_in (dut, test):
     for i in range (test):
          dut.multiplier.value = random.randint( -(2**15) , (2**15)-1 )
          dut.multiplicand.value = random.randint( -(2**15) , (2**15)-1 )
          dut.start.value = 1

          await RisingEdge(dut.clk)
          dut.start.value = 0

          while not dut.ready.value:
               await RisingEdge(dut.clk)

          await RisingEdge(dut.clk)

# monitor
async def monitor (dut, test):
     for j in range (1,test+1):
          await RisingEdge(dut.start)
     
          m_multiplier = dut.multiplier.value.signed_integer
          m_multiplicand = dut.multiplicand.value.signed_integer

          exp_p = int (m_multiplicand * m_multiplier)

          while not dut.ready.value:
               await RisingEdge(dut.clk)

          if (dut.product.value.signed_integer == exp_p):
               dut._log.info(f"Test no. = {j} >> SUCCESSFULLY MULTIPLIED :) | multiplicand = {dut.multiplicand.value.integer}, multiplier = {dut.multiplier.value.integer}, \
 product = {dut.product.value.integer}")
          else:
               dut._log.info(f"Check your Code :( | multiplicand = {dut.multiplicand.value.integer}, multiplier = {dut.multiplier.value.integer}")
               dut._log.info(f"product  | Get = {dut.product.value.integer}, Expected = {exp_p.integer}")               
    
@cocotb.test()
async def basic_test(dut):
	# Clock Generation
    cocotb.start_soon(clock_gen(dut))

    # initialize all the signals
    await init_signals(dut)

    print("\n------- Directed Tests ------\n")
    await directed_test(dut, 1, 9)
    await directed_test(dut, 9, 1)
    await directed_test(dut, 11, 3)
    await directed_test(dut, 7, 1)
    await directed_test(dut, 8, 1)
    await directed_test(dut, 1, 15)

    # Reset Sequence
    await run_reset_routine(dut)
    count = 1000
    print("\n------- Random Tests ------\n")
    driver_task = cocotb.start_soon(driver_in(dut, count))
    monitor_task = cocotb.start_soon(monitor(dut, count))

    await Combine(driver_task, monitor_task)
    print(" ")
