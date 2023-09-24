#!/bin/bash

rm aaa.aaa
rm bs_spin.dat

efermi=$(grep "E-fermi :" OUTCAR |tail -1|awk '{print $3}' )
nbands=$(cat EIGENVAL | head -6 | tail -1 | awk {'print $3'})
nkpts=$(cat EIGENVAL | head -6 | tail -1 | awk {'print $2'})

cat ./EIGENVAL >> aaa.aaa
sed -i '1,7d' ./aaa.aaa 

band_cap=$(python -c "print $nbands-1")
kpts_cap=$(python -c "print $nkpts-1")

echo "n  en_alpha  en_beta" >> bs_spin.dat

for j in $(seq 0 1 $band_cap)
do
  
  band_no=$(python -c "print $j+1")
  
  #echo "Band "$band_no >> bs_spin.dat
  

  for i in $(seq 0 1 $kpts_cap)
  do

  cut=$(python -c "print ((($nbands*$i)+(2*($i+1)))+$j)")
  sp1=$(head -$cut ./aaa.aaa | tail -1 | awk {'print $2'})
  sp2=$(head -$cut ./aaa.aaa | tail -1 | awk {'print $3'})
  
  sp1_0=$(python -c "print $sp1-$efermi")
  sp2_0=$(python -c "print $sp2-$efermi")
  

  echo $i $sp1_0 $sp2_0 >> bs_spin.dat
  

  done
  
  #echo "" >> bs_spin.dat
  echo "" >> bs_spin.dat

done

rm aaa.aaa
