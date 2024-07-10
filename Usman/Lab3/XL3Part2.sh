#!/bin/bash
#part 2.2

for (( i=0; i<10; i++ )) do
         echo "$(($1*i))"
	 
done

#part 2.3

a=$(($RANDOM % 10))
#echo "number is $a"
Number=11
while [ $Number -ne $a ]; do
           read -p "enter number: " Number
	   if [ $Number -gt $a ]; then
		  echo "Higher"
	  elif [ $Number -eq $a ]; then
		  echo "correct"
	   else 
            echo "Lower"
           fi	     
done
