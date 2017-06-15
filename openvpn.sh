openvpn --config ~/linux.ovpn &
sleep 10
ip route add default dev tun0
