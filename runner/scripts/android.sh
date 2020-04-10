#!/bin/bash
################################################################################
##  File:  android.sh
##  Desc:  Installs Android SDK
################################################################################

set -e

# Set env variable for SDK Root (https://developer.android.com/studio/command-line/variables)
ANDROID_ROOT=/usr/local/lib/android
ANDROID_SDK_ROOT=${ANDROID_ROOT}/sdk
echo "ANDROID_SDK_ROOT=${ANDROID_SDK_ROOT}" | tee -a /etc/environment

# ANDROID_HOME is deprecated, but older versions of Gradle rely on it
echo "ANDROID_HOME=${ANDROID_SDK_ROOT}" | tee -a /etc/environment

# Create android sdk directory
mkdir -p ${ANDROID_SDK_ROOT}

# Download the latest command line tools so that we can accept all of the licenses.
# See https://developer.android.com/studio/#command-tools
wget -O android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip android-sdk.zip -d ${ANDROID_SDK_ROOT}
rm -f android-sdk.zip

# Check sdk manager installation
/usr/local/lib/android/sdk/tools/bin/sdkmanager --list 1>/dev/null
if [ $? -eq 0 ]
then
    echo "Android SDK manager was installed"
else
    echo "Android SDK manager was not installed"
    exit 1
fi

# Install the following SDKs and build tools, passing in "y" to accept licenses.
echo "y" | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager \
    "platform-tools" \
    "platforms;android-29" \
    "platforms;android-28" \
    "platforms;android-21" \
    "build-tools;29.0.3" \
    "build-tools;29.0.2" \
    "build-tools;29.0.0" \
    "build-tools;28.0.3" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;google_play_services" \
    "add-ons;addon-google_apis-google-24" \
    "add-ons;addon-google_apis-google-23" \
    "add-ons;addon-google_apis-google-22" \
    "add-ons;addon-google_apis-google-21"
