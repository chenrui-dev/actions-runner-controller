#!/bin/bash
################################################################################
##  File:  basic.sh
##  Desc:  Installs basic command line utilities and dev packages
################################################################################

set -e

echo "Install dnsutils"
apt-get install -yqq --no-install-recommends dnsutils > /dev/null

echo "Install file"
apt-get install -yqq --no-install-recommends file > /dev/null

echo "Install ftp"
apt-get install -yqq --no-install-recommends ftp > /dev/null

echo "Install iproute2"
apt-get install -yqq --no-install-recommends iproute2 > /dev/null

echo "Install iputils-ping"
apt-get install -yqq --no-install-recommends iputils-ping > /dev/null

echo "Install jq"
apt-get install -yqq --no-install-recommends jq > /dev/null

echo "Install libcurl3"
apt-get install -yqq --no-install-recommends libcurl3 > /dev/null

echo "Install libunwind8"
apt-get install -yqq --no-install-recommends libunwind8 > /dev/null

echo "Install locales"
apt-get install -yqq --no-install-recommends locales > /dev/null

echo "Install netcat"
apt-get install -yqq --no-install-recommends netcat > /dev/null

echo "Install openssh-client"
apt-get install -yqq --no-install-recommends openssh-client > /dev/null

echo "Install rsync"
apt-get install -yqq --no-install-recommends rsync > /dev/null

echo "Install shellcheck"
apt-get install -yqq --no-install-recommends shellcheck > /dev/null

echo "Install sudo"
apt-get install -yqq --no-install-recommends sudo > /dev/null

echo "Install telnet"
apt-get install -yqq --no-install-recommends telnet > /dev/null

echo "Install time"
apt-get install -yqq --no-install-recommends time > /dev/null

echo "Install tzdata"
apt-get install -yqq --no-install-recommends tzdata > /dev/null

echo "Install unzip"
apt-get install -yqq --no-install-recommends unzip > /dev/null

echo "Install upx"
apt-get install -yqq --no-install-recommends upx > /dev/null

echo "Install wget"
apt-get install -yqq --no-install-recommends wget > /dev/null

echo "Install zip"
apt-get install -yqq --no-install-recommends zip > /dev/null

echo "Install zstd"
apt-get install -yqq --no-install-recommends zstd > /dev/null

echo "Install libxkbfile"
apt-get install -yqq --no-install-recommends libxkbfile-dev > /dev/null

echo "Install pkg-config"
apt-get install -yqq --no-install-recommends pkg-config > /dev/null

echo "Install libsecret-1-dev"
apt-get install -yqq --no-install-recommends libsecret-1-dev > /dev/null

echo "Install libxss1"
apt-get install -yqq --no-install-recommends libxss1 > /dev/null

echo "Install libgconf-2-4"
apt-get install -yqq --no-install-recommends libgconf-2-4 > /dev/null

echo "Install dbus"
apt-get install -yqq --no-install-recommends dbus > /dev/null

echo "Install xvfb"
apt-get install -yqq --no-install-recommends xvfb > /dev/null

echo "Install libgtk"
apt-get install -yqq --no-install-recommends libgtk-3-0 > /dev/null

echo "Install tk"
apt-get install -yqq tk > /dev/null

echo "Install fakeroot"
apt-get install -yqq --no-install-recommends fakeroot > /dev/null

echo "Install dpkg"
apt-get install -yqq --no-install-recommends dpkg > /dev/null

echo "Install rpm"
apt-get install -yqq --no-install-recommends rpm > /dev/null

echo "Install xz-utils"
apt-get install -yqq --no-install-recommends xz-utils > /dev/null

echo "Install xorriso"
apt-get install -yqq --no-install-recommends xorriso > /dev/null

echo "Install zsync"
apt-get install -yqq --no-install-recommends zsync > /dev/null

echo "Install curl"
apt-get install -yqq --no-install-recommends curl > /dev/null

echo "Install parallel"
apt-get install -yqq --no-install-recommends parallel > /dev/null

apt-get -y install gnupg gnupg2 gnupg1
apt-get -y install software-properties-common

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in curl file ftp jq netcat ssh parallel rsync shellcheck sudo telnet time unzip wget zip; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
