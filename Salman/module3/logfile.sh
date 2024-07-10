#!/bin/bash

# END of NR prints line number of last line in the file logfile.txt
awk 'END {print "Number of entries: " NR}' logfile.txt

echo "Unique usernames are:"
# $2 for usernames, uniq to print only unique usernames
awk '{print $2}' logfile.txt | sort | uniq #prints unique usernames at $2

echo "The number of actions per user are:"

# -d ' ' to separate elements whenever ' ' occurs
# -f 2 for usernames only at index 2
# uniq -c to count their occurence
# sort -nr to sort by ascending order
cut -d ' ' -f 2 logfile.txt | sort -nr | uniq -c