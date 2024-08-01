#!/bin/bash

file="file1.log"
arr=()

count=1
while read -r line; do 
    count=$(($count + 1))
done < $file

#Command to print the unique names
awk '{print $2}' $file | sort | uniq > unique_names.txt

#This while is only use to make the array of unique names
while read -r line; do
    arr+=("$line")
done < unique_names.txt

#delete this temporary file
rm -rf unique_names.txt

echo -e "\nTotal number of entries $(($count - 1))\n"

echo -e "== Unique Names =="
echo -e ${arr[@]}"\n"

# counting the user actions
echo "== User actions =="
for i in {0..3}
do
    user_actions=$(grep -c -Ei "${arr[i]}" "$file")
    echo -e "${arr[i]} => $user_actions"
done
