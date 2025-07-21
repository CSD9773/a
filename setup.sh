#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install -y openssh-server

sudo sed -i 's/^#\?\(PermitRootLogin\s*\).*$/\1yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?\(PasswordAuthentication\s*\).*$/\1yes/' /etc/ssh/sshd_config

echo "root:1" | sudo chpasswd

sudo systemctl restart ssh

CONFIG_FILE="/etc/netplan/01-network-manager-all.yaml"

sudo cp "$CONFIG_FILE" "$CONFIG_FILE.bak"

sudo tee "$CONFIG_FILE" > /dev/null <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
EOF

sudo netplan apply

echo "✅ Done"
