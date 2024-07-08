#!/bin/bash

fact() {
    if [ $1 -eq 0 ] || [ $1 -eq 1 ]; then
        echo 1
    else
        echo $(( $1*$(fact $(($1 - 1))) ))
    fi
}

# Call the calculate_factorial function with different numbers and print the results
echo "Factorials:"
echo "-----------"
for num in 0 1 2 3 4 5; do
    factorial=$(fact $num)
    echo "Factorial of $num is: $factorial"
done

