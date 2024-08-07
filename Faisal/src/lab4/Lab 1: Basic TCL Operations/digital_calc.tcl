# Basic digital design calculations  

# Define clock frequency and calculate period  
set clock_freq_mhz 100 
set clock_period_ns [expr {1000.0 / $clock_freq_mhz}]  
puts "Clock period: $clock_period_ns ns"  

# Calculate power for a simple CMOS circuit  
proc calc_power {capacitance voltage frequency} {  
   return [expr {$capacitance * $voltage * $voltage * $frequency}]  
}  
set capacitance_pf 10.0  
set voltage 1.2  
set power_mw [calc_power $capacitance_pf $voltage $clock_freq_mhz]  
puts "Power consumption: $power_mw mW"  

# Simple timing calculation  
set propagation_delay_ns 2.5  
set setup_time_ns 0.5  
set max_freq_mhz [expr {1000 / ($propagation_delay_ns + $setup_time_ns)}]  
puts "Maximum frequency: $max_freq_mhz MHz"  

# Calculate number of clock cycles in a given time period
set time_period_ns 100
set num_clock_cycles [expr {$time_period_ns / $clock_period_ns}]
puts "Number of clock cycles in $time_period_ns ns: $num_clock_cycles"
