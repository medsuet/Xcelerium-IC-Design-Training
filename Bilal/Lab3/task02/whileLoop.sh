#!/bin/bash

echo "Simple Guessing Game"

# Generate a random number between 1 and 10
target=$(( (RANDOM % 10) + 1 ))

echo "Welcome to the guessing game!"
echo "I'm thinking of a number between 1 and 10..."

while true; do
    # Ask the user to guess the number
    read -p "Enter your guess (between 1 and 10): " guess

    # Check if the guess is correct
    if [ "$guess" -eq "$target" ]; then
        echo "Congratulations! You guessed correctly."
        break
    elif [ "$guess" -lt "$target" ]; then
        echo "Try higher."
    else
        echo "Try lower."
    fi
done

