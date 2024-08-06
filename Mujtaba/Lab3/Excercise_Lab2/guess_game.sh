#!/usr/bin/env bash
rand=$(($RANDOM % 11))
echo "Guess the number between 0 and 10:"
while read input 
do 
    if [ $input -eq $rand ]; then
        echo Congratulations! You guess the correct number.
        break
    elif  [ $input -lt $rand ]; then
        echo Your guess is smaller than the orignal number. Try Again: 
    elif [ $input -gt $rand ]; then 
        echo Your guess is larger than the orignal number. Try Agian: 
    fi
done
