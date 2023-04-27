#!/bin/bash

if [[ ! -f $1 ]]; then
  file="subfinder-union.txt"
else
  file=$1
fi

afile="a-$(date +%d%m%y-%H%M).txt"
touch "$afile"
ipfile="ip-$(date +%d%m%y-%H%M).txt"
touch "$ipfile"

while read -r subdomain; do
	A=$(dig A $subdomain $2 +short)
	if [[ "$A" ]]; then
		echo "--$subdomain" | tee -a "$afile"
		echo "$A" | tee -a "$afile"
	fi
done < $file

cat "$afile" | grep "^[0-9].*" | sort | uniq > "$ipfile"

ln -sf "$afile" "a-latest.txt"
ln -sf "$ipfile" "ip-latest.txt"
