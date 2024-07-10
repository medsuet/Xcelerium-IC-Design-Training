#!/bin/bash
array=("apple" "orange" "banana")
printArray(){
    for fruit in "${array[@]}"
    do
        echo $fruit
    done
}
echo -e "Array is:\n$(printArray array)" #echo command with the -e flag to enable interpretation of backslash escapes
array[3]+="cherry"
echo -e "Array is:\n$(printArray array)"