#!/bin/bash

if [[ ! -f $1 ]]; then
  echo "Usage: find.sh <file-with-top-domains-to-search>"
  exit
fi

subfinderfile="subfinder-$(date +%d%m%y-%H%M).txt"

if [[ ! -f "$subfinderfile" ]]; then
	# subfinder -silent -dL "$1" -o "$subfinderfile" > /dev/null
	echo "blah $1"
	subfinder -dL "$1" -o "$subfinderfile"
	echo " --- "
fi

cat subfinder-* | sort | uniq > subfinder-union.txt

wc -l "$subfinderfile"
wc -l subfinder-union.txt
