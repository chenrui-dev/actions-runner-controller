#!/bin/bash
################################################################################
##  File:  java-tools.sh
##  Desc:  Installs Java and related tooling (Ant, Gradle, Maven)
################################################################################

DEFAULT_JDK_VERSION=8

set -e

# /runner/java-tools.sh: apt-fast: not found
# add-apt-repository ppa:apt-fast/stable
# apt-get update
# apt-get -y install apt-fast

# Install the Azul Systems Zulu JDKs
# See https://www.azul.com/downloads/azure-only/zulu/
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
apt-add-repository "deb http://repos.azul.com/azure-only/zulu/apt stable main"
apt-get -q update
apt-get -y install zulu-8-azure-jdk=\*
update-java-alternatives -s /usr/lib/jvm/zulu-8-azure-amd64
echo "JAVA_HOME_8_X64=/usr/lib/jvm/zulu-8-azure-amd64" | tee -a /etc/environment
echo "JAVA_HOME=/usr/lib/jvm/zulu-${DEFAULT_JDK_VERSION}-azure-amd64" | tee -a /etc/environment
echo "JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8" | tee -a /etc/environment

# Install Ant
apt install -y --no-install-recommends ant ant-optional
echo "ANT_HOME=/usr/share/ant" | tee -a /etc/environment

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in java javac ant; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or found on path"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
