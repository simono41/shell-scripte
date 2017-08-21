#!/bin/bash

finds=$(find -name $1)

set -ex

i=0
for wort in $finds
do
        echo "$wort"

        FILENAME=${wort##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"

        cp $wort ""$2""$i""-""$FILENAME""
        i=$(expr ${i} + 1)
done

echo "Fertig!!!"

#./cp_onefile.sh onefile-final.mp3 /mnt1/
