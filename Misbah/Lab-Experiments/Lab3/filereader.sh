filepath="logfile.txt"
num=1
if [ -f "$filepath" ]; then
   while IFS= read -r  line; do
    echo "$num: $line"
    num=$((num + 1))
   done < "$filepath"

else
   echo "Error: File not found"
fi
