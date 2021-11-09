#!/bin/bash

while read -r domain; do
	whois "$domain" | grep -i "No match"
done < $1