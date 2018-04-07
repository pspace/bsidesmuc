#!/bin/sh
#https://koz.io/using-frida-on-android-without-root/
CWD=`pwd`

APKFILE='invalid'

DOCSTRING="Usage: ./unpack-apk.sh -d -f APKFILE"
while [ "$1" != "" ];
do
case $1 in
    -f |--file )
    shift
    APKFILE="$1"
    ;;
    -d )
    DECOMPILE=1
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


if [ ! -f $APKFILE ]; then
    echo "APK not found! Exiting!"
    exit -1
fi

PROJECT_DIR="${APKFILE%.*}"
EXTRACT_DIR="$PROJECT_DIR/extracted"
mkdir -p "$PROJECT_DIR"

APKBASENAME=`basename "$APKNAME"`

echo "Copying $APKFILE to $PROJECT_DIR"
cp "$APKFILE" "$PROJECT_DIR/$APKBASENAME"


if [ -d "$EXTRACT_DIR" ]; then rm -Rf "$EXTRACT_DIR"; fi

echo "Unpacking $APKFILE to $PROJECT_DIR/$APKBASENAME"
apktool d -f -o "$EXTRACT_DIR" $APKFILE

if [ $DECOMPILE ]; then
    echo "Decompile $APKFILE to $PROJECT_DIR/$APKBASENAME"
    jadx --export-gradle -d $EXTRACT_DIR $APKFILE
fi
