#!/bin/bash

# $= prints line number of last line in the file logfile.txt
awk 'END {print "Number of entries: " NR}' logfile.txt

echo "Unique usernames are:"

awk '{print $2}' logfile.txt | sort | uniq #prints unique usernames at $2

echo "The number of actions per user are:"

cut -d ' ' -f 2 logfile.txt | sort | uniq -c | sort -nr # uniq -c to count, cut to separate