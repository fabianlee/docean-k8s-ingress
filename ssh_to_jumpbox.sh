#!/bin/bash

[ -f ansible_inventory ] || { echo "ERROR jumpbox1 file with ipv4 address not present yet"; exit 3; }

ipv4=$(grep -E '^jumpbox1 ' ansible_inventory | awk -F'ansible_host=' '{print $2}')
[ -n "$ipv4" ] || { echo "ERROR: could not lookup ip for jumpbox1 in ansible_inventory"; exit 3; } 

ssh root@${ipv4} -i tf/id_rsa
