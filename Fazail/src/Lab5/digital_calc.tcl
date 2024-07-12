# Basic digital design calculations

# Define clock frequency and calculate period
set clock_freq_mhz 100.0
set clock_period_ns [expr {1000.0 / $clock_freq_mhz}]
set cycles_per_period [expr {$clock_freq_mhz * $clock_period_ns}]
puts "Clock period: $clock_period_ns ns"
puts "Clock Cycles in a given Time Period: $cycles_per_period cycles"

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