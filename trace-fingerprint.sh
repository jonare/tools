#!/bin/bash

declare -a fingerprints=(
                "000domains.com"
                "azure-dns"
		"bizland.com"
		"click2site.com"
		"digitalocean.com"
		"dnsmadeeasy.com"
		"dnsimple.com"
		"ns1.domain.com"
		"ns2.domain.com"
		"dotster.com"
		"nameresolve.com"
		"easydns"
		"he.net"
		"linode.com"
		"mydomain.com"
		".name.com"
		"nsone.net"
		"domaindiscover.com"
		"reg.ru"
		"yns1.yahoo.com"
		"yns2.yahoo.com"
                 )

trace=$(dig "$1" +trace) 

for i in "${fingerprints[@]}"; do
   echo "$trace" | grep "NS" | grep "$1" | grep -q "$i" && echo -e "\e[1;32mInteresting NS if lookup failed:\e[0m Name: $1. Pattern: $i. See https://github.com/indianajson/can-i-take-over-dns"
done