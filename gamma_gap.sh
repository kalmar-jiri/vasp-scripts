#!/bin/bash

VB_a=$1
CB_a=$2
VB_b=$3
CB_b=$4

VB_a_en=$(grep " $1  " EIGENVAL | head -1 | awk '{print $2}')
CB_a_en=$(grep " $2  " EIGENVAL | head -1 | awk '{print $2}')
VB_b_en=$(grep " $3  " EIGENVAL | head -1 | awk '{print $3}')
CB_b_en=$(grep " $4  " EIGENVAL | head -1 | awk '{print $3}')

a_gap=$(python -c "print $CB_a_en-$VB_a_en")
b_gap=$(python -c "print $CB_b_en-$VB_b_en")

echo "alpha:	$a_gap eV"
echo "beta:	$b_gap eV"
