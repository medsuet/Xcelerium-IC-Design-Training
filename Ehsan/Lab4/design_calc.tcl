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
