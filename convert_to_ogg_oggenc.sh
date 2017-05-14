#!/bin/bash

while (( "$#" ))
do

        cd "${1%/*}" # gehe ins Verzeichnis

        FILENAME=${1##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"
        # guck dir die Ausgabe erstmal an - wenn alles passt kannst Du das "echo" weglassen
        oggenc -q 6 "$FILENAME"
        shift
        cd -
done

#convert.sh <Ordner>/*.flv
#192k = -q 6

#Unterstützte Formate
#WAVE
#AIFF
#Rohdaten
#FLAC (Nur lesend; vorhandene Metadaten (Tags) werden standardmäßig in die Vorbis-Datei übernommen)
