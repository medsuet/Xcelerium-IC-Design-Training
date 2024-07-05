#!/bin/bash
FILE="actions.txt"
countEntries(){
    local entries=$(wc -l < "$FILE")
    echo "Total number of $entries"
}
uniqueUsers(){
    awk '{print $2}' "$FILE" | sort | uniq
}
actionsCount(){
    awk '{print $2}' "$FILE" | sort | uniq -c
}
countEntries
uniqueUsers
actionsCount
