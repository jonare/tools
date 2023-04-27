#!/bin/bash

if [[ ! -f $1 ]]; then
	for d in */ ; do 
		(cd $d; recon.sh); 
	done
else
	directories=$(cat "$1");
	
	for dir in $directories; do
		(cd "$dir"; recon.sh);
	done < "$1"
fi
