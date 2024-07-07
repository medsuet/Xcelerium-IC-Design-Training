array=("Mango" "Apple" "Banana")
echo "List of Fruits: "
for fruit in "${array[@]}"
do
    echo "$fruit"
done
array+=("Strawberry")
echo -e "\nNew List of Fruits: "
for fruit in "${array[@]}"
do
    echo "$fruit"
done