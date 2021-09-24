#!/bin/sh

# repos
curl -s https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

# packages
sudo sh -c 'apt clean all ; apt update ; apt install -y mongodb-org ruby-full ruby-bundler build-essential git'

# services
sudo systemctl enable mongod --now

# app
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
