#!/bin/sh

echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt update && apt install -y git
git clone https://github.com/express42/reddit.git
cd reddit && bundle install

cat << EOF >/etc/systemd/system/puma.service
[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/reddit
Environment=RAILS_ENV=production

ExecStart=/usr/bin/bundle exec puma
Restart=always
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable puma --now
