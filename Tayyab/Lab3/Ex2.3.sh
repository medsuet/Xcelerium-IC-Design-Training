#!/bin/bash
# Guess a number
echo "Guess a number"
SECRETNUM=83

until [[ $guessnum == $SECRETNUM ]]:
do
    read -p "Guess: " guessnum
    if (( $guessnum == $SECRETNUM ))
    then
        echo "Correct guess"
    elif (( $guessnum < $SECRETNUM ))
    then
        echo "Guess higher"
    else
        echo "Guess lower"
    fi
done
