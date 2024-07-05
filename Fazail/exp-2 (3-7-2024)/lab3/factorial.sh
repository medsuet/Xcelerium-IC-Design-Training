#!/bin/bash

value=$1
factorial=1

# Function of factorial
function factorial(){
    local fact=$value
    while [ $value -gt 0 ] #while value > 0
    do
        factorial=$(($factorial * $value))
        value=$(( $value - 1 ))
    done

    if [ $fact -gt 0 ]
    then
        echo "The factorial is $factorial"
    else 
        echo "Enter the non-negative number"
    fi
}

#invoking function 
factorial