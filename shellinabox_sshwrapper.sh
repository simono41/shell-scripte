#!/bin/bash
# 
read -p "SSH remote host (hostname or ip address): " host;
#
read -p "If a puplic_key authentification?: N or y: " puplic;
#
read -p "SSH remote port (22): " port;
#
read -p "SSH remote username: " username;
#
if [ "$puplic" == "y" ];
  then
    read -p "Why it the public_key?: " key;
    echo $key > ~/.ssh/id_rsa.pub;

    rm ~/.ssh/id_rsa;
    echo "Give youre id her ein and when youre ready give finish ein.";
    while [ "$id" != "finish" ];
      do
      read -p "Why it the id_rsa key?: " id;
      echo $id >> ~/.ssh/id_rsa;
    done
    exec ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p $port $username@$host;
  else
    exec ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p $port $username@$host;
fi
