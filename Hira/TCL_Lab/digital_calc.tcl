# Basic digital design calculations
#============================================================================
# Filename:    digital_calc.tcl
# Description: - The script first calculates the clock period based on a given clock frequency.
#              - It then defines a procedure to calculate the power consumption of a CMOS 
#                circuit and uses it to compute the power based on given capacitance, voltage,
#                and frequency.
#              - Finally, it calculates the maximum frequency based on propagation delay,
#                calculates the number of cycles and setup time, printing all results.
# Author:      Hira Firdous
# Date:        09/07/2024
# ===========================================================================
#
#
#
# Define clock frequency and calculate period
set clock_freq_mhz 100
#Clock frequency have direct relation with power consumption
#and inverse with clock cycle



set clock_period_ns [expr {1000.0 / $clock_freq_mhz}]
puts "Clock period: $clock_period_ns ns"
# Calculate power for a simple CMOS circuit
proc calc_power {capacitance voltage frequency}\
{ 
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

# New calculation: Number of clock cycles in a given time period
set time_period_ns 1000.0  
set num_clock_cycles [expr {$time_period_ns / $clock_period_ns}]
puts "Number of clock cycles in $time_period_ns ns: $num_clock_cycles"

