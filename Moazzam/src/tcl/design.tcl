# Simulating digital design data operations
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
dict set module_sizes Multiplexer 2000
dict set module_sizes Control_Unit 1500
dict set module_sizes New_Unit 200

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

# Find the module larger than given number
set size_limit 1600
set larger_module {}
dict for {module size} $module_sizes {
    if {$size > $size_limit} {
        lappend larger_module " $module"
    }
}
puts "Larger module are : $larger_module with size grater than $size_limit gates"