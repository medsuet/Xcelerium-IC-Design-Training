#!/bin/bash

# Generate a random number between 1 and 10
target=$(( (RANDOM % 10) + 1 ))

# Initialize the guess variable
guess=0

# Prompt the user to guess until they get it right
while [ "$guess" -ne "$target" ]; do
  # Read the user's guess
  read -p "Guess a number between 1 and 10: " guess

  # Provide feedback on the guess
  if [ "$guess" -lt "$target" ]; then
    echo "Higher!"
  elif [ "$guess" -gt "$target" ]; then
    echo "Lower!"
  else
    echo "Congratulations! You guessed the correct number: $target"
  fi
done



