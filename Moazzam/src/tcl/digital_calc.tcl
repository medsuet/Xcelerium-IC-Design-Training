
# Basic digital design calculations
# Define clock frequency and calculate period
set clock_freq_mhz 100
set clock_period_us [expr {1000.0 / $clock_freq_mhz}]
puts "Clock period: $clock_period_us us"

# Calculate power for a simple CMOS circuit
proc calc_power {capacitance voltage frequency}\
{
    return [expr {$capacitance * $voltage * $voltage * $frequency}]
}

set cap_pf 10.0
set voltage 1.2
set power_uw [calc_power $cap_pf $voltage $clock_freq_mhz]
puts "Power consumption: $power_uw uW"

# Simple timing calculation
set prop_delay_ns 2.5
set setup_time_ns 0.5
set max_freq_Ghz [expr {1000 / ($prop_delay_ns + $setup_time_ns)}]
puts "Maximum frequency: $max_freq_Ghz GHz"

#Number of Cycle
set number_of_cc [ expr {$clock_freq_mhz * $clock_period_us} ]
puts "Number of Clock Cycle is: $number_of_cc "

#Discussion:
#Firstly it find the clk_period in Micro_Sec  becuse 1/Mega = Micro
#second it calucate the power consumption of Micro_watt  
#--> after the name od funtion put \
#Simple timing calculation
#Number of Cycle 