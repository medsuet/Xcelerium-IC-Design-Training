#!/bin/bash

max=10
min=1
# to calculate random number from max to min
num=$(( (RANDOM % ($max-$min+1) + $min) ))
guess=0

echo "Computer has succesfully guessed a number!"

while :
	do
		read -p "Guess a number: " guess
		if [ $guess -eq $num ]; then    # equal
			echo "You've succesfully guessed the number!"
			break
		elif [ $guess -gt $num ]; then  # guess > num
			echo "Guess Lower!"
		else                            # guess < num
			echo "Guess Higher!"
		fi
	done
