#!/bin/bash

source "./lib/install_helper.sh"
announce "System Packages"
require_function apt-get

export DEBIAN_FRONTEND=noninteractive

curl_download "https://deb.nodesource.com/gpgkey/nodesource.gpg.key" "/tmp/nodesource.gpg"
apt-key add "/tmp/nodesource.gpg" || fail "could not add node gpg key"
curl_download "https://xpra.org/gpg-2022.asc" "/tmp/xpra.gpg"
apt-key add "/tmp/xpra.gpg" || fail "could not add xpra gpg key"
curl_download "https://xpra.org/gpg-2018.asc" "/tmp/xpra.gpg"
apt-key add "/tmp/xpra.gpg" || fail "could not add xpra gpg key"
curl_download "https://xpra.org/gpg-2022.asc" "/tmp/xpra.gpg"
apt-key add "/tmp/xpra.gpg" || fail "could not add xpra gpg key"

echo "deb [arch=amd64] https://xpra.org/ bullseye main" > /etc/apt/sources.list.d/xpra.list

packages='apt-transport-https
bash-completion
build-essential
bzip2
ca-certificates
ca-certificates-java
colordiff
curl
default-libmysqlclient-dev
default-mysql-client
dkms
dmidecode
dmsetup
dnsutils
dosfstools
emacs
ethtool
fd-find
feh
file
git
git-annex
git-big-picture
git-cvs
git-extras
git-gui
git-lfs
git-man
git-secrets
git-svn
gnupg
grep
gzip
htop
httpie
iperf
iputils-ping
jq
libmagic-dev
libnotify-bin
libnss3-tools
libreoffice-calc
libreoffice-grammarcheck-en-us
libreoffice-writer
lsb-release
mariadb-client
meld
ncdu
neovim
net-tools
netcat-openbsd
nmap
nmap
nodejs
openssh-client
openssl
p7zip
p7zip-full
p7zip-rar
pciutils
pigz
pkg-config
pluma
postgresql-client
python3
python3-dev
python3-pip
redis-tools
remmina
remmina-plugin-nx
remmina-plugin-rdp
remmina-plugin-secret
remmina-plugin-spice
remmina-plugin-vnc
ripgrep
ristretto
rsync
ruby
ruby-dev
rubygems
sqlite3
sshuttle
sudo
tcpdump
telnet
terminator
tldr
tmux
traceroute
tree
unzip
vim
vim-common
vim-gtk
vim-runtime
wget
x11vnc
xauth
xdotool
xpra
xterm
xz-utils
yara
zenity
zenity-common
zim
zip
'

apt-get update || fail "could not update repo packages"
apt-get install -y ${packages} || fail "could not install packages"
