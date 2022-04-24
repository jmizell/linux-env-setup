#!/bin/bash

source "./lib/install_helper.sh"
announce "Base Packages"
require_function apt-get

export DEBIAN_FRONTEND=noninteractive

packages='
build-essential
procps
curl
file
git
fuse
aptitude
jq
wget
gnupg
ncurses-bin
apt-utils
expect-dev
apt-transport-https
'

apt-get update
apt-get upgrade -y
apt-get install -y ${packages} || fail "could not install packages"
