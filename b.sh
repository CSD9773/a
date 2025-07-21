#!/bin/bash

CONFIG_FILE="/etc/netplan/01-network-manager-all.yaml"
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
cat <<EOF > "$CONFIG_FILE"
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

netplan apply

echo "✅ Done"
