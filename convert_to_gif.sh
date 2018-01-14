#!/bin/bash

set -ex

pfad="${1%/*}"
mkdir -p ${pfad}/frames

while (( "$#" ))
do

        cd "${1%/*}" # gehe ins Verzeichnis

        FILENAME=${1##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"
        # guck dir die Ausgabe erstmal an - wenn alles passt kannst Du das "echo" weglassen
        ffmpeg -i "$FILENAME" -vf scale=320:-1:flags=lanczos,fps=10 frames/ffout%03d.png
        shift
        cd -
done

convert -loop 0 ${pfad}/frames/ffout*.png output.gif
#convert.sh <Ordner>/*.mp4

