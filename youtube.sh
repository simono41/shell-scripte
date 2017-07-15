#!/bin/bash

set -ex

read -p "Haben sie eine url? : [URL/suche] " suche
if [ "$suche" == "suche" ]
then
read -p "Wie heißt das Stichwort? : " wort
else
read -p "Wie ist die URL? : " url
fi

read -p "Vollbild? : [Y/n] " vollbild
if [ "$vollbild" != "n" ]
then
voll="-fs"
fi

read -p "Soll ein Video heruntergeladen werden oder Audio? [opus/audio/video/BEST/60k] : " format

if [ "$format" == "opus" ]
then
    format="-f 251"
elif [ "$format" == "audio" ]
then
    format="-f 140"
elif [ "$format" == "video" ]
then
    format="-f 43"
elif [ "$format" == "60k" ]
then
    format="-f 303+251"
fi

if [ "$suche" == "suche" ]
then
youtube-dl "ytsearch:$wort" -q $format -o- | mplayer $voll -cache 8192 -
else
youtube-dl -q $format -o- $url | mplayer $voll -cache 8192 -
fi
