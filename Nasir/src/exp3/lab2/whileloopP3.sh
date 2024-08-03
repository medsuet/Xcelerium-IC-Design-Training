#!/bin/bash

# Generate a random number between 1 and 10
random_number=$((RANDOM % 10 + 1))

# Initialize the user's guess
guess=0

echo "Guess the number between 1 and 10"

# Loop until the user guesses correctly
while [ "$guess" -ne "$random_number" ]; do
  # Read the user's guess
  # -p is used to display message to the user like "Enter your guess: " in this case
  read -p "Enter your guess: " guess

  # Provide hints
  if [ "$guess" -lt "$random_number" ]; then
    echo "Enter Higher Number"
  elif [ "$guess" -gt "$random_number" ]; then
    echo "Enter Lower Number"
  else
    echo "Good, You guessed the right number: $random_number"
  fi
done
