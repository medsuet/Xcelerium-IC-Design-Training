NUM=$1
echo  "The first 10 multiples of $NUM are: "
for((i=1;i<11;i++)) do
    multiple=$((NUM * i))
    echo "$multiple"
done