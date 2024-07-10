#part 4.1
readFile(){
file=$1
num=1
next=0;
while read line 
do
  	
  echo "$num  $line"
  num=$(($num+1))

done < $file
}
read -p "input file name: " file
next=$(readFile $file)
echo "$next"

#part 4.2 and 4.3

File=logfile.txt

echo "10-09-2022 a  hardworking eating drinking.">File
echo "19-12-2024 b  copying doNothing.">>File
echo "20-11-2021 c  pasting.">>File

if [ -e "$File" ]; then

    entries=$(grep -c "." logfile.txt)
    echo "entries are $entries"

    while read line 
    do

    echo "$line"
    a=($line)
    username=${a[1]};
    actions=$((${#a[*]}-2))
    echo "$username"
    echo "$actions"
    done < File
else
	echo "file no exist" 
fi


