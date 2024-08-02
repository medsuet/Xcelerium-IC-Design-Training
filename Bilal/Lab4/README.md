
# TCL Scripting

## Overview:

The purpose of this lab is to understand the basics of TCL script to perform basic operations and calculations that are common in digital design. The provided scripts will calculate the clock period, power consumption of a CMOS circuit, and the maximum operating frequency based on propagation delay and setup time.



### Lab 1: Basic TCL Operations and Digital Design Calculations

## Steps:

1. Create the file by running the following command on your terminal `touch digital_calc.tcl`

2. Copy code from the the file `digital_calc.tcl` given in src.

3. Save the file.
4. Open a terminal, navigate to the directory containing your script, and run:
    ```sh
    tclsh digital_calc.tcl
    ```
5. Observe the output and verify the calculations.
6. Experiment with the script:
    - Modify the `clock_freq_mhz` and observe how it affects other calculations.
    - Add a new calculation, such as determining the number of clock cycles in a given time period.




### Lab 2: Working with Lists and Digital Design Data

## Steps:

1. Create the file by running the following command on your terminal `touch digital_data.tcl`

2. Copy code from the the file `digital_data.tcl` given in src.

3. Save the file.
4. Open a terminal, navigate to the directory containing your script, and run:
    ```sh
    tclsh design_data.tcl
    ```
5. Observe how the script manipulates lists and dictionaries to simulate working with design data.
6. Experiment with the script:
    - Add more modules and sizes.
    - Implement a procedure to find modules larger than a given size.

