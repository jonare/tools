#!/bin/bash
while read -r subdomain; do
	# echo 'leser ' "$subdomain"
	resultat = $(eval "cname-fingerprint.sh" "$subdomain")
	echo "$resultat"
done < $1