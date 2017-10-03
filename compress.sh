#!/bin/bash

set -ex

archiv=$2

if [ "make" == "$1" ]; then
  while (( "$(expr $# - 2)" ))
    do

  dateien="$3 ${dateien}"

  shift

  done

  tar -cf ${archiv}.tar ${dateien}
  pixz ${archiv}.tar ${archiv}.tar.pxz

  # säuberung
  rm ${archiv}.tar
elif [ "restore" == "$1" ]; then

  pixz -d ${archiv} ${archiv/.pxz*}

  tar -xf ${archiv/.pxz*}

  # säuberung
  rm ${archiv/.pxz*}
else
  echo "tar.pxz compress-script"
  echo "./compress.sh make/restore archivname input/output"
  echo "./compress.sh make archivname daten"
  echo "./compress.sh restore archivname"
fi
