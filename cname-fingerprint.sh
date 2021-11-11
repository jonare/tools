#!/bin/bash
fingerprints="cloudapp.net\|cloudapp.azure.com\|azurewebsites.net\|blob.core.windows.net\|cloudapp.azure.com\|azure-api.net\|azurehdinsight.net\|azurecontainer.io\|database.windows.net\|azuredatalakestore.net\|search.windows.net\|azurecr.io\|redis.cache.windows.net\|servicebus.windows.net\|visualstudio.com\|trafficmanager.net"

for i in "${fingerprints[@]}"; do
   # echo "$1" | grep -q "$i" && echo -e '\e[1;32mInteresting CNAME if nxdomain:\e[0m Name: "$1". Pattern: "$i". See https://github.com/EdOverflow/can-i-take-over-xyz/issues/35'
   echo "$1" | grep -q "$i" && echo -e 'Name: "$1". Pattern: "$i".'
	echo "$1"
done