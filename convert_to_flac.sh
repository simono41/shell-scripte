#!/bin/bash

while (( "$#" ))
do

        cd "${1%/*}" # gehe ins Verzeichnis

        FILENAME=${1##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"
        # guck dir die Ausgabe erstmal an - wenn alles passt kannst Du das "echo" weglassen
        flac -2 "$FILENAME"
        shift
        cd -
done

#convert.sh <Ordner>/*.flv
#FLAC selbst unterstützt folgende Formate: WAVE, AIFF, PCM-Rohdaten und (nur lesend) Vorbis.
