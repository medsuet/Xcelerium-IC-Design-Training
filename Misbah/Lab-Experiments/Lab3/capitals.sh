declare -A capitals
capitals=(["Pakistan"]="Islamabad" ["China"]="Beijing" ["Turkey"]="Istanbul")
for key in "${!capitals[@]}"
do
echo "Capital of $key is ${capitals[$key]}."
done
read -p "Enter the country for the information of its capital: " quest
if [ $quest -eq ]