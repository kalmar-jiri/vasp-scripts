#!/bin/bash

rm a.dat b.dat


# - - - call valence and conduction bands from input - - - 
#read -p "VB alpha: " VB_a
#read -p "CB alpha: " CB_a
#read -p "VB beta: " VB_b
#read -p "CB beta: " CB_b


# - - - call valence and conduction bands from arguments - - -
VB_a=$1
CB_a=$2
VB_b=$3
CB_b=$4

grep " $VB_a " EIGENVAL | awk '{print $2}' >> vb_a.dat
grep " $CB_a " EIGENVAL | awk '{print $2}' >> cb_a.dat

grep " $VB_b " EIGENVAL | awk '{print $3}' >> vb_b.dat
grep " $CB_b " EIGENVAL | awk '{print $3}' >> cb_b.dat

paste vb_a.dat cb_a.dat -d " " >> a.dat
paste vb_b.dat cb_b.dat -d " " >> b.dat

rm vb* cb*


VBM_a=$(grep " $VB_a " EIGENVAL | awk '{print $2}' | sort -g | tail -1)
VBM_b=$(grep " $VB_b " EIGENVAL | awk '{print $3}' | sort -g | tail -1)

CBM_a=$(grep " $CB_a " EIGENVAL | awk '{print $2}' | sort -g | head -1)
CBM_b=$(grep " $CB_b " EIGENVAL | awk '{print $3}' | sort -g | head -1)

alpha_gap=$(python -c "print $CBM_a-$VBM_a")
beta_gap=$(python -c "print $CBM_b-$VBM_b")


kpts=$(grep KPTS OUTCAR | awk '{print $4}')

min_gap_a=100
min_gap_b=100

for i in $(seq 1 1 $kpts)
do

vb_a=$(head -$i a.dat | tail -1 | awk '{print $1}')
cb_a=$(head -$i a.dat | tail -1 | awk '{print $2}')
vb_b=$(head -$i b.dat | tail -1 | awk '{print $1}')
cb_b=$(head -$i b.dat | tail -1 | awk '{print $2}')

gap_a=$(python -c "print $cb_a-$vb_a")
gap_b=$(python -c "print $cb_b-$vb_b")

if (( $(echo "$gap_a <= $min_gap_a" | bc -l) ));
then
min_gap_a=$gap_a
n_a=$i
fi

if (( $(echo "$gap_b <= $min_gap_b" | bc -l) ));
then
min_gap_b=$gap_b
n_b=$i
fi

done

echo "Indirect alpha band gap: " $alpha_gap "("$VBM_a "->" $CBM_a")"
echo "Indirect beta band gap: " $beta_gap "("$VBM_b "->" $CBM_b")"
echo "Direct alpha band gap: "  $n_a\) $min_gap_a
echo "Direct beta band gap: "  $n_b\) $min_gap_b

rm a.dat b.dat
