#!/bin/bash

set -ex

# The service we want to check (according to systemctl)
SERVICE=openvpn-client@client.service

if [ "`systemctl is-active $SERVICE`" != "active" ]
then
  echo "$SERVICE wasnt running so attempting restart"
fi
echo "$SERVICE is currently running"
