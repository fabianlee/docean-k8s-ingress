#!/bin/bash

domain="do.fabianlee-lab.online"
if [ -n "$1" ]; then
  domain="$1"
fi
echo "using domain = $domain"

for h in foo.$domain ; do
  nslookup -timeout=1 $h
  if [ $? -ne 0 ]; then
    echo "WARN are you sure $h is DNS resolvable? did you add it to /etc/hosts?"
    #exit 3
  fi
done

curlopt="-k --fail --connect-timeout 3 --retry 0"
curl $curlopt https://foo.$domain
