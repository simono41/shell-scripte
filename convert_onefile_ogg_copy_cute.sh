#!/bin/bash

set -ex

if [ -z "${cuts}" ]] ;then
  cuts=2
else
  cuts="$1"
  shift
fi
name=0

# wenn 100 daten und 3 cuts = 33 files
files="$(expr $# / $cuts)"
create=0
i=0

while (( "$#" ))
do

        #cutter
        if [ "$create" == "$i" ]; then
          create="$(expr $create + $files)"
          name="$(expr $name + 1)"
        fi
        i="$(expr $i + 1)"


        cd "${1%/*}" # gehe ins Verzeichnis

        FILENAME=${1##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"
        # guck dir die Ausgabe erstmal an - wenn alles passt kannst Du das "echo" weglassen
        # ffmpeg -i "$FILENAME" -vn -n -c:a libvorbis -b:a 192k "${FILENAME%.*}.ogg"
        cat "${FILENAME%.*}.ogg" >> onefile"$name".ogg
        shift
        cd -
done

#convert.sh <Ordner>/*.flv
#192k = -q 6

#cd -
#pwd
#ffmpeg -i onefile.ogg -acodec copy onefile-final.ogg
#rm onefile.ogg
