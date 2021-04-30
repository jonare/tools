#!/bin/bash
while read subdomain; do
fqdn=$subdomain'.'$2
digresult=`dig "$fqdn"`

if [[ $digresult =~ .*SERVFAIL|REFUSED.* ]]
then
	echo $fqdn '| failed'
elif [[ $digresult =~ .*NOERROR.* ]]
then
	echo $fqdn
elif [[ $digresult =~ .*NXDOMAIN.* ]]
then
	cname=`dig CNAME "$fqdn" +short` #TODO fix double dig

	if [[ ! -z "$cname" ]]
	then
		echo $fqdn  '| nxdomain with CNAME ' "$cname" 
	fi
else
	echo $fqdn  '| unknown'
fi

done < $1
