# Booth multiplier

Division unit using restoring division algorithem

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
        valid_dst      : valid signal to destination signaling availability of output (quotient, remainder)
        ready_scr      : ready signal to source signaling that inputs (dividend, divisor) has been processed

Supports valid/ready interface.
```

### Run tests
Cocotb is used for simulation.

`make`\
Runs cocotb simulation.

`clean`\
Removes build files.
