#!/bin/bash
#initializing an array
fruits=("Apple" "banana" "peach")

#defining function for prinitng array
print_array() {
  echo "listing all fruits"
  for fruit in "${fruits[@]}"; do
	  echo " $fruit "
  done

}
print_array
fruits+=("grapes")
print_array
