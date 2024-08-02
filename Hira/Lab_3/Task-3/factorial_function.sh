#!/bin/bash
factorial(){
	local num=$1
	local i=1
	local answer=1
	while [ $i -le $num ]; do
		answer=$((answer * i))
		i=$((i+1))
	done
	echo "factorial of $num is $answer "

}

factorial 5

factorial 7

factorial 6
