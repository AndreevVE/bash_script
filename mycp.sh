#!/bin/bash
set -e

if [ [ -z $2] ] ;then
echo "bad command"
exit 1
else

filename=$(basename"$1")
dname=$(dirname"$2")
echo $dname
mkdir -p "$dname"
echo  "Coping $1 to $dname/$filename"
cp "$1" "$dname/$filename"
fi
