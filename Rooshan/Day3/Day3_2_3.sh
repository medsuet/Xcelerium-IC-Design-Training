#!/bin/bash
i=1
num=$(( RANDOM % 10 + 1 ))
guess=-1
while [[ $guess -ne $num ]] ; do
	echo "Enter a number"
	read guess
	if [[ $guess -eq $num ]]
	then
		echo "Correct"
	elif [[ $guess -gt $num ]]
	then
		echo "lower"
	else
		echo "Higher"
	fi
done


