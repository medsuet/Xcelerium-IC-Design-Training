#!/usr/bin/env bash
echo 10 multiples of $1 are: 
for i in {1..10} 
do 
    mul=$(expr $1 \* $i) 
    echo $mul 
done
