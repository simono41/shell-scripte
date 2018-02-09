#!/bin/bash

set -ex

echo "Schritt 1: Nutzer anlegen"

sudo adduser TeamSpeak --system --home /usr/local/bin/teamspeak3-server_linux_amd64 --disabled-login

echo "Schritt 2: Als TeamSpeak-User agieren"

su TeamSpeak --shell /bin/bash 

echo "Schritt 3: Herunterladen und entpacken"

cd /tmp
wget http://dl.4players.de/ts/releases/3.0.13/teamspeak3-server_linux_amd64-3.0.13.tar.bz2
tar -xjf teamspeak3-server_linux_amd64-3.0.13.tar.bz2 -C /usr/local/bin/
rm teamspeak3-server_linux_amd64-3.0.13.tar.bz2
cd ~

echo "Schritt 3: Konfiguration erstellen"

./ts3server createinifile=1
touch query_ip_blacklist.txt query_ip_whitelist.txt 

echo "Schritt 4: TS3-Server starten"

./ts3server_startscript.sh start inifile=ts3server.ini


echo "Schritt 5: Token merken"
