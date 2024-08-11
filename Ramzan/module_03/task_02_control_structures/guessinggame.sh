#!/bin/bash

random_number=$(( (RANDOM)%10 + 1)) #will generate a random number between 1 and 10
echo "Enter a guess number"
read guess
while [ $random_number -ne $guess ]
do
	if [ $random_number -gt $guess ];then
		echo "Enter a heigher number."
	elif [ $random_number -lt $guess ];then
		echo "Enter a lower number."
	fi
	read guess
done
echo "Congratulation you have won the game and number is: $guess"



