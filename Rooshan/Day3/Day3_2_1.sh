echo "Enter a number"
read num
remainder=$((num % 2))
if [ $remainder -eq 0 ]

then
    echo "$num is even"
else
    echo "$num is odd"

fi
