#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Usage: $0 <num>"
	exit 1
fi

num=$1

echo "first 10 multiples of $num"
for i in {1..10}; do
	echo " $((num * i))"
done

