# Digital Design and Verification Training - TCL Scripting


## Lab 1: Basic TCL Operations and Digital Design Calculations

### Task Description
In this lab, you will write a TCL script to perform basic operations and calculations that are common in digital design. The script will calculate the clock period, power consumption of a CMOS circuit, and the maximum operating frequency based on propagation delay and setup time.

### Steps
1. Open your text editor and create a new file named `digital_calc.tcl`.
2. Copy the following script into the file:

    ```tcl
    # Basic digital design calculations

    # Define clock frequency and calculate period
    set clock_freq_mhz 100
    set clock_period_ns [expr {1000.0 / $clock_freq_mhz}]
    puts "Clock period: $clock_period_ns ns"

    # Calculate power for a simple CMOS circuit
    proc calc_power {capacitance voltage frequency} {
        return [expr {$capacitance * $voltage * $voltage * $frequency}]
    }
    set cap_pf 10.0
    set voltage 1.2
    set power_mw [calc_power $cap_pf $voltage $clock_freq_mhz]
    puts "Power consumption: $power_mw mW"

    # Simple timing calculation
    set prop_delay_ns 2.5
    set setup_time_ns 0.5
    set max_freq_mhz [expr {1000 / ($prop_delay_ns + $setup_time_ns)}]
    puts "Maximum frequency: $max_freq_mhz MHz"
    ```

3. Save the file.
4. Open a terminal, navigate to the directory containing your script, and run:
    ```sh
    tclsh digital_calc.tcl
    ```
5. Observe the output and verify the calculations.
6. Experiment with the script:
    - Modify the `clock_freq_mhz` and observe how it affects other calculations.
    - Add a new calculation, such as determining the number of clock cycles in a given time period.


## Lab 2: Working with Lists and Digital Design Data

### Task Description
In this lab, you will create a TCL script to manipulate lists, simulating operations on digital design data. The script will perform operations such as adding and removing modules, calculating the total gate count, and finding the largest module by gate count.

### Steps
1. Create a new file named `design_data.tcl`.
2. Copy the following script into the file:

    ```tcl
    # Simulating digital design data operations

    # Define a list of module names
    set modules {ALU Register_File Decoder Multiplexer}

    # Print all modules
    puts "All modules:"
    foreach module $modules { puts " $module" }

    # Add a new module
    lappend modules "Control_Unit"
    puts "\nAfter adding Control_Unit:"
    puts $modules

    # Remove a module
    set modules [lsearch -all -inline -not $modules "Decoder"]
    puts "\nAfter removing Decoder:"
    puts $modules

    # Define a dict of module sizes (simulated gate count)
    dict set module_sizes ALU 1000
    dict set module_sizes Register_File 5000
    dict set module_sizes Multiplexer 200
    dict set module_sizes Control_Unit 1500

    # Calculate total gate count
    set total_gates 0
    dict for {module size} $module_sizes {
        set total_gates [expr {$total_gates + $size}]
    }
    puts "\nTotal gate count: $total_gates"

    # Find the largest module
    set max_size 0
    set largest_module ""
    dict for {module size} $module_sizes {
        if {$size > $max_size} {
            set max_size $size
            set largest_module $module
        }
    }
    puts "Largest module: $largest_module with $max_size gates"
    ```

3. Save the file.
4. Open a terminal, navigate to the directory containing your script, and run:
    ```sh
    tclsh design_data.tcl
    ```
5. Observe how the script manipulates lists and dictionaries to simulate working with design data.
6. Experiment with the script:
    - Add more modules and sizes.
    - Implement a procedure to find modules larger than a given size.

