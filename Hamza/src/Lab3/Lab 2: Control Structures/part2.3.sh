#!/bin/bash 

target=$((RANDOM % 10 + 1))

while true; do
    read -p "Guess the number: " guess
    if [ $guess -eq $target ]; then
        echo "Correct!"
        break
    elif [ $guess -lt $target ]; then
        echo "Higher"
    else
        echo "Lower"
    fi
done
