#!/bin/bash

takeoverfile="dns-trace-$(date +%d%m%y-%H%M).txt"

while read -r subdomain; do
  dig $subdomain +trace >> "$takeoverfile"
done < $1

echo "$takeoverfile"