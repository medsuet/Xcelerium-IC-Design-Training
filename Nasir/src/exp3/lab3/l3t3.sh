# # associative arrays - key value arrays
# # can be accesed with words as index
# # associative array of country capitals

# declare -A associativeArrayCapitals

# associativeArrayCapitals[Pakistan]="Islamabad"
# associativeArrayCapitals[Palau]="Ngerulmud"
# associativeArrayCapitals[Palestine]="Jerusalem (East)"
# associativeArrayCapitals[Panama]="	Panama City"
# associativeArrayCapitals[PapuaNewGuinea]= "Port Moresby"
# associativeArrayCapitals[Paraguay]="Asunción"
# associativeArrayCapitals[Peru]= "Lima"
# associativeArrayCapitals[Philippines]="Manila"
# associativeArrayCapitals[Poland]="Warsaw"
# associativeArrayCapitals[Portugal]="Lisbon"

# read -p "Enter Name of the Country: " countryName

# for country in "${associativeArrayCapitals[@]}"; do
#     if [$country -eq $countryName]; then
#         echo "Country Capital is: $cou
# done

#!/bin/bash

# Declare an associative array for country-capital pairs
declare -A country_capitals

# Initialize the associative array with some country-capital pairs
country_capitals=(
    ["USA"]="Washington, D.C."
    ["Canada"]="Ottawa"
    ["Mexico"]="Mexico City"
    ["France"]="Paris"
    ["Germany"]="Berlin"
    ["India"]="New Delhi"
    ["China"]="Beijing"
    ["Japan"]="Tokyo"
    ["Australia"]="Canberra"
    ["Brazil"]="Brasília"
)

# Prompt the user to enter the name of a country
read -p "Enter the name of a country: " input_country

# Check if the country exists in the associative array
if [[ -v country_capitals["$input_country"] ]]; then
    # If the country exists, print the capital
    echo "The capital of $input_country is ${country_capitals[$input_country]}."
else
    # If the country does not exist, print an error message
    echo "Country not found in the array."
fi
