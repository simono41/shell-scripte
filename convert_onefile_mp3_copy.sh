#!/bin/bash

set -ex

while (( "$#" ))
do

        cd "${1%/*}" # gehe ins Verzeichnis

        FILENAME=${1##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"
        # guck dir die Ausgabe erstmal an - wenn alles passt kannst Du das "echo" weglassen
        #ffmpeg -i "$FILENAME" -vn -n -c:a copy "${FILENAME%.*}1.mp3"
        cat "${FILENAME%.*}.mp3" >> onefile.mp3
        shift
        cd -
done

cd -
pwd
ffmpeg -i onefile.mp3 -acodec copy onefile-final.mp3
rm onefile.mp3
