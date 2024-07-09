# Digital Design Calculations


## Files

### `digital_calc.tcl`
- **Description**: This script calculates the clock period based on a given clock frequency, computes the power consumption of a CMOS circuit, and calculates the maximum frequency based on propagation delay and setup time.
- **Key Features**:
  - Calculates clock period from clock frequency
  - Computes power consumption of a CMOS circuit
  - Calculates maximum frequency based on propagation delay and setup time
  - Determines the number of clock cycles in a given time period

### `digital_data.tcl`
- **Description**: This script initializes an associative list of module names and their corresponding gate counts, performs various operations on the list, and implements a procedure to find modules larger than a given size threshold.
- **Key Features**:
  - Initializes a list of module names
  - Adds and removes modules from the list
  - Stores module sizes in a dictionary
  - Calculates the total gate count
  - Finds the largest module
  - Implements a procedure to find modules larger than a given size threshold

## Usage
tclsh filename
## Author
- Hira Firdous

## Date
- 09/07/2024
