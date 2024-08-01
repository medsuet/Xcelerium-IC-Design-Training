#!/bin/bash


# part 1.1

#echo "Hello, world!"

#part 1.2

#read -p "what is your name:" person
#echo "Hello $person welcome to xclerium"

# part 1.3

#echo "sum is $(expr $1 + $2);"

#Part 2.1

#if [ $(($1 % 2)) -eq 0 ]; then
#       echo "$1 is even"
#else
# echo "$1 is odd"
#fi

#part 2.2

#for (( i=0; i<10; i++ )) do
#         echo "$(($1*i))"
	 
#done

#part 2.3

#a=$(($RANDOM % 10))
#echo "number is $a"
#Number=11
#while [ $Number -ne $a ]; do
#           read -p "enter number: " Number
#	   if [ $Number -gt $a ]; then
#		  echo "Higher"
#	  elif [ $Number -eq $a ]; then
#		  echo "correct"
#	   else 
#            echo "Lower"
#           fi	     
#done

#part 3.1

#factorial() { 
  
#  if [ $1 -eq 0 ]; then	
#	 echo 1;
#  else
#       local fact=$(factorial $(($1-1)))
#       echo $(( $1*fact ))
#  fi 
    
#}
#read -p "Input number: " Number
#fact=$(factorial $Number)
#echo "$fact"



#part 3.2

#arr=("Apple" "Mango" "Orange" "Bnana")

#printArray() {
#  arr=$1
#  for i in ${arr[*]}; 
#  do
#     echo "$i"
#  done   
#}
#arr[4444]="Peach"
#printArray $arr

#part 3.3

#declare -A Nationality

#Nationality=(["pakistan"]="Islamabad"  ["india"]="Dehli" ["Turkey"]="Anatolya" ["Russia"]="Moscow")

#read -p "country Please? " country
#if [[ -n ${Nationality[$country]}  ]]; then
#        echo ${Nationality[$country]}
#else
#  echo "This countrty does exist in our list "

#fi


#part 4.1
#readFile(){
#file=$1
#num=1
#next=0;
#while read line 
#do
  	
#  echo "$num  $line"
#  num=$(($num+1))

#done < $file
#}
#read -p "input file name: " file
#next=$(readFile $file)
#echo "$next"



#part 4.2 and 4.3

File=logfile.txt

echo "10-09-2022 a  hardworking eating drinking.">File
echo "19-12-2024 b  copying doNothing.">>File
echo "20-11-2021 c  pasting.">>File

if [ -e "$File" ]; then

    entries=$(grep -c "." logfile.txt)
    echo "entries are $entries"

    while read line 
    do

    echo "$line"
    a=($line)
    username=${a[1]};
    actions=$((${#a[*]}-2))
    echo "$username"
    echo "$actions"
    done < File
else
	echo "file no exist" 
fi



