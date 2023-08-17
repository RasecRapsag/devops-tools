#!/bin/sh
#
# Configurações do template
#
echo "Debian template..." && sleep 2

# Instalação de pacotes
apt update
apt -y install sudo cloud-init cloud-guest-utils
apt -y autoremove --purge
apt -y clean
apt -y autoclean
sync

# Configuração cloud-init
echo 'datasource_list: [ NoCloud, ConfigDrive, None ]' > /etc/cloud/cloud.cfg.d/99_pve.cfg
chmod 644 /etc/cloud/cloud.cfg.d/99_pve.cfg

# Limpando template
shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
unset HISTFILE; rm -rf /home/*/.*history /root/.*history
rm -f /root/.ssh/authorized_keys

# Configuração ssh
sed -r -i "s/^#?PermitRootLogin.*/PermitRootLogin no/g" /etc/ssh/sshd_config
sed -r -i "s/^#?PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config

# Desabilitando root
sudo passwd -d root
sudo passwd -l root
