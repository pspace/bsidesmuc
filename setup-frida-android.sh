#!/bin/sh
CWD=`pwd`

# create directory for binary content
mkdir -p frida-libs
cd frida-libs

# Get the latest version number
tmpfile=tmp.json
curl -s -X GET https://api.github.com/repos/frida/frida/tags -o $tmpfile
LATEST_RELEASE=`cat $tmpfile |grep name | head -1 |  sed 's/\"//g' |  sed 's/\,//g'|  gawk '{split($0,array,": ")} END{print array[2]}'`
rm $tmpfile

# Store it for the deplyment script to find the correct version
echo Updating frida to $LATEST_RELEASE
echo $LATEST_RELEASE > "LATEST_RELEASE"

# This depends on your preferences and how your distro/operating system names the pip binary
# Windows users will have to adjust this (if you use Pycharm you should be able to install Frida via Pycharms built-in package manager). 
sudo pip3 install frida --upgrade
# sudo pip2 install frida --upgrade

# we are inside frida-libs - clean up older versions
rm -f frida*

# download x86/x86_64/arm/arm64 server and gadget files - just add other architectures here
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-gadget-$LATEST_RELEASE-android-x86_64.so.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-gadget-$LATEST_RELEASE-android-x86.so.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-gadget-$LATEST_RELEASE-android-arm64.so.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-gadget-$LATEST_RELEASE-android-arm.so.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-server-$LATEST_RELEASE-android-x86_64.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-server-$LATEST_RELEASE-android-x86.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-server-$LATEST_RELEASE-android-arm64.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-server-$LATEST_RELEASE-android-arm.xz
# curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-gadget-$LATEST_RELEASE-linux-x86_64.so.xz
# curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-server-$LATEST_RELEASE-linux-x86_64.xz


# unpack the downloaded archives
for f in *.xz
do
  7z x "$f"
done
rm *.xz

# go back to where we started
cd "$CWD"
