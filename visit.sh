#!/bin/bash

if [[ ! -f $1 ]]; then
  echo "Usage: visit.sh <file-with-list-of-subdomains>"
  exit
fi

httpxfile="httpx-$(date +%d%m%y-%H%M).txt"
httpxbaseline="httpx-baseline.txt"

if [[ ! -f "$httpxfile" ]]; then
  httpx -title -follow-redirects -status-code -tech-detect -l "$1" -o "$httpxfile"
  echo " --- "
fi

wc -l "$httpxfile"

if [[ ! -f "$httpxbaseline" ]]; then
  echo "Storing httpx results as $httpxbaseline"
  cp "$httpxfile" "$httpxbaseline"
else
  echo "Diff in httpx:"
  diff <(sort "$httpxbaseline") <(sort "$httpxfile") --new-line-format=+%L --old-line-format=-%L --unchanged-line-format=

  echo " --- "
  echo "Update baseline?"
  read -r input
  if [[ "$input" == "y" ]]; then
    cp "$httpxfile" "$httpxbaseline"
  fi
fi
