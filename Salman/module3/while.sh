#!/bin/bash

max=10
min=1

num=$(( (RANDOM % ($max-$min+1) + $min) ))
guess=0

echo "Computer has succesfully guessed a number!"

while :
	do
		read -p "Guess a number: " guess
		if [ $guess -eq $num ]; then
			echo "You've succesfully guessed the number!"
			break
		elif [ $guess -gt $num ]; then
			echo "Guess Lower!"
		else
			echo "Guess Higher!"
		fi
	done
