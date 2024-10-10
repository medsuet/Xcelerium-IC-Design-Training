#!/bin/bash
factorial() {
    if [ $1 -eq 0 ] || [ $1 -eq 1 ]; then
        echo 1
    else
        local next=$(($1-1))
        echo $(($1*$(factorial $next)))
    fi
}
read -p "Enter a number:" NUM
result=$(factorial $NUM)
echo "Factorial is: $result"
