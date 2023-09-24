#!/bin/bash

echo "E x y z" > abs.dat

z=`awk 'NR==5{print $3}' POSCAR`
d=`awk 'NR==2{print $1}' POSCAR`


cat vasprun.xml | awk '{if($1=="</imag>")read=0;if(read==1 && NF==9)print $0;if($1=="<imag>"){read=1}}'| awk '{printf "%1.5f %1.5f %1.5f %1.5f\n",$2,(1-(2.71828182846^(-($3*$2*'$z*$d'/(100*6.5821195*2.99792458)))))*100, (1-(2.71828182846^(-($4*$2*'$z*$d'/(100*6.5821195*2.99792458)))))*100, (1-(2.71828182846^(-($5*$2*'$z*$d'/(100*6.5821195*2.99792458)))))*100 }' >> abs.dat
