#!/bin/bash
while read -r subdomain; do
	digresult=$(dig "$subdomain" +trace)
	
	#find lowest NS
	

	digresult = mapfile -t ns < <(dig NS $subdomain $2 +short)
	if [[ "$ns" ]]; then
		echo "--- $subdomain"
		
	for i in "${ns[@]}"
		do
		: echo "$i"
		done
	fi
done < $1