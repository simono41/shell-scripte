#!/bin/bash

set -ex

read -p "Wie ist die URL? : " url
read -p "Soll ein Video heruntergeladen werden oder Audio? [opus/audio/video/BEST] : " format

if [ "$format" == "opus" ]
then
    format="-f 251"
elif [ "$format" == "audio" ]
then
    format="-f 140"
elif [ "$format" == "video" ]
then
    format="-f 43"
fi

youtube-dl -q $format -o- $url | mplayer -cache 8192 -
