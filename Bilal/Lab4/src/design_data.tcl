# Define a list of module names

set modules {ALU Register_File Decoder Multiplexer}

# Print all modules

puts "All modules:"
foreach module $modules { puts " $module" }

# Add a new module

lappend modules "Control_Unit"
puts "\nAfter adding Control_Unit:"
puts $modules

# Remove a module

set modules [lsearch -all -inline -not $modules "Decoder"]
puts "\nAfter removing Decoder:"
puts $modules

# Define a dict of module sizes (simulated gate count)

dict set module_sizes ALU 1000
dict set module_sizes Register_File 5000
dict set module_sizes Multiplexer 200
dict set module_sizes Control_Unit 1500

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

# Find module larger than a given size

puts "Enter the size above which the modules should be listed"

gets stdin largest_size

proc larger_module {largest_size module_sizes } {
	dict for {module size} $module_sizes {
		if  {$size > $largest_size} {
			puts "The modules larger than the $largest_size are:"
			puts "$module"
		}
	}
}

larger_module $largest_size $module_sizes

 
