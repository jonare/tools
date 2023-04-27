#!/bin/bash

if [[ ! -f $1 ]]; then
  file="subfinder-union.txt"
else
  file=$1
fi

httpxfile="httpx-$(date +%d%m%y-%H%M).txt"
httpxlatest="httpx-latest.txt"
interestingfile="interesting-$httpxfile"

if [[ ! -f "$httpxfile" ]]; then
  rm -rf "output"
  #httpx -title -status-code -tech-detect -l "$file" -o "$httpxfile" -threads 10 -sr -no-fallback-scheme -http-proxy http://localhost:4321
  httpx -title -follow-redirects -status-code -tech-detect -http2 -l "$file" -o "$httpxfile" -threads 10 -vhost -sr
  echo " --- "
fi

wc -l "$httpxfile"
[[ -f "$httpxlatest" ]] && wc -l "$httpxlatest"
ln -sf "$httpxfile" "$httpxlatest"

bash takeovercheck-l7.sh | tee -a "$interestingfile"
bash interesting.sh | tee -a "$interestingfile"
ln -sf "$interestingfile" "interesting-latest.txt"
