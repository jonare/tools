#!/bin/bash

takeoverfile="takeovercheck-dns-$(date +%d%m%y-%H%M).txt"
touch "$takeoverfile"

cnamefingerprints="cloudapp.net\|cloudapp.azure.com\|azurewebsites.net\|blob.core.windows.net\|cloudapp.azure.com\|azure-api.net\|azurehdinsight.net\|azurecontainer.io\|database.windows.net\|azuredatalakestore.net\|search.windows.net\|azurecr.io\|redis.cache.windows.net\|servicebus.windows.net\|visualstudio.com\|trafficmanager.net"

while read -r fqdn; do
digresult=$(dig "$fqdn")


if [[ $digresult =~ .*NXDOMAIN.* ]]
then
	if [[ $digresult =~ .*ALIAS.* ]]
	then
		cname=$(dig ALIAS "$fqdn" +short)
		result="$fqdn | nxdomain with ALIAS $cname"
		if echo -n "$cname" | grep -q "$cnamefingerprints"; then
			result+=" | \e[1;32mInteresting CNAME\e[0m" 
		fi
 		echo -e "$result" | tee -a "$takeoverfile"

	else
		: #echo "$fqdn"  '| nxdomain' | tee -a "$takeoverfile"
	fi
fi

done < "$1"
