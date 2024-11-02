#!/bin/bash

read -p "Enter the number to find the factorial: " NUM

factorial() {
    if [ $1 -eq 0 ]; then
        echo 1
    else
        next=$(( $1 - 1 ))
        fact=$(factorial $next)
        result=$(( $1 * fact ))
        echo $result
    fi
}

answer=$(factorial $NUM)
echo "Factorial of $NUM is $answer."

