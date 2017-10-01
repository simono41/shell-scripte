#!/bin/bash

set -ex

#openvpn --config ~/linux.ovpn &
#sleep 10
#ip route add default dev tun0

echo "systemd start-script wird erzeugt!!!"
echo "Bitte OpenVPN config in die /etc/openvpn/client/client.conf kopieren!!!"
if [ -f /lib/systemd/system/openvpn-client@client.service ]; then
echo "link vorhanden!"
else
ln /lib/systemd/system/openvpn-client@.service /lib/systemd/system/openvpn-client@client.service
fi
systemctl enable openvpn-client@client.service

