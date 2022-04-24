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

apt-get update || fail "could not update packages"
apt-get upgrade -y || fail "could not upgrade packages"
apt-get install -y ${packages} || fail "could not install packages"
