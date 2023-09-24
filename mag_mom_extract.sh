# Extracts magnetic moments of 19th atom from results of molecular dynamics

awk '/\(x\)/,/19/ {if ($1=="19") {print $0}}' OUTCAR | awk '{print $1,$6}'
