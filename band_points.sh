#!/bin/bash

LEN=$(head -2 ./KPOINTS | tail -1)
NUM0=$(cat ./KPOINTS | wc -l)
NUM=$(python -c "print ($NUM0-4)/3")


X=$(python -c "print $NUM*$LEN+1")
Y=$(python -c "print $NUM*$LEN")
#echo $NUM $LEN $X
head -2 ./bs.dat | tail -1 | awk '{print $1}'
head -$X ./bs.dat | tail -$Y | sed -n '0~'$LEN'p' | awk '{print $1}'

