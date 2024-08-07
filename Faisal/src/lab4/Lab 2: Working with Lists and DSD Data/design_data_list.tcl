# Simulating digital design data operations

# Define a list of module names
set modules {ALU Register_File Decoder Multiplexer}

# Print all modules
puts "All modules:"
foreach module $modules { 
    puts " $module" 
}

# Add more modules and their sizes use dictionary with keys and its values
dict set module_sizes ALU 1000
dict set module_sizes Register_File 5000
dict set module_sizes Multiplexer 200
dict set module_sizes Control_Unit 1500
dict set module_sizes Decoder 800

lappend modules "Cache"
lappend modules "Arithmetic_Logic_Unit"

# Print all modules with sizes
puts "\nAll modules with sizes:"
dict for {module size} $module_sizes {
    puts "$module: $size gates"
}

# Remove a module
set modules [lsearch -all -inline -not $modules "Decoder"]
puts "\nAfter removing Decoder:"
puts $modules

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
        set max_size  $size
        set largest_module $module
    }
}
puts "Largest module: $largest_module with $max_size gates"

# Procedure to find modules larger than a given size
proc findLargerModules {sizeThreshold} {
    set largerModules {}
    dict for {module size} $::module_sizes {
        if {$size > $sizeThreshold} {
            lappend largerModules $module
        }
    }
    return $largerModules
}

# Find modules larger than a specified gate count
set sizeThreshold 1000
set largerModules [findLargerModules $sizeThreshold]
if {[llength $largerModules] > 0} {
    puts "\nModules larger than $sizeThreshold gates:"
    foreach module $largerModules {
        puts " $module"
    }
} else {
    puts "\nNo modules found larger than $sizeThreshold gates."
}
