#!/bin/bash

file="logfile.log"
arr=()
count=1
while read -r line; do 
    count=$(($count + 1))
done < $file

#printing unique names
awk '{print $2}' $file | sort | uniq > unique_names.txt

#make the array of unique names
while read -r line; do
    arr+=("$line")
done < unique_names.txt

#deleting temporary file
rm -rf unique_names.txt

echo  "\nTotal number of entries $(($count - 1))\n"
echo  "unique names are"
echo  ${arr[@]}"\n"

# counting the user actions
echo "user actions are"
for i in {0..3} do
    user_actions=$(grep -c -Ei "${arr[i]}" "$file")
    echo -e "${arr[i]} => $user_actions"
done
