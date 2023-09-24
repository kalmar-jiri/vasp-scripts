#!/bin/bash

Home=$(pwd)


F0=0

for i in $(seq 400 100 1500)
do

cd $Home
cd $i

F=$(grep "F=" ./OSZICAR | awk '{print $3}')
dF=$(python -c "print $F-$F0")
F0=$F

echo $i $F $dF

done
