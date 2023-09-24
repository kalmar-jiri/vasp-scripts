#!/bin/bash

echo "Nexc Eexc OscStr" > "trans.txt"

 
cat vasprun.xml | awk '{if($1 == "</kpoints>"){read=1;NR=-1};if($1=="<parameters>")read=0;if($1!= "<varray" && read==1){if($3>0.001)printf "%i %1.3f %f\n", NR, $2, $3 >> "trans.txt"};if($1 == "</varray>")read=0}'
