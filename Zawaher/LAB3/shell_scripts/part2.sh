#!/bin/bash

echo "Checking Even Odd number"

if [ $(($1 % 2)) -eq 0 ]; then
    echo "The number $1 is even"
else
    echo "The number $1 is odd"
fi

echo "First 10 Multiples of a Number"

for ((i = 1; i <= 10 ; i++))
do 
	echo " The $i multiple of $1 is : $(($1*$i))"
done
echo ""	
echo " _____________"
echo "|             |"
echo "|Guessing Game|"
echo "|_____________|"
echo ""

# Initialize a random number between 1 and 10
number=$((RANDOM % 10 + 1))

read -p "Enter your guess: " guess

# Loop until the guess is correct
while [ $guess -ne $number ]
do 
    if [ $guess -gt $number ]; then
        echo "The number is less than your guess"
    elif [ $guess -lt $number ]; then
        echo "The number is greater than your guess"
    fi
    read -p "Enter a new guess: " guess
done

echo "Correct! The number is $number"

