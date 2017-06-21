#!/bin/bash

set -e

format=$(echo ${1##*.})
if [ $format != "jpg" ]
then
convert $1 /tmp/logo.jpg
else
cp $1 /tmp/logo.jpg
fi 
jp2a --background=dark --invert --colors /tmp/logo.jpg --output=/tmp/logo.txt
while IFS= read -r line; do
  echo "echo -e \"$line\""
done < /tmp/logo.txt
