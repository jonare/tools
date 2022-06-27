#!/bin/bash

if [[ ! -f $1 ]]; then
  echo "Usage: visit.sh <file-with-list-of-subdomains>"
  exit
fi

httpxfile="httpx-$(date +%d%m%y-%H%M).txt"
httpxbaseline="httpx-baseline.txt"

if [[ ! -f "$httpxfile" ]]; then
  rm -rf "output"
  #httpx -title -status-code -tech-detect -l "$1" -o "$httpxfile" -threads 10 -sr -no-fallback-scheme -http-proxy http://localhost:4321
  httpx -title -follow-redirects -status-code -tech-detect -http2 -l "$1" -o "$httpxfile" -threads 10 -vhost -sr
  echo " --- "
fi

wc -l "$httpxfile"

if [[ ! -f "$httpxbaseline" ]]; then
  echo "Storing httpx results as $httpxbaseline"
  cp "$httpxfile" "$httpxbaseline"
else
  # echo "Diff in httpx:"
  # diff <(sort "$httpxbaseline") <(sort "$httpxfile") --new-line-format=+%L --old-line-format=-%L --unchanged-line-format=
  # echo " --- "
  
  echo "Update baseline?"
  read -r input
  if [[ "$input" == "y" ]]; then
    cp "$httpxfile" "$httpxbaseline"
  fi
fi

bash takeovercheck-l7.sh | tee -a "interesting-$httpxfile"
bash interesting.sh | tee -a "interesting-$httpxfile"