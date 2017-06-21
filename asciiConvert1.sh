#!/bin/bash

: ${1?"Aufruf: $0 <ascii text Datei>"}
while read line; do
    escapedLine=$(echo $line | sed 's/\([$\"`]\)/\\\1/g')
    echo "echo -e \"$escapedLine\""
done < $1
