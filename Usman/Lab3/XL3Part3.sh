#!/bin/bash
#part 3.1

factorial() { 
  
  if [ $1 -eq 0 ]; then	
	 echo 1;
  else
       local fact=$(factorial $(($1-1)))
       echo $(( $1*fact ))
  fi 
    
}
read -p "Input number: " Number
fact=$(factorial $Number)
echo "$fact"



#part 3.2

arr=("Apple" "Mango" "Orange" "Bnana")

printArray() {
  arr=$1
  for i in ${arr[*]}; 
  do
     echo "$i"
  done   
}
arr[4444]="Peach"
printArray $arr

#part 3.3

declare -A Nationality

Nationality=(["pakistan"]="Islamabad"  ["india"]="Dehli" ["Turkey"]="Anatolya" ["Russia"]="Moscow")

read -p "country Please? " country
if [[ -n ${Nationality[$country]}  ]]; then
        echo ${Nationality[$country]}
else
  echo "This countrty does exist in our list "

fi
