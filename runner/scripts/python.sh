#!/bin/bash
################################################################################
##  File:  python.sh
##  Desc:  Installs Python 2/3
################################################################################

# Install Python, Python 3, pip, pip3
apt-get install -yqq --no-install-recommends python python-dev python-pip python3 python3-dev python3-pip > /dev/null

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in python pip python3 pip3; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or not found on PATH"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
