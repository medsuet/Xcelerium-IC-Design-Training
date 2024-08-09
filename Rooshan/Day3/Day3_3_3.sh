#!/bin/bash
declare -A CC_array
CC_array["Pakistan"]="Islamabad"
CC_array["India"]="Delhi"
CC_array["Sri Lanka"]="Colombo"
CC_array["Bangladesh"]="Dhaka"
echo ${CC_array[@]}
echo ${!CC_array[@]}
Capital_Finder(){
for country in ${!CC_array[@]}
do
	if [[ $country != $1 ]]
	then
		num=0
	else
		num=1
	fi
done
if [[ num -eq 0 ]]
then
	echo "$1 not in associative array"
else
	echo "Capital of $1 is ${CC_array[$1]}"
fi
}
Capital_Finder "England"
Capital_Finder "Pakistan"
