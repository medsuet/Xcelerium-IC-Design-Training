#!/bin/bash 

fruits=("apple" "banana" "cherry")

print_fruits() {
    for fruit in "${fruits[@]}"; do
        echo $fruit
    done
}

fruits+=("date")
print_fruits
