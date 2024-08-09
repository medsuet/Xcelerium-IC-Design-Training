#  ============================================================================
#  Filename:    functions.sh 
#  Description: File consists of codes based on concepts of linuxshellscripting
#  Author:      Bisal Saeed
#  Date:        7/4/2024
#  ============================================================================

#NOTE: run using command : ./scripts/functions.sh

#!/bin/bash
echo "PART: FUCNTIONS"

echo "TASK : 3.1"  
#LOGIC: Take number from user and while number is not 1 find factorial by dividing 
#number with previous result stored in some variable and reduce value of user entered
#number by 1 and print result outside the while loop 
read -p "Enter the number to find factorial: " facnum
factorial (){
    local result=1
    local val=$facnum
    while [ "$val" -gt 1 ]; do
	    result=$((result * val))
            val=$(($val - 1))
    done
echo "Factorial of $facnum is :  $result"    
}
factorial
echo " "

echo "TASK : 3.2"

#LOGIC : defined array of fruits by user will be printed element wise using for loop 
#iterating through loop
printarray (){
	for i in "${arr[@]}"; do 
		echo "$i"
	done
}

arr=(apple cherry banana) 
echo "The fruits are listed below: "
printarray 
echo " "
arr=(apple cherry banana orange)  
echo "The fruits are listed below: "
printarray
echo " "

echo "TASK : 3.3"
#LOGIC:
declare -A country_capital=(
         ["Pakistan"]="Islamabad"
	 ["Japan"]="Tokyo"
	 ["Canada"]="Ottawa"
	 ["Germany"]="Berlin"
		)
read -p "Enter the country : " country
get_capital(){
       if [ -n "${country_capital[$country]}" ]; then
	       echo "${country_capital[$country]}"
       else
	       echo "Country not found in the list"
       fi
}
capital=$(get_capital "$country")
echo "Capital of $country is : " $capital

