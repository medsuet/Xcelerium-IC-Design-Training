#  ============================================================================
#  Filename:    hello.sh 
#  Description: File consists of codes based on concepts of linuxshellscripting
#  Author:      Bisal Saeed
#  Date:        7/3/2024
#  ============================================================================

#NOTE: run using command : ./scripts/hello.sh

#!/bin/bash
#NOTE: use echo " " to print outputs at terminal in seperate lines
echo "TASK1"
echo "PART: PRINT " 
echo "Hello World"
echo " "

#These commands reads NAME from user with prompt through option "-p" and store it
#in NAME and prints it
echo "PART: NAME OF USER" 
read -p "What is your name? " NAME
echo "Hello, $NAME! "
echo " "

echo "PART: SUM OF TWO NUMBERS" 
#prints directly the sum of arg1 and arg2 as $(()) calculates and gives value too
read -p "Enter the first number: " n1
read -p "Enter the second number: " n2
echo "The sum of two numbers is $(($n1+$n2))" 
echo " "





 


