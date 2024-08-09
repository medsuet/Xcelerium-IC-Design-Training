#!/bin/bash 

factorial() {
    if [ $1 -le 1 ]; then
        echo 1
    else
        echo $(($1 * $(factorial $(($1 - 1)))))
    fi
}

for num in 3 5 7; do
    echo "Factorial of $num is $(factorial $num)"
done
