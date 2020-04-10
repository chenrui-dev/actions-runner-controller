#!/bin/bash
################################################################################
##  File:  bazel.sh
##  Desc:  Installs Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

# Install bazel
curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
apt-get update -y > /dev/null
apt-get install -yqq bazel > /dev/null

# Install bazelisk
npm install -g @bazel/bazelisk

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v bazel; then
    echo "Bazel was not installed"
    exit 1
fi

if ! command -v bazelisk; then
    echo "Bazelisk was not installed"
    exit 1
fi

# Document what was added to the image
bazelisk_version="$(bazelisk version 2>null | grep "Bazelisk version:" | cut -d "v" -f 3)"

echo "Lastly, documenting what we added to the metadata file"
