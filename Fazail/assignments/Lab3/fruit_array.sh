#!/bin/bash

#declare an array
fruit_arr=("apple" "orange")

function array_element(){
    echo "${fruit_arr[*]}"
}

echo "The initial array is"
array_element
echo " "

#append the fruit in the array
echo "New Array"
fruit_arr+=("banana")
array_element