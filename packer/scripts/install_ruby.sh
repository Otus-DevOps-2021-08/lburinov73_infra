#!/bin/sh
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt update
apt install -y ruby-full ruby-bundler build-essential
