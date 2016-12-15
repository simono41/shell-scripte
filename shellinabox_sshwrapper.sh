#!/bin/bash
# 
read -p "SSH remote host (hostname or ip address): " host;
#
read -p "SSH remote port [22]: " port;
#
read -p "SSH remote username: " username;
#
exec ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p $port $username@$host;
