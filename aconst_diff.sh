#!/bin/bash

echo "(directories can be relative)"
read -p "1st directory: " dir1
read -p "2nd directory: " dir2

a1=$(head -3 $dir1 | tail -1 | awk '{print $1}')
a2=$(head -3 $dir2 | tail -1 | awk '{print $1}')

echo $(python -c "print $a2-$a1")
