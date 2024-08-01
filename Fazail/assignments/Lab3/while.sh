#!/bin/bash

#generate random values between zero to ten
rand=$RANDOM
value=$[($rand % 10) + 1]

read -p "Enter your name: " NAME
echo "Welcome $NAME in the guessing game. Best of luck!" 

read -p "GUESS the Value: " GUESS

while [ "$GUESS" -ne "$value" ]
do 
   if [ "$GUESS" -lt "$value" ]; then
      read -p "Your value is low, re-guess the value: " GUESS
   else 
      read -p "Your value is high, re-guess the value: " GUESS
   fi
done

if [ "$GUESS" -eq "$value" ]; then
      echo "Congratulations $NAME!!!, Your are good in guessing. Your guess is matched :)"
fi
