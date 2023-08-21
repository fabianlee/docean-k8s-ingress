#!/bin/bash
# https://docs.digitalocean.com/reference/doctl/how-to/install/

set -x

sudo apt install jq -y
doctl_ver=$(curl -sL https://api.github.com/repos/digitalocean/doctl/releases/latest | jq -r ".tag_name")

wget -4 https://github.com/digitalocean/doctl/releases/download/${doctl_ver}/doctl-${doctl_ver:1}-linux-amd64.tar.gz

tar xvfz doctl-${doctl_ver:1}-linux-amd64.tar.gz
sudo mv doctl /usr/local/bin/.
sudo chown root:root /usr/local/bin/doctl
rm -fr doctl-${doctl_ver:1}-linux-amd64.tar.gz
set +x

doctl version
echo ""
echo "==Next steps=="
echo "doctl auth init --context <tokenName>"
echo "doctl auth switch --context <tokenName>"
echo "doctl account get"

