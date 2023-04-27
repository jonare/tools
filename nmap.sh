#!/bin/bash

if [[ ! -f $1 ]]; then
  file="ip-latest.txt"
else
  file=$1
fi

nmapfile="nmap-$(date +%d%m%y-%H%M).xml"

nmap -sV -iL "$file" -oX "$nmapfile"
ln -sf "$nmapfile" "nmap-latest.xml"
