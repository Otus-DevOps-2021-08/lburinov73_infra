#!/bin/env bash

yc compute instance create \
  --name reddit-app-full \
  --hostname reddit-app-full \
  --memory=2 \
  --create-boot-disk image-folder-id=b1g4httodue8h1h7tgnf,image-family=reddit-full,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --zone ru-central1-a \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/appuser.pub
