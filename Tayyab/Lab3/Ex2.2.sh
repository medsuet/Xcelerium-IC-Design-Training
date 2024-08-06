#!/bin/bash
# Prints 1st 10 multiples of argument 1
for i in {1..10}
do
    echo -n "$(($i * $1)) "
done
echo ""