#!/bin/bash

# Define the factorial function
function factorial(){
    if [ $1 -le 1 ]; then
        echo 1
    else
        local temp=$(factorial $(($1 - 1)))
        echo $(($1 * temp))
    fi
}

# Read input from the user
read -p "Enter the number to calculate factorial: " fac

# Call the factorial function and store the result
result=$(factorial $fac)

# Print the result
echo "The factorial of $fac is $result"
echo ""
echo "========================================================================="
echo ""
echo "Printing the Array"
print_array(){
    for i in ${array[@]}
    do 
        echo $i
    done    
    
}

array=("apple","orange","peach")

print_array ${array[@]}

echo ""
echo "=========================================================================="
echo ""
echo "Printing the Capital based on the Country"


# Define the function to find the capital
find_capital() {
    local country=$1
    for key in "${!assoc_array[@]}"
    do 
        if [ "$key" == "$country" ]; then
            echo "${assoc_array["$key"]}"
            return
        fi 
    done
    echo "Error! The Country is not in the array"
}

# Define the associative array
declare -A assoc_array=(
    ["Pakistan"]="Islamabad"
    ["India"]="New Delhi"
    ["Afghanistan"]="Kabul"
    ["China"]="Beijing"
    ["Bangladesh"]="Dhaka"
    ["Sri Lanka"]="Colombo"
)

# Read input from the user
read -p "Enter the name of the Country to know its Capital: " country

# Call the function to find the capital
find_capital "$country"
