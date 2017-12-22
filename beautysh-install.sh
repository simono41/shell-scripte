#!/bin/bash

set -ex

if [ -d /opt/beautysh ];then
    rm -Rv /opt/beautysh
    echo "Bereits vorhanden!!!"
fi
git clone https://github.com/bemeurer/beautysh /opt/beautysh
cd /opt/beautysh
python ./setup.py install
if [ -f /usr/bin/beautysh ];then
    rm /usr/bin/beautysh
fi
ln -s /opt/beautysh/beautysh/beautysh.py /usr/bin/beautysh
chmod +x /usr/bin/beautysh
cd /

