# Simulating digital design data operations
# Define a list of module names
set modules {ALU Register_File Decoder Multiplexer}
# Print all modules
puts "All modules:"
foreach module $modules { puts " $module" }
puts "--------------------------------------------------"
# Add a new module
lappend modules "Control_Unit"
puts "\nAfter adding Control_Unit:"
puts $modules
puts "--------------------------------------------------"
lappend modules "LSU"
puts "After Adding LSU:"
puts $modules
puts "--------------------------------------------------"
# Remove a module
set modules [lsearch -all -inline -not $modules "Decoder"]
puts "\nAfter removing Decoder:"
puts $modules
puts "--------------------------------------------------"
# Define a dict of module sizes (simulated gate count)
dict set module_sizes ALU 1000
dict set module_sizes Register_File 5000
dict set module_sizes Multiplexer 200
dict set module_sizes Control_Unit 1500
dict set module_sizes LSU 300
# Calculate total gate count
set total_gates 0
dict for {module size} $module_sizes {
 set total_gates [expr {$total_gates + $size}]
}
puts "\nTotal gate count: $total_gates"
puts "--------------------------------------------------"
# Find the largest module
set max_size 0
set largest_module ""
dict for {module size} $module_sizes {
 if {$size > $max_size} {
 set max_size $size
 set largest_module $module
 }
}
puts "Largest module: $largest_module with $max_size gates\n"
puts "--------------------------------------------------"
#Find Modules larger than given size
proc large_module {size_given module_sizes} {
    puts "Modules having size greater than given size:"
    dict for {module size}  $module_sizes {
        if {$size > $size_given} {
            puts $module
        }
    }
}
set size_given 400
puts "Given size is:$size_given"
large_module $size_given $module_sizes