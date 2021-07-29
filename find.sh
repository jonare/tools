#!/bin/bash

if [[ ! -f $1 ]]; then
  echo "Usage: find.sh <file-with-top-domains-to-search>"
  exit
fi

prefix=$(date +%d%m%y)
subfinderfile="$prefix-subfinder.txt"
subfinderbaseline="baseline-subfinder.txt"

if [[ ! -f "$subfinderfile" ]]; then
	subfinder --silent -dL "$1" -o "$subfinderfile"
	echo " --- "
fi

if [[ ! -f "$subfinderbaseline" ]]; then
	wc -l "$subfinderfile"
	echo "Storing subfinder results as baseline"
	cp "$subfinderfile" "$subfinderbaseline"

else
	wc -l "$subfinderbaseline"
	wc -l "$subfinderfile"
  echo "Update baseline?"
  read -r input
  if [[ "$input" = "y" ]]; then
    cp "$subfinderfile" $subfinderbaseline
  fi
fi