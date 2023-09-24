#!/bin/bash

awk 'BEGIN{i=1} /dos>/,\
               /\/dos>/ \
                 {a[i]=$2 ; b[i]=$3 ; i=i+1} \
     END{for (j=12;j<i-5;j++) print a[j],b[j]}' vasprun.xml > dos.dat

ef=`awk '/efermi/ {print $3}' vasprun.xml`

cat >plotfile<<EOF
 #set terminal png enhanced colour lw 2 "Helvetica" 20
set terminal postscript eps enhanced color "Helvetica" 20
set termoption dashed

set output "dos.eps"
set xrange [-10:10]
#set yrange [0:6]
#set xtics rotate by 90 right
#unset xtics
#unset ytics
#set ytics rotate by 90 right

set arrow from 0,0 to 0,3.5 nohead lc 7 lt 2 #rgb 'red'

plot  "dos.dat"  using (\$1-$ef):2 w l lw 2 lc 3 lt 1 notitle #, \
      # "dos.dat" i 0 using (\$1-$ef):2 w l lw 2 lc 7 lt 1 notitle

EOF

gnuplot -persist plotfile

rm  plotfile
