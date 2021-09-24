#!/bin/sh

sudo sh -c 'apt clean all ; apt update ; apt install -y git'
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d
