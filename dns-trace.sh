#!/bin/bash

tracefile="dns-trace-$(date +%d%m%y-%H%M).txt"

while read -r subdomain; do
  dig $subdomain +trace >> "$tracefile"
done < $1

echo "Wrote $tracefile"

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

for i in "${fingerprints[@]}"; do
   grep "NS" "$tracefile" | grep -h "$i" && echo -e "\e[1;32mInteresting NS if lookup failed:\e[0m Pattern: $i. See https://github.com/indianajson/can-i-take-over-dns"
done