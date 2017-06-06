#!/bin/bash

set -ex

read -p "Haben sie eine url? : [URL/suche] " suche
if [ "$suche" == "suche" ]
then
read -p "Wie heißt das Stichwort? : " wort
else
read -p "Wie ist die URL? : " url
fi
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

if [ "$suche" == "suche" ]
then
youtube-dl "ytsearch:$wort" -q $format -o- | mplayer -fs -cache 8192 -
else
youtube-dl -q $format -o- $url | mplayer -fs -cache 8192 -
fi
