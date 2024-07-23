#!/bin/bash 

num=$1
for i in {1..10}; do
    echo "$(($num * $i))"
done
