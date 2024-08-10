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

# Function to calculate the number of clock cycles in a given time period
proc calc_clock_cycles {time_ns clock_period_ns} {
    return [expr {int($time_ns / $clock_period_ns)}]
}

# Test the function with a time period of 1000 ns
set time_ns 1000
set num_cycles [calc_clock_cycles $time_ns $clock_period_ns]
puts "Number of clock cycles in $time_ns ns: $num_cycles"

# Modify clock frequency and observe effects
set clock_freq_mhz 200
set clock_period_ns [expr {1000.0 / $clock_freq_mhz}]
set power_mw [calc_power $cap_pf $voltage $clock_freq_mhz]
set max_freq_mhz [expr {1000 / ($prop_delay_ns + $setup_time_ns)}]
set num_cycles [calc_clock_cycles $time_ns $clock_period_ns]

puts "Updated clock frequency: $clock_freq_mhz MHz"
puts "Updated clock period: $clock_period_ns ns"
puts "Updated power consumption: $power_mw mW"
puts "Updated maximum frequency: $max_freq_mhz MHz"
puts "Updated number of clock cycles in $time_ns ns: $num_cycles"

