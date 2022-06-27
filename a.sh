#!/bin/bash
while read -r subdomain; do
	A=$(dig A $subdomain $2 +short)
	if [[ "$A" ]]; then
		echo "$subdomain|$A"
	fi
done < $1