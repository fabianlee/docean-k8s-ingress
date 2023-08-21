#!/bin/bash
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux

set -x

sudo apt update
sudo apt install apt-transport-https ca-certificates curl -y

# google cloud public signing key
minor_version="v1.28"
keyfile=/usr/share/keyrings/kubernetes-apt-keyring.gpg
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/$minor_version/deb/Release.key | sudo gpg --dearmor -o $keyfile
sudo chmod 644 $keyfile

echo "deb [signed-by=$keyfile] https://pkgs.k8s.io/core:/stable:/$minor_version/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubectl

