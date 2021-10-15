#!/bin/bash
while read -r subdomain; do
	cname=$(dig CNAME $subdomain $2 +short)
	if [[ "$cname" ]]; then
		echo "$subdomain|$cname"
	fi
done < $1