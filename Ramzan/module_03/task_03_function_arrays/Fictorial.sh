#!/bin/bash
Fictorial () {
	number=$1
	fict=1
	for ((i=1;i<=number;i++))
	do
		fict=$(($fict*$i))
	done
	echo $fict
}
#in order to find fictorial of different numbers we can use this
echo "Fictorial of 3 is:$(Fictorial 3)"
echo "Fictorial of 4 is:$(Fictorial 4)"
echo "Fictorial of 5 is:$(Fictorial 5)"
#just funny something

echo "Assistant Commissioner Muhammad Ramzan"



