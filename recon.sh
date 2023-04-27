#!/bin/bash

bash find.sh
("takeovercheck-dns.sh" "subfinder-union.txt")
bash visit.sh
cat httpx-latest.txt | cut -d' ' -f1 > check.txt
# sudo docker run --rm -it -v $(pwd):/tmp/EyeWitness eyewitness -f /tmp/EyeWitness/check.txt
