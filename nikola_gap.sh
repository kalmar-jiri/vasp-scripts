    # indirect gap
    grep " 4 " EIGENVAL | sort -k 2n | tail -1 | awk '{printf "\t"$2 >> "gap.txt"}'
    grep " 5 " EIGENVAL | sort -k 2n | head -1 | awk '{printf "\t"$2 >> "gap.txt"}'
    cat gap.txt | awk '{print "\t"$2-$1 >> "gap.txt"}'
    # gap in Gamma
    grep " 4 " EIGENVAL | head -1 | awk '{printf "\t"$2 >> "gapg.txt"}'
    grep " 5 " EIGENVAL | head -1 | awk '{printf "\t"$2 >> "gapg.txt"}'
    cat gapg.txt | awk '{print "\t"$2-$1 >> "gapg.txt"}'

