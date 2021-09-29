#!/bin/sh
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | apt-key add -
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list
apt update
apt install -y mongodb-org
systemctl enable mongod --now
