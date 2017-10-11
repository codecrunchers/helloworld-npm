#!/bin/bash
sudo yum update -y
cd /tmp
curl -sO https://nodejs.org/dist/v6.11.4/node-v6.11.4-linux-x64.tar.xz
tar -xvf node-v6.11.4-linux-x64.tar.xz
rm node-v6.11.4-linux-x64.tar.xz
mkdir /opt/node
mv node-v6.11.4-linux-x64  /opt/node
sudo ln -s /opt//node/node-v6.11.4-linux-x64/bin/node /usr/bin/node
sudo ln -s /opt/node/node-v6.11.4-linux-x64/lib /usr/lib/node
sudo ln -s /opt/node/node-v6.11.4-linux-x64/bin/npm /usr/bin/npm

