#!/bin/bash

set -ex

if [ "$1" == "--help" ] || [[ -z "$1" ]]
then
echo "bitte alles kleinschreiben"
echo "bash ./youtube-dl.sh SUCHE/NOSUCHE URL/SUCHE FORMAT VOLLBILD/NOVOLLBILD"
echo "Formate: [opus/m4a/video/hd/fullhd/4k]"
exit 0
fi

suche="$1"
url="$2"
format="$3"

if [ "$4" == "vollbild" ]
then
voll="-fs"
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
youtube-dl "ytsearch:$wort" -q --force-ipv4 $format -o- | mplayer $voll -cache 8192 -
else
youtube-dl -q --force-ipv4 $format -o- $url | mplayer $voll -cache 8192 -
fi
