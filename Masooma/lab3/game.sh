#!/bin/bash
read -p "Enter your guess:" GUESS
random=$(($(($RANDOM%10))+1))
while [ $random -ne $GUESS ]
do
    if [ $GUESS -lt $random ]; then
        echo "Guess Higher"
    else
        echo "Guess Lower"
    fi
    echo "Try, again"
    read -p "Enter your guess:" GUESS
done
echo "Success"

