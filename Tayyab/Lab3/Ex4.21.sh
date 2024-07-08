#!/bin/bash
# Writes a log file with format:
# "YYYY-MM-DD username action"
users=(root user1 user1 user1 user1 user1 user1 user2 user2 user2 root root)
actions=(login login run copy paste paste logoff login run logoff save logoff)

#clear logfile
echo "" > logfile.log

for i in {0..11}
do
    echo "$(date -I) ${users[i]} ${action[i]}" >> logfile.log
done
echo "logfile.txt created"