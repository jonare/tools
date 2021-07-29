#!/bin/bash

if [[ ! -f $1 ]]; then
  echo "Usage: visit.sh <file-with-list-of-subdomains>"
  exit
fi

httpxfile="$(date +%d%m%y-%H%M)-httpx.txt"
httpxbaseline="baseline-httpx.txt"

if [[ ! -f "$httpxfile" ]]; then
  httpx -title -follow-redirects -status-code -tech-detect -l "$1" -o "$httpxfile"
  echo " --- "
fi

wc -l "$httpxfile"

if [[ ! -f "$httpxbaseline" ]]; then
  echo "Storing httpx results as baseline"
  cp "$httpxfile" "$httpxbaseline"
else
  echo "Diff in httpx:"
  diff "$httpxbaseline" "$httpxfile"

  echo " --- "
  echo "Update baseline?"
  read -r input
  if [[ "$input" == "y" ]]; then
    cp "$httpxfile" $httpxbaseline
  fi
fi
