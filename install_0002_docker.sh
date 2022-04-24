#!/bin/bash

source "./lib/install_helper.sh"
announce "Docker"
require_function apt-get
require_function aptitude

export DEBIAN_FRONTEND=noninteractive

echo "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" > /etc/apt/sources.list.d/docker.list

curl_download "https://download.docker.com/linux/debian/gpg" "/tmp/docker.gpg"
apt-key add "/tmp/docker.gpg" || fail "could not add docker gpg key"

apt-get update || fail "could not update repo packages"
apt-get install -y docker-ce docker-ce-cli containerd.io || fail "could not install packages"

if ! grep -q '^docker:' /etc/group; then
  groupadd docker || fail "could not add docker group"
fi