#!/bin/bash

set -ex

if [ "$1" == "--help" ] || [[ -z "$1" ]]
then
    echo "bitte alles kleinschreiben"
    echo "bash ./youtube-dl.sh SUCHE/NOSUCHE URL/SUCHE FORMAT OUTPUT"
    echo "Formate: [VERYLOW/LOW/MEDIUM/HIGH]"
    exit 0
fi

if [ "$1" == "suche" ] || [ "$1" == "nosuche" ]; then
    suche="$1"
    url="$2"
    format="$3"
    output="$4"
else
    url="$1"
    format="$2"
    output="$3"
fi

if [ -z ${output} ]; then
output="local"
fi

if [ "$format" == "verylow" ]
then
    format="-f 17"
elif [ "$format" == "low" ]
then
    format="-f 36"
elif [ "$format" == "medium" ]
then
    format="-f 18"
#elif [ "$format" == "high" ]
else
#then
    format="-f 22"
fi

#read -p "Wie ist die URL? : " url
#read -p "Wo sollen die Dateien heruntergeladen werden? : " pfad
#read -p "Soll ein Video heruntergeladen werden oder Audio? [opus/m4a/video/hd/fullhd/4k] : " format


if [ "$suche" == "suche" ]
then
  #omxplayer -p -o ${output} `youtube-dl -g "ytsearch:$url" -q --force-ipv4 $format`
  /usr/bin/omxplayer.bin -I -s -o ${output} --vol -800 --aspect-mode letterbox --no-osd `youtube-dl -g "ytsearch:$url" -q --force-ipv4 ${format}`
else
  #omxplayer -p -o ${output} `youtube-dl -g $url -q --force-ipv4 $format`
  /usr/bin/omxplayer.bin -I -s -o ${output} --vol -800 --aspect-mode letterbox --no-osd `youtube-dl -g $url -q --force-ipv4 ${format}`
fi
