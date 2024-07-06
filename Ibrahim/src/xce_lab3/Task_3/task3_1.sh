#!/bin/bash
# Calculate factorial of a number
factorial() {
    local number=$1
	if [ "$number" -lt 0 ]; then
	    echo "Error: factorial is not defined for negative numbers."
		return 1
	elif [ "$number" -eq 0 ]; then
		echo 1
		return 0
	fi

	local result=1
	for (( i=1; i<=number; i++))
	do 
		result=$((result * i))

	done
    echo $result
}
# Call the function with different numbers and print the result
numbers=(0 1 5 7 10)
for num in "${numbers[@]}"
do
	result=$(factorial $num)
	echo "Factorial of $num is: $result"
done

