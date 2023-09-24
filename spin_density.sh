#!/bin/bash

#COORDS

a=`cat CHGCAR | awk 'BEGIN{prev=100;} {if(prev==0 && NF==3)print $1; prev=NF;}'`

b=`cat CHGCAR | awk 'BEGIN{prev=100;} {if(prev==0 && NF==3)print $2; prev=NF;}'`

c=`cat CHGCAR | awk 'BEGIN{prev=100;} {if(prev==0 && NF==3)print $3; prev=NF;}'`

echo  $a $b $c

cat CHGCAR | awk 'BEGIN{file=0}{if($1=='$a' && $2=='$b' && $3=='$c')file++; print $0 > "CHG_part"file}'

cat CHG_part0 CHG_part1 > CHG_tot

cat CHG_part0 CHG_part2 > CHG_diff

rm *part* *tst -rf
