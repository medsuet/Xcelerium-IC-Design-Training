#!/bin/bash
echo "Enter a number"
read num
for i in {1..10}
do
    var=$((num*i))
    echo $var
done
