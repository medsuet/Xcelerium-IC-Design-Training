# Restoring division

Division unit using restoring division algorithem.\
Divides positive numbers and generates quotient, remainder

```
Parameters: NUMBITS     : number of bits (width) of dividend and divisor

Inputs: clk             : clock signal
        reset           : reset signal (active low)
        dividend        : <NUMBITS> wide dividend
        dividend        : <NUMBITS> wide divisor
        valid_scr       : valid signal from source signaling availability of inputs (dividend, divisor)
        ready_dst       : ready signal from destination signaling that outputs (quotient, remainder) are available

Outputs: quotient       : <NUMBITS> wide quotient of dividend/divisor
         remainder      : <NUMBITS> wide remainder of dividend/divisor
         valid_dst      : valid signal to destination signaling availability of  output (quotient, remainder)
         ready_scr      : ready signal to source signaling that inputs (dividend, divisor) have been processed

Supports valid/ready interface.
```

### Run tests
Cocotb is used for simulation.

Python testbench: [restoring_division_tb.py](../sim/restoring_division_tb.py)\
The python testbench runs directed and random tests on the unit. 
Default directed test pairs (dividend, divisor) are [(1,1),(0,1),(8,0)] and default number of random tests is 1000.

Define new directed tests, add a new (dividend, divisor) tuple to python list directed_test_pairs (testbench, line 18).\
To change number of random tests, set value of NUM_RAND_TESTS constant (testbench, line 19).

`make`\
Runs cocotb simulation.

`clean`\
Removes build files.
