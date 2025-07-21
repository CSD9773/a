#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install -y openssh-server

sudo sed -i 's/^#\?\(PermitRootLogin\s*\).*$/\1yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?\(PasswordAuthentication\s*\).*$/\1yes/' /etc/ssh/sshd_config

echo "root:1" | sudo chpasswd

sudo systemctl restart ssh

echo "✅ Done"
