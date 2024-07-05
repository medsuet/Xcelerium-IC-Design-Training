#!/bin/bash
# Guess a number
echo "Guess number between 1 and 99"
SECRETNUM=83
until [[ $guessnum == $SECRETNUM ]];
do
    read -p "Guess: " guessnum
    if [[ $guessnum == $SECRETNUM ]]
    then
        echo "Correct guess"
    elif [[ $guessnum < $SECRETNUM ]]
    then
        echo "Guess higher"
    else
        echo "Guess lower"
    fi
done
