#!/bin/bash

# Step 1: Count the total number of entries by counting the total number of lines
Total_Entries=$(wc -l < Log.txt)
echo "Total number of Entries: $Total_Entries"

# Step 2: List unique usernames 
unique_usernames=$(awk '{print $2}' Log.txt | sort | uniq)
echo "Unique usernames: $unique_usernames"

# Step 3: Count actions per user by using nested loops
usernames=$(awk '{print $2}' Log.txt)
echo "Actions per user:"
for user in $unique_usernames; do
    count=0
    for user2 in $usernames; do
        if [ "$user2" = "$user" ]; then
            ((count++))
        fi
    done
    echo "Number of actions for $user: $count"
done

