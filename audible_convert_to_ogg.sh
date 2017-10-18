#!/bin/bash

read -p "Wie heißen die activation_bytes? : " code

while (( "$#" ))
do

        cd "${1%/*}" # gehe ins Verzeichnis

        FILENAME=${1##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"
        # guck dir die Ausgabe erstmal an - wenn alles passt kannst Du das "echo" weglassen
        ffmpeg -activation_bytes $code -i "$FILENAME" -vn -n -c:a libvorbis -b:a 128k "${FILENAME%.*}.ogg"
        shift
        cd -
done

#convert.sh <Ordner>/*.flv
