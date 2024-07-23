# 16-bit Combinational Multiplier Simulation

This project includes a SystemVerilog design for a signed multiplier and a testbench. The provided `Makefile` automates the process of compiling, simulating, and viewing the simulation results.

## Project Files

- `signed_comb_multiplier.sv`: SystemVerilog module for the signed multiplier.
- `signed_comb_multiplier_tb.sv`: SystemVerilog testbench for the multiplier.

## Makefile Targets

- **`all`**: The default target, which compiles the design, runs the simulation, and then views the results.
- **`compile`**: Compiles the SystemVerilog files using `iverilog`.
- **`simulate`**: Runs the simulation using `vvp`.
- **`view`**: Opens the waveform file using `gtkwave`.
- **`clean`**: Removes generated files (`sim` and `waveform.vcd`).

## Usage

1. **Compile the Design and Testbench**

   ```bash
   make compile
   ```
2. **Run the Simulation**
    ```bash
    make simulate
    ```
3. **View the Results**
    ```bash
    make view
    ```
4. **Clean Up**
    ```bash
    make clean
    ```