#!/bin/bash

echo "Hello, World!"

read name           #input from user
echo "hello, $name"

# here the $1 and $2 take the arr. from command line
echo "the addition of given two number is $(($1+$2))"
