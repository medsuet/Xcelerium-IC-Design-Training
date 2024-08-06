remainder=$(($1 % 2))
if [ $remainder -eq 0 ]; then
    echo "Number is even"
else
    echo "Number is odd"
fi