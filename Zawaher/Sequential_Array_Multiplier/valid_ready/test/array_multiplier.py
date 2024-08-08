import cocotb
from cocotb.clock import Clock
from cocotb.regression import TestFactory
from cocotb.result import TestFailure
from cocotb.regression import TestFactory

@cocotb.coroutine
def reset_sequence(dut):
    """Apply reset sequence."""
    dut.reset <= 1
    dut.dst_ready <= 0
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.reset <= 0
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.reset <= 1
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))

@cocotb.coroutine
def apply_inputs(dut):
    """Apply random inputs."""
    dut.multiplicand <= int(cocotb.utils.randn(32))
    dut.multiplier <= int(cocotb.utils.randn(32))

@cocotb.coroutine
def driver(dut):
    """Drive valid_src signal."""
    yield apply_inputs(dut)
    dut.valid_src <= 1
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.valid_src <= 0
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))

@cocotb.coroutine
def monitor(dut):
    """Monitor the DUT and check results."""
    yield cocotb.wait_for_edge(dut.dst_valid)
    expected_product = int(dut.multiplier.value) * int(dut.multiplicand.value)
    if int(dut.product.value) == expected_product:
        print(f"================= Test Passed ================")
        print(f"Multiplier: {dut.multiplier.value} | Multiplicand: {dut.multiplicand.value} | Product: {dut.product.value}")
    else:
        raise TestFailure(f"================== Test Failed ================" +
                          f"Multiplier: {dut.multiplier.value} | Multiplicand: {dut.multiplicand.value} " +
                          f"Expected {expected_product}, got {dut.product.value}")
    
    # Ensure dst_valid goes low before the next operation
    yield cocotb.wait_for_edge(dut.dst_valid.negedge)

@cocotb.coroutine
def apply_dst_ready(dut):
    """Assert dst_ready signal."""
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.dst_ready <= 1
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.dst_ready <= 0
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))

@cocotb.coroutine
def run_directed_tests(dut):
    """Run directed test cases."""
    # Test 1: valid_src before dst_ready
    print("Running Test 1: valid_src before dst_ready")
    yield apply_inputs(dut)
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.valid_src <= 1
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.valid_src <= 0
    yield monitor(dut)
    yield apply_dst_ready(dut)

    # Test 2: dst_ready before valid_src
    print("Running Test 2: dst_ready before valid_src")
    yield apply_inputs(dut)
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.valid_src <= 1
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.valid_src <= 0
    dut.dst_ready <= 1
    yield monitor(dut)
    yield cocotb.start_soon(cocotb.timer(20, units='ns'))
    dut.dst_ready <= 0

    # Test 3: valid_src and dst_ready at the same time
    print("Running Test 3: valid_src and dst_ready at the same time")
    yield apply_inputs(dut)
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.valid_src <= 1
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.valid_src <= 0
    yield cocotb.wait_for_edge(dut.dst_valid)
    dut.dst_ready <= 1
    yield cocotb.start_soon(cocotb.timer(10, units='ns'))
    dut.dst_ready <= 0
    yield monitor(dut)

@cocotb.coroutine
def test_array_multiplier(dut):
    """Main test procedure."""
    yield reset_sequence(dut)

    # Run directed test cases
    yield run_directed_tests(dut)

    # Run random test cases
    for _ in range(10):
        yield driver(dut)
        yield monitor(dut)
        yield cocotb.start_soon(cocotb.timer(30, units='ns'))
        yield apply_dst_ready(dut)

# Register the test
tf = TestFactory(test_array_multiplier)
tf.generate_tests()
