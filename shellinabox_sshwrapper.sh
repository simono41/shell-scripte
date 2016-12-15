#!/bin/bash
 
#
# get host
#
 
read -p "SSH remote host (hostname or ip address): " host;
 
if [ -z "$host" ]; then
    echo ""
    echo ""
    echo "A hostname or ip address of the remote host is required."
    echo ""
    echo ""
    exit
fi
 
if [ "$host" == "localhost" ] || [[ "$host" = "127."*  ]] || [[ "$host" = "0.0.0.0"  ]] || [[ "$host" = "10."*  ]] || [[ "$host" = "192.168."*  ]]; then
    echo ""
    echo ""
    echo "Connections to internal network devices are not supported."
    echo ""
    echo ""
    exit
fi
 
#
# get port
#
 
read -p "SSH remote port [22]: " port;
 
if [ -z "$port" ]; then
    port=22;
fi
 
if [[ -n ${port//[0-9]/} ]]; then
    echo ""
    echo ""
    echo "Port must be a number between 0 and 65535."
    echo ""
    echo ""
    exit
fi
 
#
# get username
#
 
read -p "SSH remote username: " username;
 
if [ -z "$username" ]; then
    echo ""
    echo ""
    echo "A username of the remote host is required."
    echo ""
    echo ""
    exit
fi
 
#
# execute ssh command
#
 
echo ""
echo ""
exec ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p $port $username@$host;
