awk 'BEGIN{i=0} /<dielectricfunction>/,\
                /<\/dielectricfunction>/ \
                 {if ($1=="<r>") {a[i]=$2 ; b[i]=($3+$4+$5)/3 ; c[i]=$3 ; d[i]=$4 ; e[i]=$5 ; i=i+1}} \
     END{for (j=0;j<i/2;j++) print a[j],c[j],d[j],e[j],b[j]}' vasprun.xml > optics.dat
# optic.dat extracts both the real and imaginary part of the dielectric matrix
# the columns go as follows: E xx yy zz (xx+yy+zz)/3
