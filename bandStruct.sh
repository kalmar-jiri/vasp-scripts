#!/bin/bash

rm kkk.kkk lll.lll band.* bs.dat

nband=$(grep NBAND OUTCAR |head -1|awk '{print $15}')
nkpts=$(grep NKPTS OUTCAR |head -1|awk '{print $4}')
efermi=$(grep "E-fermi :" OUTCAR |tail -1|awk '{print $3}' )

echo NBAND: $nband 
echo NKPTS: $nkpts 
echo EFERMI: $efermi

# collect k-points
totalPath=$(grep "k-point" OUTCAR |tail -$nkpts |awk 'BEGIN {count=0} {count+=1;if (count==1) {path=0.} else {xx=$4-x;yy=$5-y;zz=$6-z;path+=(xx*xx+yy*yy+zz*zz)^0.5} ;x=$4;y=$5;z=$6} END {print path}')
grep "k-point" OUTCAR |tail -$nkpts |awk 'BEGIN {count=0} {count+=1;if (count==1) {path=0.} else {xx=$4-x;yy=$5-y;zz=$6-z;path+=(xx*xx+yy*yy+zz*zz)^0.5} ;x=$4;y=$5;z=$6;print path/"'${totalPath}'"}' > kkk.kkk



# extract data for each k-point
let onepoint=nband+1
let xx=onepoint*nkpts
#grep -A${nband}  "band No.  band energies     occupation" OUTCAR|sed '/--/d'|tail -$xx > lll.lll
grep -n "band No.  band energies     occupation" OUTCAR| cut -d':' -f1 |xargs  -n1 -I % awk "NR<=%+$nband && NR>=%" OUTCAR|sed '/--/d'|tail -$xx > lll.lll 

for i in $(seq 1 $nband)
do
  echo "Band "$i >>bs.dat
  let j=i+1
  awk 'BEGIN {xy="'${onepoint}'";jj="'${j}'";if (xy==jj) {jj=0}} {if (NR%xy==jj) {print $2-("'${efermi}'")}}' lll.lll>band.$i
  paste kkk.kkk band.$i >>bs.dat 
  echo "" >>bs.dat
  echo "" >>bs.dat
done

rm kkk.kkk lll.lll band.* 
#put things together
#paste kkk.kkk band.* >bs.dat
