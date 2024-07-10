#  ==================================================================================
#  Filename:    fileop.sh 
#  Description: File consists of codes based on concepts of basic calculations in tcl
#  Author:      Bisal Saeed
#  Date:        7/9/2024
#  ==================================================================================

# Basic digital design calculations

# Define clock frequency 
set clock_freq_mhz 100

# expr is used to evaluate mathematical expressions
#calcuate the clock_period in nano seconds
set clock_period_ns [expr {1000.0 / $clock_freq_mhz}]

#print the value of clock_period
puts "Clock period: $clock_period_ns ns"

#POWER CALCULATIONS
# Calculate power for a simple CMOS circuit
#calc_power procedure is defined taking three arguments capacitance,voltage and frequency.
proc calc_power {capacitance voltage frequency}\
{
 #The power is calculated using the formula P = C * V^2 * f, where P is power, C is capacitance, V is voltage, and f is frequency.
 return [expr {$capacitance * $voltage * $voltage * $frequency}]
}

#intitialize values of capacitance,voltage
set cap_pf 10.0 
set voltage 1.2 

#call the procedure and set final output value to power_mw variable
set power_uw [calc_power $cap_pf $voltage $clock_freq_mhz]

#print the power measured in mirco Watt
puts "Power consumption: $power_uw uW"

# SIMPLE TIMING CALCULATION
#Propagation Delay (t_pd) is the time taken for a signal to travel from the input to the output of a digital circuit.
#t_pd=t_output_transition − t_input_transition
set prop_delay_ns 2.5

#the data must be held constant for this period to ensure it is correctly sampled by the clock edge
set setup_time_ns 0.5 

#we want the maximum frequency in MHz (megahertz), so we need to convert the total time from nanoseconds to microseconds first so (/1000)
#measure the max_freq_mhz by formula --> 1/total_time(prop_delay_ns+setup_time_ns)/1000(microseconds)
set max_freq_mhz [expr {1000 / ($prop_delay_ns + $setup_time_ns)}]
#print the max_frequency
puts "Maximum frequency: $max_freq_mhz MHz"



# NUMBER OF CLOCK CYCLES CALCULATION
set time_period_ns 5000 ;
# Calculate the number of clock cycles
proc num_cycles {time_period_ns clock_period_ns}\
{
    return [expr {$time_period_ns / $clock_period_ns}]
}
set cycles [num_cycles $time_period_ns $clock_period_ns]
puts "Number of clock cycles in $time_period_ns ns: $cycles"




