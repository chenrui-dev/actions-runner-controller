#!/bin/bash
################################################################################
##  File:  ruby.sh
##  Desc:  Installs Ruby requirements
################################################################################

apt-get install -yqq ruby-full > /dev/null
sudo gem update --system

# Install Ruby requirements
apt-get install -yqq libz-dev openssl libssl-dev > /dev/null
