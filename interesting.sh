#!/bin/bash

if [[ -f $1 ]]; then
  dir=$1
else
  dir="output"
fi

declare -a fingerprints=(
                "/solr"
                )

for i in "${fingerprints[@]}"; do
   grep -lhr -F "$i" "$dir/" && echo -e "\e[1;32mINTERESTING PATTERN:\e[0m $i."
done