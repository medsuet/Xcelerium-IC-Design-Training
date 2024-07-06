#!/bin/bash
# The Guessing Game
# Generate a random number between 1 and 10
random_num=$(((RANDOM % 10) + 1))

# Initial guess
read -p "Guess a number between 1 and 10: " guess
guess1=$((guess))

# Loop until the user guesses the correct number
while [ $guess1 -ne $random_num ]; do
    if [ $guess1 -gt $random_num ]; then 
	    echo "Lower"
	elif [ $guess1 -lt $random_num ]; then 
		echo "Higher"
	fi

    # Prompt for another guess
	read -p "Guess a number between 1 and 10: " guess
	guess1=$((guess))
done

# When the correct number is guessed
echo "Congratulations! You have guessed it right."
echo "The guess number is $guess1 and the random number is $random_num."

