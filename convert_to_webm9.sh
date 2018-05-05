#!/bin/bash

while (( "$#" ))
do

        cd "${1%/*}" # gehe ins Verzeichnis

        FILENAME=${1##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"
        # guck dir die Ausgabe erstmal an - wenn alles passt kannst Du das "echo" weglassen
        ffmpeg -i "$FILENAME" -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libvorbis "${FILENAME%.*}.webm" &
        shift
        cd -
done

#convert.sh <Ordner>/*.flv
#192k = -q 6
