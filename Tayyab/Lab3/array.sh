#!/bin/bash
function printArray() {
    echo ${fruits[@]}
}

fruits=(apple mango banana grapes peach)
echo "Initial array:"
printArray
lengthArray=${#fruits[@]}
fruits[lengthArray]=orange
echo "Add a fruit:"
printArray
