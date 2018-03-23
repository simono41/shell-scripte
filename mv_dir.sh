#!/bin/bash

stichwort="$1"

while (( "$#" ))
do

	cd "${1%/*}" # gehe ins Verzeichnis

	FILENAME=${1##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"
        # guck dir die Ausgabe erstmal an - wenn alles passt kannst Du das "echo" weglassen
        mv "$FILENAME" "${FILENAME%-*}"

        shift
        cd -
done

#mv_dir.sh <Ordner>/*master
