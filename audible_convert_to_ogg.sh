#!/bin/bash

code="$1"
shift

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

#convert.sh code <Ordner>/*.ogg
