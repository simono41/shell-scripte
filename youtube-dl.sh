#!/bin/bash

set -ex

read -p "Wie ist die URL? : " url
read -p "Wo sollen die Dateien heruntergeladen werden? : " pfad
read -p "Soll ein Video heruntergeladen werden oder Audio? [opus/audio/video/BEST/4k] : " format

if [ "$format" == "opus" ]
then
    format="-f 251"
elif [ "$format" == "audio" ]
then
    format="-f 140"
elif [ "$format" == "video" ]
then
    format="-f 43"
elif [ "$format" == "4k" ]
then
    format="-f 303+251"
fi

mkdir -p $pfad

cd $pfad
youtube-dl -i $format $url
