#!/bin/bash
while read -r subdomain; do
fqdn=$subdomain'.'$2
digresult=$(dig "$fqdn")

if [[ $digresult =~ .*SERVFAIL|REFUSED.* ]]
then
	echo $fqdn '| failed'
elif [[ $digresult =~ .*NOERROR.* ]]
then
	: #echo $fqdn
elif [[ $digresult =~ .*NXDOMAIN.* ]]
then
	if [[ $digresult =~ .*CNAME.* ]]
	then
		echo $fqdn  '| nxdomain with CNAME ' $(dig CNAME "$fqdn" +short)
	fi
else
	echo $fqdn  '| unknown'
fi

done < $1
