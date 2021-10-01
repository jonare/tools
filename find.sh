#!/bin/bash

if [[ ! -f $1 ]]; then
  echo "Usage: find.sh <file-with-top-domains-to-search>"
  exit
fi

subfinderfile="subfinder-$(date +%d%m%y-%H%M).txt"
subfinderbaseline="subfinder-baseline.txt"

if [[ ! -f "$subfinderfile" ]]; then
	subfinder -silent -dL "$1" -o "$subfinderfile"
	echo " --- "
fi

if [[ ! -f "$subfinderbaseline" ]]; then
	wc -l "$subfinderfile"
	echo "Storing subfinder results as $subfinderbaseline"
	cp "$subfinderfile" "$subfinderbaseline"

else
	wc -l "$subfinderbaseline"
	wc -l "$subfinderfile"

  #echo "Diff from subfinder:"
  #diff <(sort "$subfinderbaseline") <(sort "$subfinderfile") --new-line-format=+%L --old-line-format=-%L --unchanged-line-format=

  echo "Update baseline?"
  read -r input
  if [[ "$input" = "y" ]]; then
    cp "$subfinderfile" $subfinderbaseline
  fi
fi