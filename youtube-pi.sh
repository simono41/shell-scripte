#!/bin/bash

set -ex

if [ "$1" == "--help" ] || [[ -z "$1" ]]
then
    echo "bitte alles kleinschreiben"
    echo "bash ./youtube-dl.sh SUCHE/NOSUCHE URL/SUCHE FORMAT OUTPUT"
    echo "Formate: [opus/m4a/video/hd/fullhd/4k]"
    exit 0
fi

if [ "$1" == "suche" ] || [ "$1" == "nosuche" ]; then
    suche="$1"
    url="$2"
    format="$3"
    output="$4"
else
    url="$1"
    format="$2"
    output="$3"
fi

if [ -z ${output} ]; then
output="hdmi"
fi

#read -p "Wie ist die URL? : " url
#read -p "Wo sollen die Dateien heruntergeladen werden? : " pfad
#read -p "Soll ein Video heruntergeladen werden oder Audio? [opus/m4a/video/hd/fullhd/4k] : " format

if [ "$format" == "opus" ]
then
    format="-f 251"
elif [ "$format" == "m4a" ]
then
    format="-f 140"
elif [ "$format" == "video" ]
then
    format="-f 43"
elif [ "$format" == "hd" ]
then
    format="-f 247+251"
elif [ "$format" == "fullhd" ]
then
    format="-f 303+251"
elif [ "$format" == "4k" ]
then
    format="-f 315+251"
fi

if [ "$suche" == "suche" ]
then
  omxplayer -p -o ${output} `youtube-dl -g "ytsearch:$url" -q --force-ipv4 $format`
else
  omxplayer -p -o ${output} `youtube-dl -g $url -q --force-ipv4 $format`
fi
