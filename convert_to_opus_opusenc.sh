#!/bin/bash

while (( "$#" ))
do

        cd "${1%/*}" # gehe ins Verzeichnis

        FILENAME=${1##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"
        # guck dir die Ausgabe erstmal an - wenn alles passt kannst Du das "echo" weglassen
        opusenc --bitrate 160 "$FILENAME" "${FILENAME%.*}.opus"
        shift
        cd -
done

#convert.sh <Ordner>/*.flac

#Es können ausschließlich WAVE, AIFF, FLAC und PCM-Rohdaten verarbeitet werden. 
