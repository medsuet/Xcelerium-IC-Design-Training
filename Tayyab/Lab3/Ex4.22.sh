#!/bin/bash
# Reads logfile created by logfilewrite.sh
# Format: # "YYYY-MM-DD username action"
# Counts the total number of entries
# Lists unique usernames
# Counts actions per user

FILE=logfile.txt        # stores path of file to work on

numEntries=0
# assosiative array to store [users]=number of actions
declare -A users

while read line;            # iterate through lines on file
do
    lineParts=($line)       # split line by spaces
    user=${lineParts[1]}    # get user from parts of line
    ((users[$user]+=1))     # increment actions of user
    ((numEntries++  ))      # increment total number of entries
done < $FILE

# print results
echo "Number of entries: $numEntries"
echo "Users: ${!users[@]}"
echo -e "\n User \t\t Actions "
echo -e "------\t\t---------"

for user in ${!users[@]}
do 
    echo -e " $user \t\t  ${users[$user]}"
done

echo ""