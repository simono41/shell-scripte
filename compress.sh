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
elif [ "restore" == "$1" ]; then
  pixz -d ${archiv} ${archiv/.pxz*}

  tar -xf ${archiv/.pxz*}
else
  echo "./compress.sh make/restore input/output"
fi
