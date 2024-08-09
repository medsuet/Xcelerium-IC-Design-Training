# Define a list of module names
set modules {ALU Register_File Decoder Multiplexer}

# Print all modules
puts "All modules:"
foreach module $modules {
    puts " $module"
}

# Add new modules
lappend modules "Control_Unit" "Memory" "Cache" "Bus_Interface" "Pipeline_Stages"
puts "\nAfter adding more modules:"
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
dict set module_sizes Memory 8000
dict set module_sizes Cache 3000
dict set module_sizes Bus_Interface 1200
dict set module_sizes Pipeline_Stages 4000

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

# Procedure to find modules larger than a given size
proc find_modules_larger_than {module_sizes threshold} {
    set larger_modules {}
    dict for {module size} $module_sizes {
        if {$size > $threshold} {
            lappend larger_modules $module
        }
    }
    return $larger_modules
}

# Example usage of the procedure
set threshold 2000
set larger_modules [find_modules_larger_than $module_sizes $threshold]
puts "\nModules larger than $threshold gates:"
foreach module $larger_modules {
    puts " $module"
}