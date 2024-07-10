#  ============================================================================
#  Filename:    fileop.sh 
#  Description: File consists of tcl file implementing the list and dictionary
#  Author:      Bisal Saeed
#  Date:        7/9/2024
#  ============================================================================

#LIST IMPLEMENTATION

# print a module
# Define a list of module names
set modules {ALU Register_File Decoder Multiplexer}
# Print all modules
puts "All modules:" ;#just a string print
#print modules in list --> for each module in list modules print name of module one after another
foreach module $modules { puts " $module" }

# Add a new modules
lappend modules "Control_Unit"
puts "\nAfter adding Control_Unit:"
#print the whole list 
puts $modules

lappend modules "Data_Path"
puts "\nAfter adding Data_Path:"
#print the whole list 
puts $modules 

lappend modules "Intermediate_Generator"
puts "\nAfter adding Intermediate_Generator:"
#print the whole list 
puts $modules

# Remove a module
#search for all elements in modules whose line does not have decoder word and save it in modules list
set modules [lsearch -all -inline -not $modules "Decoder"]
puts "\nAfter removing Decoder:"
#print modified list
puts $modules

#DICTIONARIES IMPLEMENTATION

# Define a dict of module sizes (simulated gate count)
#key value pairs
dict set module_sizes ALU 1000 
dict set module_sizes Register_File 5000 
dict set module_sizes Multiplexer 200 
dict set module_sizes Control_Unit 1500
dict set module_sizes Data_Path 4000
dict set module_sizes Intermediate_Generator 300


# Calculate total gate count
set total_gates 0 
dict for {module size} $module_sizes {
    #add size of each module to total gates
 set total_gates [expr {$total_gates + $size}]
}
puts "\nTotal gate count: $total_gates"


# Find the largest module
set max_size 0 
#empty string 
set largest_module ""
dict for {module size} $module_sizes {
 if {$size > $max_size} {
    #find the maximum size of given modules and select one with largest value
 set max_size $size
 set largest_module $module
 }
 }
puts "Largest module: $largest_module with $max_size gates"


# Procedure to find and print modules larger than a given size
proc find_large_modules {threshold_size} {
    #take the dictionary defined globally outside the procedure
    global module_sizes
    #empty string 
    set large_modules {}
    
    # Iterate over each key-value pair in the dictionary module_sizes
    dict for {module size} $module_sizes {
        # If the size of the current module is greater than the threshold_size
        if {$size > $threshold_size} {
            #append all modules greater than that threshold to the empty array 
            lappend large_modules $module
        }
    }
    puts "Modules larger than $threshold_size gates: $large_modules"
}
#call the procedure
find_large_modules 1000
