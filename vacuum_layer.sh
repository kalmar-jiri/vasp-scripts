#!/bin/bash

a=$(head -9 POSCAR | tail -1 | awk '{print $3}')
c0=$(head -5 POSCAR | tail -1 | awk '{print $3}')

read -p "Your desired vacuum height: " c
read -p "Number of elements: " ele

ions=$(head -7 POSCAR | tail -1 | awk -v el=$ele '{sum=0; for (i=1; i<=$el; i++) { sum+= $i } print sum}')

cp POSCAR ./POSCAR.$c

ion=$(python -c "print $ions-1")

sed -i "s/$c0/$c.0/g" POSCAR.$c

for i in $(seq 1 1 $ion)
do

row=$(python -c "print 9+$i")
pos=$(sed "${row}q;d" POSCAR | awk '{print $3}')

if (( $(echo "$pos < $a" | bc -l) ));
then

d=$(python -c "print ($a-$pos)*$c0")
Z=$(python -c "print ($a*$c)-$d")
A=$(python -c "print $Z/$c")

echo $i $d $Z $A

sed -i "s/$pos/$A/g" POSCAR.$c


elif (( $(echo "$pos > $a" | bc -l) ));
then

d=$(python -c "print ($pos-$a)*$c0")
Z=$(python -c "print ($a*$c)+$d")
A=$(python -c "print $Z/$c")

echo $i $d $Z $A

sed -i "s/$pos/$A/g" POSCAR.$c

else
continue

fi

done
