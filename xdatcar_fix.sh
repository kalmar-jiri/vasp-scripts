#!/bin/bash
echo "########  XDATCAR concentrator and atomic position shift  #"
echo "# The script uses python3 and numpy so you need to have   #"
echo "# them both installed. The default path for python is:    #"
echo "# /usr/bin/python3                                        #"
echo "# If you have a non-default instalation of python3 change #"
echo "# change the path at: cat >xdatcar_fix.py<<!              #"
echo "# Place your XDATCAR files in the same folder as this     #"
echo "# script. Enumerate them as XDATCAR_*. If you want the    #"
echo "# intial configuration have the POSCAR file on hand as    #"
echo "# well. When everythong is ready run the file as:         #"
echo "# xdatcar_fix.sh \$1 \$2 \$3                              #"
echo "# \$1 \$2 \$3 is direct coordinate shift in the x, y z,   #"
echo "# coorditates of atomic positions                         #"
rm XDATCAR

xs=$1
ys=$2
zs=$3


if [ -z "$xs" ]
then
      xs=0
fi
if [ -z "$ys" ]
then
      ys=0
fi
if [ -z "$zs" ]
then
      zs=0
fi

if test -f "POSCAR"
then
	head -n 7 POSCAR >> header
	listnat=$(head -7 POSCAR | tail -1)
else
	head -n 7 XDATCAR_1 >> header
	listnat=$(head -7 XDATCAR_1 | tail -1)
fi

nat=0
for i in $listnat
do
	nat=$(python -c "print $nat+$i")
done

echo "Direct      configuration=  0" >> tmp
sed -e 1,8d POSCAR >> tmp
for i in $(ls XDATCAR_*)
do
	sed -e 1,7d $i >> $i.tmp
	cat $i.tmp >> tmp
	rm $i.tmp
done
cat >xdatcar_fix.py<<!
#!/usr/bin/python3
import numpy as np
import sys
from numpy import loadtxt

lines = loadtxt(sys.argv[1], dtype=str)
nat=int(sys.argv[2])
#print(len(lines))
counter=0
counter2=0
x=0
y=0
z=0
xs=$xs
ys=$ys
zs=$zs
for i in range(len(lines)):
	if i == counter:
		counter2 += 1
		lines[i,2] = str(counter2)
		counter += int(nat+1)
	else:
		x=float(lines[i,0])
		y=float(lines[i,1])
		z=float(lines[i,2])
		x=x+xs
		y=y+ys
		z=z+zs
		if x < 0:
			x=float("{:.8f}".format(abs(x//1)+x))
		if y < 0:
			y=float("{:.8f}".format(abs(y//1)+y))
		if x > 1:
			x=float("{:.8f}".format(x-(x//1)))
		if y > 1:
			y=float("{:.8f}".format(y-(y//1)))
		if z < 0:
			z=float("{:.8f}".format(abs(z//1)+z))
		if z > 1:
			z=float("{:.8f}".format(z-(z//1)))
		lines[i,0]=str(x)
		lines[i,1]=str(y)
		lines[i,2]=str(z)
    
with open('XDATCAR_fix', 'a') as f:
	for j in range(len(lines)):
		print(lines[j,0],lines[j,1],lines[j,2], file=f)
!
chmod +x xdatcar_fix.py
./xdatcar_fix.py tmp $nat
column -t XDATCAR_fix >> tmp2
cat header tmp2 >> XDATCAR
rm XDATCAR_fix tmp tmp2 header xdatcar_fix.py
