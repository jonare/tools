#!/bin/bash

takeoverfile="takeovercheck-dns-$(date +%d%m%y-%H%M).txt"
touch "$takeoverfile"

cnamefingerprints="cloudapp.net|cloudapp.azure.com|azurewebsites.net|blob.core.windows.net|cloudapp.azure.com|azure-api.net|azurehdinsight.net|azurecontainer.io|database.windows.net|azuredatalakestore.net|search.windows.net|azurecr.io|redis.cache.windows.net|servicebus.windows.net|visualstudio.com|trafficmanager.net"

localdomains=".*"

if [ -f "domains.lst" ]; then
	localdomains=$(cat "domains.lst" | tr '\n' '|' | sed 's/\\|$//');
fi

while read -r fqdn; do
	digresult=$(dig "$fqdn")

	if [[ $digresult =~ .*SERVFAIL|REFUSED.* ]]
	then
		trace=$(eval "trace-fingerprint.sh" "$fqdn")
		echo "$fqdn" ' | failed |' "$trace" | tee -a "$takeoverfile"
	elif [[ $digresult =~ .*NOERROR.* ]]
	then
		: #echo "$fqdn" ' | noerror' | tee -a "$takeoverfile"
	elif [[ $digresult =~ .*NXDOMAIN.* ]]
	then
		if [[ $digresult =~ .*CNAME.* ]]
		then
			cname=$(dig CNAME "$fqdn" +short)
			if ! [[ "$cname" =~ $localdomains.\$ ]]; then #only flag records not referring to target's adressable domains
				result="$fqdn | nxdomain with CNAME $cname"
				if [[ "$cname" =~ $cnamefingerprints ]]; then
					result+=" | \e[1;32mInteresting CNAME\e[0m"
				fi 
				echo -e "$result" | tee -a "$takeoverfile"
			fi
	 		
		else
			: #echo "$fqdn"  '| nxdomain' | tee -a "$takeoverfile"
		fi
	else
		echo "$fqdn"  '| unknown' | tee -a "$takeoverfile"
	fi
done < "$1"

ln -sf "$takeoverfile" "takeovercheck-dns-latest.txt"
