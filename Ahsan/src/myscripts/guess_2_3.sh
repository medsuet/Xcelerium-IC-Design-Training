#!/bin/bash
#taking random value

target=$(( RANDOM % 100 + 1 ))

#initializing the user guess to be zero
guess=0

while [ $guess -ne $target ]; do
	echo " guess a number between 1 and 100 "
	read guess

	if [ $guess -lt $target ]; then
		echo "guess higher"
	elif [ $guess -gt $target ]; then
                echo "guess lower"
	fi
done
echo " congratulations"
