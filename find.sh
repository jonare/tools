
#!/bin/bash

if [[ ! -f $1 ]]; then
  file="domains.lst"
else
  file=$1
fi

subfinderfile="subfinder-$(date +%d%m%y-%H%M).txt"

if [[ ! -f "$subfinderfile" ]]; then
	subfinder -all -v -dL "$file" -o "$subfinderfile"
	echo " --- "
fi

cat subfinder-* | sort | uniq > subfinder-union.txt

wc -l "$subfinderfile"
wc -l subfinder-union.txt
