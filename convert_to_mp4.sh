#!/bin/bash

while (( "$#" ))
do

        cd "${1%/*}" # gehe ins Verzeichnis

        FILENAME=${1##*/} # Dateiname ist alles ab dem letzten '/'
        echo "$FILENAME"
        # guck dir die Ausgabe erstmal an - wenn alles passt kannst Du das "echo" weglassen
        ffmpeg -i "$FILENAME" -c:v libx264 -preset slow -crf 22 -c:a copy "${FILENAME%.*}.mp4" &
        shift
        cd -
done

#convert.sh <Ordner>/*.flv
#192k = -q 6
#LAME Bitrate Overview
#lame option 	Average kbit/s 	Bitrate range kbit/s 	ffmpeg option
#-b 320 	320 	320 CBR (non VBR) example 	-b:a 320k (NB this is 32KB/s, or its max)
#-V 0 	245 	220-260 	-q:a 0 (NB this is VBR from 22 to 26 KB/s)
#-V 1 	225 	190-250 	-q:a 1
#-V 2 	190 	170-210 	-q:a 2
#-V 3 	175 	150-195 	-q:a 3
#-V 4 	165 	140-185 	-q:a 4
#-V 5 	130 	120-150 	-q:a 5
#-V 6 	115 	100-130 	-q:a 6
#-V 7 	100 	80-120 	-q:a 7
#-V 8 	85 	70-105 	-q:a 8
#-V 9 	65 	45-85 	-q:a 9
