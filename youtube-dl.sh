#!/bin/bash

read -p "Wie ist die URL? : " url
read -p "Soll ein Video heruntergeladen werden oder Audio? [audio/video] : " format
read -p "Wo sollen die Dateien heruntergeladen werden? : " pfad

if [ "$format" == "audio" ]
then
    format=251
else
    format=43
fi

cd $pfad
youtube-dl -i -f $format $url
