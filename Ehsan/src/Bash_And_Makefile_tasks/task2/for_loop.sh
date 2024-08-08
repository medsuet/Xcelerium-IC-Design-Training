#!/bin/bash
number=$1

for((i=1;i<11;i++)); do
    	echo "$((number * i))"
done
