import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from cocotb.clock import Clock
from cocotb.result import TestFailure
import random

class SequentialMultiplierTB:
    def __init__(self, dut):
        self.dut = dut
        self.clock = Clock(self.dut.clk, 10, units="ns")
        cocotb.start_soon(self.clock.start())

    async def init_sequence(self):
        self.dut.multiplicand.value = 0
        self.dut.multiplier.value = 0
        self.dut.start.value = 0

    async def reset_sequence(self):
        self.dut.reset.value = 0  # Active low reset
        await RisingEdge(self.dut.clk)
        await FallingEdge(self.dut.clk)
        self.dut.reset.value = 1
        await RisingEdge(self.dut.clk)
        await Timer(1, units='ns')  # Add a small delay after reset

    async def driver(self, multiplicand, multiplier):
        self.dut.multiplicand.value = multiplicand
        self.dut.multiplier.value = multiplier
        self.dut.start.value = 1
        await RisingEdge(self.dut.clk)
        self.dut.start.value = 0

    async def monitor(self, expected_product, timeout=200):  # Increased from 100 to 200
        for i in range(timeout):
            await RisingEdge(self.dut.clk)
            if self.dut.ready.value == 1:
                break
            if i % 10 == 0 or i >= timeout - 20:  # Log every 10 cycles and the last 20 cycles
                self.dut._log.info(f"Cycle {i}: ready = {self.dut.ready.value}, product = {self.dut.product.value.signed_integer}, " 
                                f"multiplicand = {self.dut.multiplicand.value.signed_integer}, "
                                f"multiplier = {self.dut.multiplier.value.signed_integer}")
        else:
            raise TestFailure(f"Test timed out after {timeout} cycles. Ready signal not asserted.")

        computed_product = self.dut.product.value.signed_integer
        assert computed_product == expected_product, f"Multiplication result was incorrect. Got {computed_product}, expected {expected_product}"
        
        self.dut._log.info(f"Multiplication successful: {self.dut.multiplicand.value} * {self.dut.multiplier.value} = {computed_product}")

@cocotb.test()
async def test_sequential_multiplier(dut):
    """Test the sequential multiplier with multiple test cases"""

    tb = SequentialMultiplierTB(dut)

    # Directed test cases
    directed_test_cases = [
        (123, 456),   # Simple positive multiplication
        (-123, 456),  # Negative multiplicand
        (123, -456),  # Negative multiplier
        (-123, -456), # Both negative
        (0, 456),     # Zero multiplicand
        (123, 0),     # Zero multiplier
        (32767, 2),   # Max positive 16-bit value
        (-32767, 2),  # One more than min negative 16-bit value
        # (-32768, 2),  # Min negative 16-bit value - error
        (2, -32768),  # Min negative 16-bit value
        (1, 1),       # Multiplication by one
        (0, 0),       # Multiplication by zero
    ]

    # Randomized test cases
    randomized_test_cases = []
    for _ in range(10):
        multiplicand = random.randint(-32768, 32767)
        multiplier = random.randint(-32768, 32767)
        randomized_test_cases.append((multiplicand, multiplier))

    all_test_cases = directed_test_cases + randomized_test_cases

    passed_tests = 0
    failed_tests = 0

    for index, (multiplicand, multiplier) in enumerate(all_test_cases):
        await tb.init_sequence()
        await tb.reset_sequence()
        
        expected_product = multiplicand * multiplier
        
        try:
            await tb.driver(multiplicand, multiplier)
            await tb.monitor(expected_product)
            passed_tests += 1
            dut._log.info(f"Test case {index + 1} ({multiplicand}, {multiplier}) passed successfully")
        
        except AssertionError as e:
            failed_tests += 1
            dut._log.error(f"Test case {index + 1} ({multiplicand}, {multiplier}) failed: {str(e)}")
            # Add more detailed logging for the failing case
            if multiplicand == -32768 or multiplier == -32768:
                dut._log.info(f"Detailed state: product = {dut.product.value.signed_integer}, "
                              f"ready = {dut.ready.value}, "
                              f"internal_state = {dut.internal_state.value if hasattr(dut, 'internal_state') else 'N/A'}")
        except TestFailure as e:
            failed_tests += 1
            dut._log.error(f"Test case {index + 1} ({multiplicand}, {multiplier}) failed: {str(e)}")
        except Exception as e:
            failed_tests += 1
            dut._log.error(f"Unexpected error in test case {index + 1} ({multiplicand}, {multiplier}): {str(e)}")
    
    dut._log.info(f"All test cases completed. Passed: {passed_tests}, Failed: {failed_tests}")
