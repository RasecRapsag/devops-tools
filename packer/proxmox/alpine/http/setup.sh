#!/bin/sh

set -ex

# Update apk repositories
sed -r -i '\|/v[0-9]+\.[0-9]+/community|s|^#\s?||g' /etc/apk/repositories
apk update

# Add qemu-guest-agent
apk add qemu-guest-agent
echo -e GA_PATH="/dev/vport2p1" >> /etc/conf.d/qemu-guest-agent
rc-update add qemu-guest-agent
rc-service qemu-guest-agent restart

# Update ssh configuration
sed -r -i "s/^#?PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -r -i "s/^#?PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

rc-service sshd restart
