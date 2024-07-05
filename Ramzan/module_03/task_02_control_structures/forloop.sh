#!/bin/bash
number=$1
for i in {1..10}
do
	multiples=$(( $number * $i ))
	echo "$number * $i=$multiples"
done
