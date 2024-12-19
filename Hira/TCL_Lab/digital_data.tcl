#============================================================================
# Filename:    digital_data.tcl
# Description: - The file initializes an assosiative list names modules.
# 		 modules contain all the detail about the modules(name,size)
# 	       - inintialize and decalre there sizes.
# 	       - A Procedure: finds the modules have size larger than the
# 	       		      threshold
# 	       - Finally it print the list. the largest module in list 
# 	         and modules having size larger than 1000.0
# Author:      Hira Firdous
# Date:        09/07/2024
# ===========================================================================



# Define a list of module names
set modules {ALU Register_File Decoder Multiplexer}


# Print all modules
puts "All modules:"
foreach module $modules { puts " $module" }


# Add a new module
lappend modules "Control_Unit"
puts "\nAfter adding Control_Unit:"
puts $modules

#ADDING more modules
lappend modules "Memory_Unit"
puts "\n After adding memory unit"

lappend modules "IO_Interface"
puts "\n After adding IO_interface"


# Remove a module
set modules [lsearch -all -inline -not $modules "Decoder"]
puts "\nAfter removing Decoder:"
puts $modules


# Define a dict of module sizes (simulated gate count)
dict set module_sizes ALU 1000 
dict set module_sizes Register_File 5000 
dict set module_sizes Multiplexer 200 
dict set module_sizes Control_Unit 1500

#New Added
dict set module_sizes Memory_Unit 8000
dict set module_sizes IO_Interface 600



# Calculate total gate count
set total_gates 0 
dict for {module size} $module_sizes {
 set total_gates [expr {$total_gates + $size}]
}
puts "\nTotal gate count: $total_gates"


# Find the largest module
set max_size 0 
set largest_module ""
dict for {module size} $module_sizes {
 if {$size > $max_size} {
 set max_size $size
 set largest_module $module
 }
 }
puts "Largest module: $largest_module with $max_size gates"



# Implement a procedure to find modules larger than a given size
proc find_large_modules {module_sizes threshold} {

	#arguments: takes modules_sizes and threshold
	#append all the modules having size larger than threshold
	#return : an array having modules larger than threshold
	
    set large_modules {}
    dict for {module size} $module_sizes {
        if {$size > $threshold} {
            lappend large_modules $module
        }
    }
    return $large_modules
}

# testing the proc
set threshold 1000
set large_modules [find_large_modules $module_sizes $threshold]
puts "\nModules larger than $threshold gates:"
foreach module $large_modules { puts " $module" }
