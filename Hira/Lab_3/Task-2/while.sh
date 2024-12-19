#!/bin/bash
echo "Welcome to number guessing game"

original_num=$(($RANDOM%11))


while true;
do
        echo "Enter the number"
        read guessed_num


        if [ "$guessed_num" == "exit" ]; then
                echo "original number was $original_num "
                break
        fi
        if [ $original_num -eq $guessed_num ]; then
                echo "congratulations you have guessed the number $guessed_num"
                break
        elif [ $original_num -gt $guessed_num ]; then
                echo "your guess is greater than original number"
        else
                echo "your guess is less than original number"
        fi

        echo "Try again."
done
