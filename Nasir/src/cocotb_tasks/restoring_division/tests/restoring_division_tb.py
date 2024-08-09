import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
from cocotb.result import TestFailure
import random

class restoring_division:
    def __init__(self, dut):
        self.dut = dut
        self.clock = Clock(self.dut.clk, 10, units="ns" )
        cocotb.start_soon(self.clock.start())
    
    async def init_sequence(self):
        self.dut.dividend.value = 0
        self.dut.divisor.value = 0
        self.dut.start.value = 0
        
    async def reset_sequence(self):
        self.dut.reset.value = 0  # active low reset
        await RisingEdge(self.dut.clk)
        await FallingEdge(self.dut.clk)
        self.dut.reset.value = 1
        await Timer(1, units="ns")               # add some delay
        
    async def driver(self, dividend, divisor):
        self.dut.dividend.value = dividend
        self.dut.divisor.value = divisor
        self.dut.start.value = 1
        await RisingEdge(self.dut.clk)
        self.dut.start.value =0
        
    async def monitor(self, expected_remainder, expected_quotient, timeout = 20):
        for i in range(timeout):
            await RisingEdge(self.dut.clk)
            if (self.dut.ready.value == 1):
                self.dut._log.info(f"Cycle{i}, dividend = {self.dut.dividend.value.integer}, divisor = {self.dut.divisor.value.integer},"
                                f"ready = {self.dut.ready.value.integer},"
                                f"quotient = {self.dut.remainder.value.integer}, remainder = {self.dut.quotient.value.integer}")
                break
            # else:
            #     self.dut._log.info(f"Cycle{i}, dividend = {self.dut.dividend.value}, divisor = {self.dut.divisor.value},"
            #                     f"ready = {self.dut.ready.value},"
            #                     f"quotient = {self.dut.quotient.value}, remainder = {self.dut.remainder.value}")
                
        else:
            raise TestFailure(f"Test timed out after {timeout} cycles. Ready signal not asserted.")
        
        # expected_remainder = self.dut.dividend.value % self.dut.divisor.value
        # expected_quotient = self.dut.dividend.value // self.dut.divisor.value
        computed_remainder = self.dut.remainder.value.integer
        computed_quotient = self.dut.quotient.value.integer
        self.dut._log.info(f"Expected division Result: {self.dut.dividend.value.integer} / {self.dut.divisor.value.integer} = {expected_remainder} , {expected_quotient}")
        self.dut._log.info(f"Computed division result: {self.dut.dividend.value.integer} / {self.dut.divisor.value.integer} = {computed_remainder} , {computed_quotient}")
        assert computed_remainder == expected_remainder, f"remainder result was incorrect. Got {computed_remainder}, expected {expected_remainder}"
        assert computed_quotient == expected_quotient, f"quotient result was incorrect. Got {computed_quotient}, expected {expected_quotient}"
        
        self.dut._log.info(f"division successful: {self.dut.dividend.value.integer} / {self.dut.divisor.value.integer} = {computed_remainder} , {computed_quotient}")

        
        

@cocotb.test()

async def test_restoring_division(dut):
    
    tb = restoring_division(dut)
    
    # await tb.init_sequence()
    # await tb.reset_sequence()
    # await tb.driver(9,4)
    # await tb.monitor()
    # print("division = ", 4%9)
    # Directed test cases
    directed_test_cases = [
        (0, 12),        # zero over something no error
        (0, 34473),     # zero over something no error
        (1, 1),         # division by one
        (1267, 1),      # division by one
        (1, 12823),     # one over something
        (123, 456),     # division by big divisor as compared to dividend
        # (0, 456),     # Zero dividend
        # (123, 0),     # Zero divisor
        (32767, 2),     # Max positive 16-bit value
        (2, 32767),     # divisor max no. as signend 
        (3, 32768),     # divisor max no. + 1 as signend 
        (32768, 2),     # dividend max no. + 1 as signend 
        # (65536, 15),  # max. dividend as unsigned - extreme cases error
        # (15, 65536),  # max. divisor as unsigned - extreme cases error
        (65535, 25),    # max. dividend - 1 as unsigned
        (25, 65535),    # max. divisor - 1 as unsigned
        # (0, 0),       # division by zero - error
    ]

    # Randomized test cases
    randomized_test_cases = []
    for _ in range(10000):
        dividend = random.randint(0, 65536)
        divisor = random.randint(0, 65536)
        randomized_test_cases.append((dividend, divisor))

    all_test_cases = directed_test_cases + randomized_test_cases

    passed_tests = 0
    failed_tests = 0

    for index, (dividend, divisor) in enumerate(all_test_cases):
        await tb.init_sequence()
        await tb.reset_sequence()
        
        expected_remainder = dividend % divisor
        expected_quotient = dividend // divisor
        # print(f"Remainder = {expected_remainder}  Quotient = {expected_quotient}")
        
        try:
            await tb.driver(dividend, divisor)
            await tb.monitor(expected_remainder, expected_quotient)
            passed_tests += 1
            dut._log.info(f"Test case {index + 1} ({dividend}, {divisor}) passed successfully")
        
        except AssertionError as e:
            failed_tests += 1
            dut._log.error(f"Test case {index + 1} ({dividend}, {divisor}) failed: {str(e)}")
            # Add more detailed logging for the failing case
            # if dividend == -32768 or divisor == -32768:
            #     dut._log.info(f"Detailed state: product = {dut.product.value.signed_integer}, "
            #                   f"ready = {dut.ready.value}, "
            #                   f"internal_state = {dut.internal_state.value if hasattr(dut, 'internal_state') else 'N/A'}")
        # except TestFailure as e:
        #     failed_tests += 1
        #     dut._log.error(f"Test case {index + 1} ({dividend}, {divisor}) failed: {str(e)}")
        # except Exception as e:
        #     failed_tests += 1
        #     dut._log.error(f"Unexpected error in test case {index + 1} ({dividend}, {divisor}): {str(e)}")
    
    dut._log.info(f"All test cases completed. Passed: {passed_tests}, Failed: {failed_tests}")

    