#!/bin/tclsh

set clock_freq_mhz 100
set clock_period_ns [expr {1000/$clock_freq_mhz}]
puts "Clock_period : $clock_period_ns ns" 
proc calc_power {capacitance voltage freq} {
    return [expr {$capacitance*$voltage*$voltage*$freq}]
}
set cap_pf 10.0
set voltage 1.2
set power_mw [calc_power $cap_pf $voltage $clock_freq_mhz]
puts "Power_consumption : $power_mw nW"
#simple timming calculation
set prop_delay_ns 2.5
set setup_time_ns 0.5
set max_freq_mhz [expr {1000/($prop_delay_ns + $setup_time_ns)}]

puts "Maximum_freq : $max_freq_mhz MHz"

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

puts "updated clock frequency: $clock_freq_mhz MHz"
puts "updated clock period: $clock_period_ns ns"
puts "updated power consumption: $power_mw mW"
puts "updated maximum frequency: $max_freq_mhz MHz"
puts "updated number of clock cycles in $time_ns ns: $num_cycles"
