#!/bin/bash

takeoverfile="takeovercheck-dns-$(date +%d%m%y-%H%M).txt"

while read -r fqdn; do
digresult=$(dig "$fqdn")

if [[ $digresult =~ .*SERVFAIL|REFUSED.* ]]
then
	trace=$(eval "trace-fingerprint.sh" "$fqdn")
	echo "$fqdn" ' | failed |' "$trace" | tee -a "$takeoverfile"
elif [[ $digresult =~ .*NOERROR.* ]]
then
	: #echo $fqdn
elif [[ $digresult =~ .*NXDOMAIN.* ]]
then
	if [[ $digresult =~ .*CNAME.* ]]
	then
		echo "$fqdn"  '| nxdomain with CNAME' $(dig CNAME "$fqdn" +short) | tee -a "$takeoverfile"
	fi
else
	echo "$fqdn"  '| unknown' | tee -a "$takeoverfile"
fi

done < "$1"