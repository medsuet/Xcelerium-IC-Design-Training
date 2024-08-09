#  ============================================================================
#  Filename:    loops.sh 
#  Description: File consists of codes based on concepts of linuxshellscripting
#  Author:      Bisal Saeed
#  Date:        7/3/2024
#  ============================================================================

#NOTE: run using command : ./scripts/loops.sh

#!/bin/bash

#This function takes value from the terminal and checks if (arg mod 2) == 0 
#then print as even else odd,fi command needed to show that condition is terminated
echo "PART: IF ELSE STATEMENT"
read -p "Enter number to find if it is even or odd: " n
if [ $(($n % 2)) -eq 0 ]; then
	echo "Number is an even number"
else 
	echo "Number is an odd number"
fi
echo " " 

#These commands will iterate through values in list (1..10) and calulate multiple of 
#value provided by user
echo "PART: FOR LOOP" 
read -p "Enter the number to calculate multiples: " no
for i in {1..10}; do
	echo $(($no * i ))
done
echo " "

echo "PART: WHILE LOOP"
#LOGIC: These commands take value from user and compare it with generated random
#number .Based on comparisons the hint is provided to help user else congratulations
#prompt is printed

#A random number is generated between 0-9 range +1 is done to change range to 1-10
number=$(((RANDOM % 10) + 1)) 

#Defined a function that can be called iteratively to take guess
user_guess(){
  read -p "Guess the number (between 1 and 10 ):" guess 
}

#We need to execute the func once before to check conditions of loop
user_guess

#NOTE: "" used for variables to avoid any unexpected behavior
while [ "$guess" -ne "$number" ]; do 
       if [ "$guess" -lt "$number" ]; then
	       echo "Number is higher than guess.Try Again!"
       else 
	       echo "Number is lower than guess.Try Again!"
       fi
       user_guess
done
echo "Congratulations! You guessed the correct number:  $number"
echo " "