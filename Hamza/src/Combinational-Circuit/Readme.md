# Signed 16-Bit Multiplier

## Overview

The `signed_16bit_multiplier` module is designed to perform multiplication of two 16-bit signed integers. The module computes the product using a combination of half adders (HA) and full adders (FA), implementing a hierarchical addition algorithm.

## Algorithm Explanation

### 1. Partial Product Generation

- **Inputs:** Two 16-bit signed integers, `A` (multiplicand) and `B` (multiplier).
- **Process:** The algorithm generates a matrix of partial products by ANDing each bit of `A` with each bit of `B`. This results in a 16x16 matrix where each entry represents a partial product of two bits from `A` and `B`.

### 2. Addition of Partial Products

- **Initial Addition:** The partial products are added together in a hierarchical manner:
  - **Level 0:** Uses a half adder (HA) and full adders (FA) to combine the least significant partial products.
  - **Subsequent Levels:** Each level adds the results from the previous level to the next set of partial products, continuing this process until all partial products are summed.

### 3. Handling Carry Propagation

- **Half Adders (HA):** Used for adding initial bits of partial products where no carry-in is present.
- **Full Adders (FA):** Used to handle partial products with a carry-in from the previous addition stage. This manages cases where there is a carry resulting from the addition of two bits.

### 4. Final Summation

- **Product Calculation:** After processing all levels of addition, the final product is derived from the result of the last addition stage. This sum represents the combined value of all partial products, considering all carry bits from previous additions.

### 5. Output

- **Product Result:** The final output is a 32-bit signed integer that represents the product of the two 16-bit signed integers. The design accommodates the full range of values resulting from the multiplication of two 16-bit numbers.

## Key Points

- **Signed Multiplication:** The algorithm correctly handles signed numbers by considering the sign extension of the inputs and the resultant product.
- **Bit Width:** The product is 32 bits wide to support the range of values produced by multiplying two 16-bit signed integers.
- **Edge Cases:** The design effectively manages edge cases, including zero values and extreme positive/negative values for 16-bit integers.

This module provides an efficient and accurate way to multiply two 16-bit signed integers, utilizing basic arithmetic operations and a structured addition approach.

## Running the Code

### 1. Run the Makefile

Use the provided `Makefile` in src/Combinational Circuit directory to compile and simulate the Verilog code. Execute the following command to perform the simulation:

```bash
make
```

This will:

- **Compile the Verilog files using `iverilog`**:
  - This step will generate an output file (e.g., `out`) from your Verilog source files.

- **Run the simulation with `vvp`**:
  - Execute the compiled file to perform the simulation.

- **Generate the waveform file (`dump.vcd`) for visualization**:
  - The simulation should produce a VCD file that can be used for viewing waveforms in GTKWave or similar tools.


### 2. View the Simulation Results

To view the waveform results and analyze the simulation output, run:

```bash
make view
```

This command will open dump.vcd using GTKWave, allowing you to inspect the waveforms and verify the operation of the multiplier.

### 3. Clean Up

To remove generated files and clean up the working directory, run:

```bash
make clean
```

This will delete the out and dump.vcd files created during the simulation process.

