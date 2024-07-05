#!/bin/bash
#printing array 
printing_array() {
    for fruit in "${fruits[@]}"; do
        echo " $fruit "
    done
}

fruits=("apple" "cherry" "pineapple")

#printing_array

fruits+=("green_apple")

#printing_array

#echo "${fruits[1]}"
