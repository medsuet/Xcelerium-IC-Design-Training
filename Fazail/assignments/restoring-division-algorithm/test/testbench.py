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
    dut.divisor.value = 1
    dut.dividend.value = 0

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

    expected_quotient = int(a_in / b_in)
    expected_remainder = a_in % b_in
	
	# valid input 
    await RisingEdge(dut.clk)
    dut.divisor.value = b_in
    dut.dividend.value = a_in
    dut.start.value = 1

    await RisingEdge(dut.clk)
    dut.start.value = 0
    
    while not dut.ready.value:
        await RisingEdge(dut.clk)
    	
    #await RisingEdge(dut.clk)
    assert dut.quotient.value == expected_quotient, f"ERROR: Divisor = {b_in} , Dividend = {a_in}, Expected Quotient = {expected_quotient}, Get = {dut.quotient.value.integer}"
    assert dut.remainder.value == expected_remainder, f"ERROR: Divisor = {b_in} , Dividend = {a_in}, Expected Remainder = {expected_remainder}, Get = {dut.remainder.value.integer}"
    dut._log.info(f"PASS: Divisor = {b_in} , Dividend = {a_in}, Quotient = {int(dut.quotient.value)}, Remainder = {int(dut.remainder.value)}")
    #print(f"PASS: Divisor = {b_in} , Dividend = {a_in}, Quotient = {int(dut.quotient.value)}, Remainder = {int(dut.remainder.value)}")

# driver
async def driver_in (dut, test):
     for i in range (test):
          dut.divisor.value = random.randint(1,2**16)
          dut.dividend.value = random.randint(1,2**16)
          dut.start.value = 1

          await RisingEdge(dut.clk)
          dut.start.value = 0

          while not dut.ready.value:
               await RisingEdge(dut.clk)

          await RisingEdge(dut.clk)

# monitor
async def monitor (dut, test):
     for j in range (test):
          await RisingEdge(dut.start)
     
          m_divisor = dut.divisor.value.integer
          m_dividend = dut.dividend.value.integer

          exp_q = int (m_dividend / m_divisor)
          exp_r = int (m_dividend % m_divisor)

          while not dut.ready.value:
               await RisingEdge(dut.clk)

          if (dut.quotient.value == exp_q) and (dut.remainder.value == exp_r):
               dut._log.info(f"SUCCESSFULLY DIVIDE :) | Dividend = {dut.dividend.value.integer}, Divisor = {dut.divisor.value.integer}, \
 Quotient = {dut.quotient.value.integer}, Remainder = {dut.quotient.value.integer}")
          else:
               dut._log.info(f"Check your Code :( | Dividend = {dut.dividend.value.integer}, Divisor = {dut.divisor.value.integer}")
               dut._log.info(f"Quotient  | Get = {dut.quotient.value.integer}, Expected = {exp_q.integer}")
               dut._log.info(f"Remainder | Get = {dut.remainder.value.integer}, Expected = {exp_r.integer}")                
    
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
    await directed_test(dut, 32770, 65234)
    await directed_test(dut, 9987, 15937)
    await directed_test(dut, 1, 15)

    # Reset Sequence
    await run_reset_routine(dut)
    count = 10
    print("\n------- Random Tests ------\n")
    driver_task = cocotb.start_soon(driver_in(dut, count))
    monitor_task = cocotb.start_soon(monitor(dut, count))

    await Combine(driver_task, monitor_task)
    print(" ")
