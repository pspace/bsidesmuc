#!/bin/sh
DOCSTRING="Usage: ./setup-frida-android.sh -a TARGET_ARCHITECTURE [-b DIR_WITH_DOWNLOADED_BINARIES] [-n BINARY_NAME_ON_TARGET]"
NAME='frida-server'

ARCH='invalid'
BINDIR='frida-libs'

while [ "$1" != "" ];
do
case $1 in
    -a |--arch )
    shift
    ARCH=$1
    ;;
    -b |--bindir )
    shift
    BINDIR=$1
    ;;
    -n|--name)
    shift
    NAME=$1
    ;;
    -h|--help)
    echo $DOCSTRING
    exit
    ;;
    *)
    echo $1
    echo $DOCSTRING
    exit
    ;;
esac
shift
done

if [[ "$ARCH" = "invalid" ]]; then
    echo "No target architecture specified! $ARCH"
    echo $DOCSTRING
    exit -1
fi

if [[ -z "$NAME" ]]; then
  NAME='frida'
fi

VERSION=`cat $BINDIR/LATEST_RELEASE`

# Switch adb to root - this is required for the server binary to access other processes' memory
echo "Executing: adb root"
adb root

echo "Executing: adb push $BINDIR/frida-server-$VERSION-android-$ARCH /data/local/tmp/$NAME"
adb push $BINDIR/frida-server-$VERSION-android-$ARCH /data/local/tmp/$NAME

echo Executing: adb shell "chmod 755 /data/local/tmp/$NAME"
adb shell "chmod 755 /data/local/tmp/$NAME"

echo Executing: adb shell "/data/local/tmp/$NAME &"
adb shell "/data/local/tmp/$NAME" &

# check if everything worked
frida-ps -U
