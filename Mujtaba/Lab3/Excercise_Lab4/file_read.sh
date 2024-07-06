#!/usr/bin/env bash
temp=1
input_file=~/useful_commands.txt
#input_file="/home/muhammad-mujtaba-rawn/Documents/Xcelerium\ Training\ Excercises/Lab3/Excercise_Lab4/useful_commands.txt"
while IFS= read -r line
do
    echo "Line $temp: $line"
    ((temp++))
done < "$input_file"
