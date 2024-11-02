logfile="logfile.txt"
No_of_entries=$(wc -l < "$logfile")
echo "Total number of entries: $No_of_entries"

unique_usernames=$(awk '{print $2}' "$logfile" | sort | uniq)
echo "Unique Usernames: "
echo "$unique_usernames"

echo "Actions per user:"

for user in $unique_usernames; do
   count=$(grep -c "\<$user\>" "$logfile")
   echo "$user: $count"
done