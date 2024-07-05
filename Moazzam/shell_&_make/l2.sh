#!/bin/bash


if [ $(($1%2)) -eq 0 ]; then
    echo "the number $1 is enven number"
else 
    echo "the number $1 is odd number"
fi


#first 10 multiple
for (( c=1; c<=10; c++ ))
do 
   echo "the $c multiple of $2 is $(($2*$c))"
done

# Generate a random number within a specific range
random_number=$((1 + RANDOM % 10))

while :
do
    echo "Guess the Number:"
    read guess
    if [ $guess -eq $random_number ]; then
        echo "the number guess is True."
        break
    elif [ $guess -lt $random_number ]; then
        echo "guess the larger number."    
    else 
        echo "guess the smaller number."
    fi
done
