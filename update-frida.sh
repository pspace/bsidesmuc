#!/bin/sh
CWD=`pwd`

mkdir -p frida-libs
cd frida-libs
tmpfile=tmp.json
curl -s -X GET https://api.github.com/repos/frida/frida/tags -o $tmpfile
LATEST_RELEASE=`cat $tmpfile |grep name | head -1 |  sed 's/\"//g' |  sed 's/\,//g'|  gawk '{split($0,array,": ")} END{print array[2]}'`
rm $tmpfile
echo Updating frida to $LATEST_RELEASE
echo $LATEST_RELEASE > "LATEST_RELEASE"

#sudo pip install frida
sudo pip3 install frida --upgrade
sudo pip2 install frida --upgrade

rm -f frida*
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-gadget-$LATEST_RELEASE-android-x86_64.so.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-gadget-$LATEST_RELEASE-android-x86.so.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-gadget-$LATEST_RELEASE-android-arm64.so.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-gadget-$LATEST_RELEASE-android-arm.so.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-gadget-$LATEST_RELEASE-linux-x86_64.so.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-server-$LATEST_RELEASE-linux-x86_64.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-server-$LATEST_RELEASE-android-x86_64.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-server-$LATEST_RELEASE-android-x86.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-server-$LATEST_RELEASE-android-arm64.xz
curl -L -O -J https://github.com/frida/frida/releases/download/$LATEST_RELEASE/frida-server-$LATEST_RELEASE-android-arm.xz

for f in *.xz
do
  7z x "$f"
done
rm *.xz

cd "$CWD"
