echo -n "Enter an integer: "
read n1
echo -n "Enter another integer: "
read n2

sum=$(($n1+$n2))
product=$(($n1*$n2))

echo "the sum of $n1 and $n2 is $sum"
echo "the product is $product"

if [ $sum <= $product ]
then
    echo "the sum is less than or equal the product"

elif [ $sum > $product ]
then
    echo "the sum is greater than the produ"

fi