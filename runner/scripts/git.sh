#!/bin/bash
################################################################################
##  File:  git.sh
##  Desc:  Installs Git
################################################################################

## Install git
add-apt-repository ppa:git-core/ppa -y
apt-get update > /dev/null
apt-get install -yqq git > /dev/null
git --version

# Install git-lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
apt-get install -yqq --no-install-recommends git-lfs > /dev/null

# Run tests to determine that the software installed as expected
echo "Testing git installation"
if ! command -v git; then
    echo "git was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, document the installed versions"
